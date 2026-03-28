# Loot Browser — Design Spec

**Date:** 2026-03-28
**Status:** Approved
**Author:** TrefnyTrunek + Claude

## Overview

Osobne okno w addonie BiS Helper do przeglądania itemów z M+ Midnight Season 1. Gracz może przeszukiwać 190 itemów po nazwie, slocie, armor type, dungeonie i statach. Hover pokazuje GameTooltip, klik kopiuje itemID.

## Dane

Źródło: `tools/mplus_loot_midnight_s1.json` (190 itemów zescrapowanych z Wowhead).

Nowy plik `addon/data/mplus_loot.lua` generowany skryptem `tools/generate_loot_lua.py`:

```lua
BiSHelper_MplusLoot = {
    season = "Midnight Season 1",
    items = {
        { itemID=49823, name="Cloak of the Fallen Cardinal", slot="Back",
          armorType=nil, weaponType=nil, stats="Crit / Vers",
          dungeon="Pit of Saron", boss="Scourgelord Tyrannus" },
        -- ... 190 wpisów
    },
}
```

- Flat lista — łatwe do filtrowania w Lua
- Staty w uproszczonym formacie tekstowym ("Haste / Crit")
- Accessories (neck, ring, trinket, cloak) i weapons — `armorType = nil`
- TOC ładuje `data/mplus_loot.lua` przed `BiS_Helper.lua`

## UI — okno Loot Browser

Nowy panel `CreateLootBrowserFrame()` w `BiS_Helper.lua`.

### Parametry okna
- **Rozmiar:** ~720×500px, stały
- **Pozycja:** CENTER, draggable
- **Backdrop:** identyczny z resztą paneli — BackdropTemplate, paleta P (Silvermoon motyw)

### Layout (od góry)
1. **Header** — "Loot Browser — Midnight S1 M+" + close button (UIPanelCloseButton)
2. **Filter bar** — jeden rząd: search box + 4 dropdowny + licznik wyników
3. **Column headers** — ITEM | SLOT | STATS | DUNGEON | BOSS (złoty tekst)
4. **Scroll frame** — wiersze kompaktowe (ROW_H ~24px), pool ~18 widocznych wierszy
5. **Footer** — hint tekst: "Hover: tooltip | Click: copy itemID"

### Wiersz itemu (kompaktowy)
- Ikona (20×20) | Nazwa (epic purple) | Slot (szary) | Staty (jasny szary) | Dungeon (złoty) | Boss (ciemny szary)
- Naprzemienne tła wierszy (ciemne/jaśniejsze, jak w głównym oknie)

### Filtry
| Filtr | Typ | Domyślna wartość | Przeszukuje |
|-------|-----|------------------|-------------|
| Search | EditBox | pusty | `name` (case-insensitive substring) |
| Slot | Custom dropdown (przycisk + lista opcji w frame) | All | `slot` field |
| Armor Type | Custom dropdown | klasa gracza (np. Cloth dla Mage) | `armorType` field |
| Dungeon | Custom dropdown | All | `dungeon` field |
| Stat | Custom dropdown | All | `stats` field (substring) |

**Armor Type dropdown** — domyślnie ustawiony na armor type klasy gracza:
```lua
local CLASS_ARMOR = {
    MAGE="Cloth", PRIEST="Cloth", WARLOCK="Cloth",
    MONK="Leather", ROGUE="Leather", DRUID="Leather",
    DEMONHUNTER="Leather", EVOKER="Mail", HUNTER="Mail",
    SHAMAN="Mail", WARRIOR="Plate", PALADIN="Plate",
    DEATHKNIGHT="Plate",
}
```

**Slot dropdown opcje:** All, Head, Neck, Shoulder, Back, Chest, Wrist, Hands, Waist, Legs, Feet, Finger, Trinket, Weapon (grupuje Main Hand, Off Hand, One-Hand, Two-Hand, Ranged)

**Dungeon dropdown opcje:** All, Algeth'ar Academy, Magister's Terrace, Maisara Caverns, Nexus-Point Xenas, Pit of Saron, Seat of the Triumvirate, Skyreach, Windrunner Spire

**Stat dropdown opcje:** All, Crit, Haste, Mastery, Versatility

**Logika filtrowania:** Przy każdej zmianie filtra — iteracja po `BiSHelper_MplusLoot.items`, zastosowanie wszystkich aktywnych filtrów (AND), przebudowa widocznych wierszy.

Specjalna reguła dla Armor Type: gdy filtr != "All", pokaż też itemy z `armorType == nil` (accessories, weapons), bo te może nosić każda klasa.

### Interakcje
- **Hover** na wiersz → `GameTooltip:SetItemByID(itemID)`
- **Klik** na wiersz → istniejący `CopyPopup` z itemID (ten sam co w głównym oknie)

## Integracja z addonem

### Otwieranie
- Przycisk **"Loot"** w toolbarze głównego okna (via `ToolbarBtn()`)
- Slash command `/bis loot` — subcommand w istniejącym handlerze
- Oba wywołują `BiSHelper_OpenLootBrowser()` — lazy creation jak inne panele

### Pliki

**Nowe:**
- `addon/data/mplus_loot.lua` — dane loot (generowane z JSON)
- `tools/generate_loot_lua.py` — skrypt generujący Lua z JSON

**Zmodyfikowane:**
- `addon/BiS_Helper.lua` — CreateLootBrowserFrame, przycisk Loot, slash subcommand
- `addon/BiS_Helper.toc` — dodanie `data/mplus_loot.lua`

### Bez zmian
- Główne okno (tryby Raid/M+, filtry, refresh)
- Panele Edit/Stats/Settings/Profiles/Help/Share
- Dane BiS per spec (`data/<class>_<spec>.lua`)

## Poza scope (v1)
- Sortowanie kolumn po kliknięciu nagłówka
- Porównanie z equipped itemem
- "Set as BiS" z loot browsera
- Filtr po weapon type
- Automatyczny scraping / aktualizacja w runtime
- Raid loot (na razie tylko M+)
