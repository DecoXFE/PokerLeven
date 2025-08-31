-- Torch
local Torch = {
    name = "Torch",
    pos = { x = 6, y = 0 },
    soul_pos = { x = 6, y = 1 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = "ina_top", -- Destacado
    pools = { ["Prominence"] = true },
    cost = 15,
    atlas = "top",
    ptype = C.Fire,
    pposition = C.FW,
    techtype = C.UPGRADES.NumberType.A,
    pteam = "Prominence",
    blueprint_compat = true,
    calculate = function(self, card, context)
    end
}

return {
    name = "Prominence",
    list = {}
    -- list = { Torch },
}
