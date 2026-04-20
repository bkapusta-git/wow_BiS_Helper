-- ============================================================
-- themes.lua — rejestr motywów BiS Helper
-- ============================================================
-- Każdy motyw musi definiować wszystkie klucze z REQUIRED_KEYS poniżej.
-- Motywy żyją w addon namespace: ns.Themes[<key>]. BiS_Helper.lua
-- w ADDON_LOADED wywołuje ApplyActiveTheme(), która przypisuje
-- wybrany motyw do forward-declared `local P`.
-- ============================================================

local addonName, ns = ...
ns.Themes = ns.Themes or {}

-- ============================================================
-- Silvermoon (Sin'dorei warm mahogany & gold) — motyw domyślny
-- ============================================================
ns.Themes.silvermoon = {
    name = "Silvermoon",

    -- Backgrounds ({r, g, b, a})
    bg         = { 0.08, 0.04, 0.03, 0.97 },  -- panel bg
    bgSolid    = { 0.08, 0.04, 0.03, 1.00 },  -- inputy, editboxy
    bgOverlay  = { 0.08, 0.04, 0.03, 0.90 },  -- footer track, button dim
    bgDeep     = { 0.05, 0.02, 0.02, 0.95 },  -- nameBox edit, profile rows
    bgCard     = { 0.13, 0.07, 0.06, 1.00 },  -- tła przycisków/kart
    bgCardAlt  = { 0.10, 0.05, 0.04, 1.00 },  -- naprzemienne wiersze
    bgHeader   = { 0.15, 0.08, 0.07, 1.00 },  -- pasek nagłówka
    bgHover    = { 0.25, 0.12, 0.08, 0.95 },  -- hover na przyciskach
    bgBar      = { 0.10, 0.05, 0.04, 0.90 },  -- track stat bars (DR)
    bgIlvl     = { 0.15, 0.08, 0.06, 0.85 },  -- podkład ilvl w wierszu

    -- Borders ({r, g, b, a})
    gold       = { 0.85, 0.68, 0.25, 0.90 },
    goldDim    = { 0.55, 0.40, 0.15, 0.45 },

    -- Border resources
    borderFile = "Interface/Tooltips/UI-Tooltip-Border",
    borderSize = 16,

    -- Status ({r, g, b, a})
    neonGreen  = { 0.30, 0.88, 0.40, 1.00 },
    neonRed    = { 0.90, 0.22, 0.18, 1.00 },
    neonGrey   = { 0.30, 0.22, 0.20, 1.00 },
    glowGreen  = { 0.30, 0.88, 0.40, 0.14 },
    glowRed    = { 0.90, 0.22, 0.18, 0.10 },

    -- Text (hex stringi "|cffRRGGBB")
    tGold      = "|cfff5c842",
    tCream     = "|cffeddcc8",
    tDim       = "|cff8a7262",
    tWhite     = "|cfff0e6d8",
    tBiS       = "|cff4ee050",
    tMissing   = "|cffe63830",

    -- Text (rgb {r,g,b,a} do SetTextColor)
    cream      = { 0.93, 0.84, 0.72, 1.00 },
    textDim    = { 0.54, 0.45, 0.38, 1.00 },  -- rgb odpowiednik tDim (dla GameTooltip:AddLine)
}

-- ============================================================
-- Walidator kontraktu
-- ============================================================
local REQUIRED_KEYS = {
    "name",
    "bg", "bgSolid", "bgOverlay", "bgDeep", "bgCard", "bgCardAlt", "bgHeader",
    "bgHover", "bgBar", "bgIlvl",
    "gold", "goldDim",
    "borderFile", "borderSize",
    "neonGreen", "neonRed", "neonGrey", "glowGreen", "glowRed",
    "tGold", "tCream", "tDim", "tWhite", "tBiS", "tMissing",
    "cream", "textDim",
}

local function validate(theme)
    for _, k in ipairs(REQUIRED_KEYS) do
        if theme[k] == nil then
            error("BiS Helper theme '" .. tostring(theme.name or "?") .. "' missing key: " .. k)
        end
    end
end

validate(ns.Themes.silvermoon)

-- ============================================================
-- ElvUI Dark (neutral dark grey) — motyw ciemny
-- NOTE on key names: "gold", "goldDim", "tGold" are semantic tokens
-- inherited from the silvermoon theme. They represent the PRIMARY
-- ACCENT color of the theme, not literally gold. BiS_Helper.lua
-- references P.gold / P.tGold in dozens of call-sites — renaming
-- would require updating all of them. In non-silvermoon themes these
-- keys simply hold the theme's chosen accent color.
-- ============================================================
ns.Themes.elvui = {
    name = "Gray",

    -- Backgrounds ({r, g, b, a})
    bg         = { 0.07, 0.07, 0.07, 0.97 },
    bgSolid    = { 0.07, 0.07, 0.07, 1.00 },
    bgOverlay  = { 0.07, 0.07, 0.07, 0.90 },
    bgDeep     = { 0.04, 0.04, 0.04, 0.95 },
    bgCard     = { 0.12, 0.12, 0.12, 1.00 },
    bgCardAlt  = { 0.09, 0.09, 0.09, 1.00 },
    bgHeader   = { 0.15, 0.15, 0.15, 1.00 },
    bgHover    = { 0.22, 0.22, 0.22, 0.95 },
    bgBar      = { 0.09, 0.09, 0.09, 0.90 },
    bgIlvl     = { 0.15, 0.15, 0.15, 0.85 },

    -- Borders ({r, g, b, a})
    -- "gold" / "goldDim" = primary accent tokens (grey in this theme)
    gold       = { 0.50, 0.50, 0.50, 0.90 },
    goldDim    = { 0.28, 0.28, 0.28, 0.45 },

    -- Border resources
    borderFile = "Interface/Tooltips/UI-Tooltip-Border",
    borderSize = 16,

    -- Status ({r, g, b, a})
    neonGreen  = { 0.30, 0.88, 0.40, 1.00 },
    neonRed    = { 0.90, 0.22, 0.18, 1.00 },
    neonGrey   = { 0.25, 0.25, 0.28, 1.00 },
    glowGreen  = { 0.30, 0.88, 0.40, 0.14 },
    glowRed    = { 0.90, 0.22, 0.18, 0.10 },

    -- Text (hex stringi "|cffRRGGBB")
    -- "tGold" = primary accent label color token (light grey in this theme)
    tGold      = "|cffc8c8c8",
    tCream     = "|cffe8e8e8",
    tDim       = "|cff888888",
    tWhite     = "|cffffffff",
    tBiS       = "|cff4ee050",
    tMissing   = "|cffe63830",

    -- Text (rgb {r,g,b,a} do SetTextColor)
    cream      = { 0.88, 0.88, 0.88, 1.00 },
    textDim    = { 0.53, 0.53, 0.53, 1.00 },
}

validate(ns.Themes.elvui)

-- ============================================================
-- Kaldorei (Night Elf moonlit — deep indigo + moonsilver)
-- "gold"/"goldDim"/"tGold" = semantic accent tokens (moonsilver here)
-- ============================================================
ns.Themes.kaldorei = {
    name = "Kaldorei",

    -- Backgrounds ({r, g, b, a})
    bg         = { 0.05, 0.04, 0.10, 0.97 },
    bgSolid    = { 0.05, 0.04, 0.10, 1.00 },
    bgOverlay  = { 0.05, 0.04, 0.10, 0.90 },
    bgDeep     = { 0.03, 0.02, 0.07, 0.95 },
    bgCard     = { 0.11, 0.08, 0.18, 1.00 },
    bgCardAlt  = { 0.08, 0.06, 0.14, 1.00 },
    bgHeader   = { 0.14, 0.10, 0.22, 1.00 },
    bgHover    = { 0.20, 0.14, 0.32, 0.95 },
    bgBar      = { 0.08, 0.06, 0.14, 0.90 },
    bgIlvl     = { 0.13, 0.10, 0.20, 0.85 },

    -- Borders (accent = moonsilver blue)
    gold       = { 0.65, 0.78, 0.95, 0.90 },
    goldDim    = { 0.35, 0.45, 0.58, 0.45 },

    -- Border resources
    borderFile = "Interface/Tooltips/UI-Tooltip-Border",
    borderSize = 16,

    -- Status ({r, g, b, a})
    neonGreen  = { 0.30, 0.88, 0.40, 1.00 },
    neonRed    = { 0.90, 0.22, 0.18, 1.00 },
    neonGrey   = { 0.25, 0.22, 0.35, 1.00 },
    glowGreen  = { 0.30, 0.88, 0.40, 0.14 },
    glowRed    = { 0.90, 0.22, 0.18, 0.10 },

    -- Text (hex stringi "|cffRRGGBB")
    tGold      = "|cffaabfe8",  -- moonsilver blue
    tCream     = "|cffe0e8f8",  -- cool white
    tDim       = "|cff7878a8",  -- dim blue-grey
    tWhite     = "|cffe8f0ff",  -- cold white
    tBiS       = "|cff4ee050",
    tMissing   = "|cffe63830",

    -- Text (rgb {r,g,b,a} do SetTextColor)
    cream      = { 0.82, 0.88, 0.96, 1.00 },
    textDim    = { 0.47, 0.47, 0.66, 1.00 },  -- dim blue-grey (rgb odpowiednik tDim)
}

validate(ns.Themes.kaldorei)

-- ============================================================
-- Frost (Northrend icy navy — near-black navy + icy blue)
-- "gold"/"goldDim"/"tGold" = semantic accent tokens (icy blue here)
-- ============================================================
ns.Themes.frost = {
    name = "Frost",

    -- Backgrounds ({r, g, b, a})
    bg         = { 0.04, 0.05, 0.09, 0.97 },
    bgSolid    = { 0.04, 0.05, 0.09, 1.00 },
    bgOverlay  = { 0.04, 0.05, 0.09, 0.90 },
    bgDeep     = { 0.02, 0.03, 0.07, 0.95 },
    bgCard     = { 0.08, 0.11, 0.17, 1.00 },
    bgCardAlt  = { 0.06, 0.08, 0.14, 1.00 },
    bgHeader   = { 0.10, 0.14, 0.22, 1.00 },
    bgHover    = { 0.14, 0.20, 0.32, 0.95 },
    bgBar      = { 0.06, 0.08, 0.14, 0.90 },
    bgIlvl     = { 0.09, 0.12, 0.18, 0.85 },

    -- Borders (accent = icy blue)
    gold       = { 0.35, 0.70, 0.95, 0.90 },
    goldDim    = { 0.20, 0.40, 0.58, 0.45 },

    -- Border resources
    borderFile = "Interface/Tooltips/UI-Tooltip-Border",
    borderSize = 16,

    -- Status ({r, g, b, a})
    neonGreen  = { 0.30, 0.88, 0.40, 1.00 },
    neonRed    = { 0.90, 0.22, 0.18, 1.00 },
    neonGrey   = { 0.22, 0.28, 0.38, 1.00 },
    glowGreen  = { 0.30, 0.88, 0.40, 0.14 },
    glowRed    = { 0.90, 0.22, 0.18, 0.10 },

    -- Text (hex stringi "|cffRRGGBB")
    tGold      = "|cff58b8f5",  -- icy blue
    tCream     = "|cffd8e8f8",  -- cold cream
    tDim       = "|cff6878a0",  -- blue-grey dim
    tWhite     = "|cffe8f4ff",  -- cold white
    tBiS       = "|cff4ee050",
    tMissing   = "|cffe63830",

    -- Text (rgb {r,g,b,a} do SetTextColor)
    cream      = { 0.80, 0.88, 0.96, 1.00 },
    textDim    = { 0.41, 0.47, 0.63, 1.00 },  -- blue-grey dim (rgb odpowiednik tDim)
}

validate(ns.Themes.frost)

-- ============================================================
-- Ember (forge volcanic — near-black charcoal + warm amber)
-- "gold"/"goldDim"/"tGold" = semantic accent tokens (amber here)
-- ============================================================
ns.Themes.ember = {
    name = "Ember",

    -- Backgrounds ({r, g, b, a})
    bg         = { 0.07, 0.05, 0.04, 0.97 },
    bgSolid    = { 0.07, 0.05, 0.04, 1.00 },
    bgOverlay  = { 0.07, 0.05, 0.04, 0.90 },
    bgDeep     = { 0.04, 0.03, 0.02, 0.95 },
    bgCard     = { 0.12, 0.09, 0.07, 1.00 },
    bgCardAlt  = { 0.09, 0.07, 0.05, 1.00 },
    bgHeader   = { 0.16, 0.12, 0.09, 1.00 },
    bgHover    = { 0.24, 0.16, 0.10, 0.95 },
    bgBar      = { 0.09, 0.07, 0.05, 0.90 },
    bgIlvl     = { 0.14, 0.10, 0.08, 0.85 },

    -- Borders (accent = warm amber)
    gold       = { 0.85, 0.52, 0.18, 0.90 },
    goldDim    = { 0.48, 0.28, 0.10, 0.45 },

    -- Border resources
    borderFile = "Interface/Tooltips/UI-Tooltip-Border",
    borderSize = 16,

    -- Status ({r, g, b, a})
    neonGreen  = { 0.30, 0.88, 0.40, 1.00 },
    neonRed    = { 0.90, 0.22, 0.18, 1.00 },
    neonGrey   = { 0.30, 0.24, 0.20, 1.00 },
    glowGreen  = { 0.30, 0.88, 0.40, 0.14 },
    glowRed    = { 0.90, 0.22, 0.18, 0.10 },

    -- Text (hex stringi "|cffRRGGBB")
    tGold      = "|cffe89640",  -- warm amber
    tCream     = "|cffede0cc",  -- warm cream
    tDim       = "|cff8a7060",  -- warm dim
    tWhite     = "|cfff0e8da",  -- warm white
    tBiS       = "|cff4ee050",
    tMissing   = "|cffe63830",

    -- Text (rgb {r,g,b,a} do SetTextColor)
    cream      = { 0.92, 0.82, 0.68, 1.00 },
    textDim    = { 0.54, 0.44, 0.38, 1.00 },  -- warm dim (rgb odpowiednik tDim)
}

validate(ns.Themes.ember)
