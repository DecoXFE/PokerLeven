-- ropes
local ropes = J({
  name = "ropes",
  pos = { x = 3, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.GK,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- downtown
local downtown = J({
  name = "Downtown",
  pos = { x = 4, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- bindings
local bindings = J({
  name = "Bindings",
  pos = { x = 5, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.DF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- gleeson
local gleeson = J({
  name = "Gleeson",
  pos = { x = 6, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.DF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- snowfield
local snowfield = J({
  name = "Snowfield",
  pos = { x = 7, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Mountain,
  pposition = C.DF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- bootgaiter
local bootgaiter = J({
  name = "Bootgaiter",
  pos = { x = 8, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- maddox
local maddox = J({
  name = "Maddox",
  pos = { x = 9, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.MF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- skipolson
local skipolson = J({
  name = "Skipolson",
  pos = { x = 10, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.MF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- shawn
local shawn = J({
  name = "Shawn Froste",
  pos = { x = 11, y = 2 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.FW,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- climbstein
local climbstein = J({
  name = "Climbstein",
  pos = { x = 1, y = 3 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.FW,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Rackner
local rackner = J({
  name = "Rackner",
  pos = { x = 2, y = 3 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- peggs
local peggs = J({
  name = "Peggs",
  pos = { x = 3, y = 3 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Mountain,
  pposition = C.GK,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Ursus
local ursus = J({
  name = "Ursus",
  pos = { x = 4, y = 3 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.DF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Bogg
local bogg = J({
  name = "Bogg",
  pos = { x = 5, y = 3 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- strata
local strata = J({
  name = "Strata",
  pos = { x = 6, y = 3 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- onlign
local onlign = J({
  name = "Onlign",
  pos = { x = 7, y = 3 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Alpine"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Alpino",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

return {
  name = "Alpine",
  list = {}
  -- list = { ropes, downtown, bindings, gleeson, snowfield, bootgaiter, maddox, skipolson, shawn, climbstein, rackner, peggs, ursus, bogg, strata, onlign },
}
