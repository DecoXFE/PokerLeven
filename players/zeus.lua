-- Poseidon
local Poseidon = {
  name = "Poseidon",
  pos = { x = 10, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {}
  end,
  rarity = 3, -- Rare
  pools = { ["Zeus"] = true },
  cost = 8,
  atlas = "Jokers01",
  ptype = "Mountain",
  pposition = "GK", -- Goalkeeper
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
}

-- Hephestus
local Hephestus = {
  name = "Hephestus",
  pos = { x = 12, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {}
  end,
  rarity = 2, -- Uncommon
  pools = { ["Zeus"] = true },
  cost = 6,
  atlas = "Jokers01",
  ptype = "Fire",
  pposition = "DF", -- Defense
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
}

-- Apollo
local Apollo = {
  name = "Apollo",
  pos = { x = 11, y = 5 },
  config = { extra = { chips_mod = 7, alt_chips_mod = 3, current_bonus = 0, triggered = false } },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod, center.ability.extra.alt_chips_mod, center.ability.extra.current_bonus } }
  end,
  rarity = 1,
  pools = { ["Zeus"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "DF",
  pteam = "Zeus",
  blueprint_compat = true,

  calculate = function(self, card, context)
    -- Da los chips acumulados al puntuar
    if context.cardarea == G.jokers and context.scoring_hand and context.joker_main
        and card.ability.extra.current_bonus > 0 then
      return {
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_bonus } },
        chip_mod = card.ability.extra.current_bonus,
        colour = G.C.CHIPS
      }
    end

    -- Mejora el bonus según la hora y la cantidad de dobles parejas
    if context.before and context.cardarea == G.jokers and context.scoring_hand
        and next(context.poker_hands["Two Pair"]) then
      local hour = tonumber(os.date("%H"))
      local mod = card.ability.extra.alt_chips_mod

      -- Entre 12 y 15:59 usa el mod alto
      if hour >= 12 and hour < 16 then
        mod = card.ability.extra.chips_mod
      end

      card.ability.extra.current_bonus = card.ability.extra.current_bonus + added_bonus

      return {
        message = localize("k_upgrade_ex"),
        colour = G.C.CHIPS
      }
    end
  end,
}

-- Artemis
local Artemis = {
  name = "Artemis",
  pos = { x = 0, y = 6 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {}
  end,
  rarity = 2, -- Uncommon
  pools = { ["Zeus"] = true },
  cost = 6,
  atlas = "Jokers01",
  ptype = "Wind",
  pposition = "MF", -- Midfielder
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
}

-- Hermes
local Hermes = {
  name = "Hermes",
  pos = { x = 9, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {}
  end,
  rarity = 2, -- Uncommon
  pools = { ["Zeus"] = true },
  cost = 6,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "MF", -- Midfielder
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
}

-- Demeter
local Demeter = {
  name = "Demeter",
  pos = { x = 8, y = 5 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {}
  end,
  rarity = 1, -- Common
  pools = { ["Zeus"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = "Fire",
  pposition = "FW", -- Forward
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
}

-- Aphrodite
local Aphrodite = {
  name = "Aphrodite",
  pos = { x = 1, y = 6 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    return {}
  end,
  rarity = 4, -- Legendary
  pools = { ["Zeus"] = true },
  cost = 12,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "MF", -- Midfielder
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
  end
}

return {
  name = "Zeus",
  list = { Poseidon, Hephestus, Apollo, Artemis, Hermes, Demeter, Aphrodite },
}
