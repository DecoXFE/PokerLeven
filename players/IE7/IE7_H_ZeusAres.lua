-- Hades
local Hades = J({
    name = "Hades",
    pos = { x = 7, y = 3 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, -- Common / Uncommon
    pools = { ["Zeus_Ares"] = true },
    cost = 5,
    atlas = "Jokers07",
    ptype = C.Wind,
    pposition = C.DF,
    techtype = C.UPGRADES.Plus,
    pteam = "ina_team_Zeus_Ares",
    blueprint_compat = false,
    calculate = function(self, card, ctx)
})

-- Perseus
local Perseus = J({
    name = "Perseus",
    pos = { x = 8, y = 3 },
    config = { extra = { mult_gain = 3, current_mult = 0, hands_since = 0 } },
    loc_vars = function(self, info_queue, center) return {} end,
    rarity = 2, -- Uncommon
    pools = { ["Zeus_Ares"] = true },
    cost = 6,
    atlas = "Jokers07",
    ptype = C.Fire,
    pposition = C.FW,
    techtype = C.UPGRADES.Plus,
    pteam = "Zeus",
    blueprint_compat = true,
    calculate = function(self, card, ctx)
})

return {
    name = "Zeus_Ares",
    list = { Perseus }
}
