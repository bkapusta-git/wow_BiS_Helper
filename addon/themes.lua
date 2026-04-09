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
    "cream",
}

local function validate(theme)
    for _, k in ipairs(REQUIRED_KEYS) do
        if theme[k] == nil then
            error("BiS Helper theme '" .. tostring(theme.name or "?") .. "' missing key: " .. k)
        end
    end
end

validate(ns.Themes.silvermoon)
