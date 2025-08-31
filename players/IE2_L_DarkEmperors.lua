-- Nathan
local NathanDark = {
    name = "Nathan Swift",
    pos = { x = 8, y = 0 },
    soul_pos = { x = 8, y = 1 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = "ina_top", -- Destacado
    pools = { ["darkemperors"] = true },
    cost = 15,
    atlas = "top",
    ptype = C.Wind,
    pposition = C.FW,
    techtype = C.UPGRADES.Plus,
    pteam = "Emperadores Oscuros",
    blueprint_compat = true,
    calculate = function(self, card, context)
    end
}

return {
    name = "Emperadores Oscuros",
    list = {}
    -- list = { NathanDark },
}
