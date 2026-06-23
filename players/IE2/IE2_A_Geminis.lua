-- Galileo
local Galileo = J({
  name = "Galileo",
  pos = { x = 1, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.GK,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Coral
local Coral = J({
  name = "Coral",
  pos = { x = 2, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.DF,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Gigs
local Gigs = J({
  name = "Gigs",
  pos = { x = 3, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Ganymede
local Ganymede = J({
  name = "Ganymede",
  pos = { x = 4, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Mountain,
  pposition = C.DF,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Charon
local Charon = J({
  name = "Charon",
  pos = { x = 5, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Pandora
local Pandora = J({
  name = "Pandora",
  pos = { x = 6, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Grengo
local Grengo = J({
  name = "Grengo",
  pos = { x = 7, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Mountain,
  pposition = C.MF,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Io
local Io = J({
  name = "Io",
  pos = { x = 8, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.MF,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Rihm
local Rihm = J({
  name = "Rihm",
  pos = { x = 9, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Janus
local Janus = J({
  name = "Janus",
  pos = { x = 10, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.MF,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

-- Diam
local Diam = J({
  name = "Diam",
  pos = { x = 11, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 7,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "Tormenta de Géminis",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
})

return {
  name = "Tormenta de Géminis",
  list = {}
  -- list = { Galileo, Coral, Gigs, Ganymede, Charon, Pandora, Grengo, Io, Rihm, Janus, Diam },
}
