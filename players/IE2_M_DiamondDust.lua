-- Beluga
local Beluga = {
    name = "Beluga",
    pos = { x = 6, y = 14 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, --
    pools = { ["DiamondDust"] = true },
    cost = 7,
    atlas = "Jokers02",
    ptype = C.Wind,
    pposition = C.MF,
    techtype = C.UPGRADES.Plus,
    pteam = "Polvo de Diamantes",
    blueprint_compat = true,
    calculate = function(self, card, context)
    end
}

-- Icer
local Icer = {
    name = "Icer",
    pos = { x = 10, y = 14 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, --
    pools = { ["DiamondDust"] = true },
    cost = 7,
    atlas = "Jokers02",
    ptype = C.Wind,
    pposition = C.MF,
    techtype = C.UPGRADES.Plus,
    pteam = "Polvo de Diamantes",
    blueprint_compat = true,
    calculate = function(self, card, context)
    end
}

-- Gazelle
local Gazelle = {
    name = "Gazelle",
    pos = { x = 7, y = 0 },
    soul_pos = { x = 7, y = 1 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = "ina_top", -- Destacado
    pools = { ["DiamondDust"] = true },
    cost = 15,
    atlas = "top",
    ptype = C.Wind,
    pposition = C.FW,
    techtype = C.UPGRADES.Grade,
    pteam = "Polvo de Diamantes",
    blueprint_compat = true,
    calculate = function(self, card, context)
    end
}

return {
    name = "Diamond Dust",
    list = {}
    -- list = { Beluga, Icer, Gazelle },
}
