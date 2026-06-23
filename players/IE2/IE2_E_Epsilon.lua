-- Dvalin
local Dvalin = J({
  name = "Dvalin",
  pos = { x = 4, y = 0 },
  soul_pos = { x = 4, y = 1 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = "ina_top", -- Destacado
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "top",
  ptype = C.Fire,
  pposition = C.GK,
  pteam = "Epsilon",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Kenville
local Kenville = J({
  name = "Kenville",
  pos = { x = 1, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Mole
local Mole = J({
  name = "Mole",
  pos = { x = 2, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.DF,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Kayson
local Kayson = J({
  name = "Kayson",
  pos = { x = 3, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.DF,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Tytan
local Tytan = J({
  name = "Tytan",
  pos = { x = 4, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Mountain,
  pposition = C.DF,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Fedora
local Fedora = J({
  name = "Fedora",
  pos = { x = 5, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.MF,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Krypto
local Krypto = J({
  name = "Krypto",
  pos = { x = 6, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Sworm
local Sworm = J({
  name = "Sworm",
  pos = { x = 7, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.MF,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Mercury
local Mercury = J({
  name = "Mercury",
  pos = { x = 8, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.FW,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Metron
local Metron = J({
  name = "Metron",
  pos = { x = 9, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.FW,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Zell
local Zell = J({
  name = "Zell",
  pos = { x = 10, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Epsilon"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.FW,
  pteam = "Epsilon",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

return {
  name = "Epsilon",
  list = {}
  -- list = { Dvalin, Kenville, Mole, Kayson, Tytan, Fedora, Krypto, Sworm, Mercury, Metron, Zell },
}
