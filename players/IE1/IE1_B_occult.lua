-- Mask (Nathan Jones)
local Nathan_Jones = J({
name = "Nathan_Jones",
  pos = { x = 3, y = 1 },
  config = { extra = { sell_value = 6 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.sell_value } }
  end,
  rarity = 2,
  pools = { ["Occult"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.GK,
  pteam = "ina_team_occult",
  techtype = C.UPGRADES.Plus,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not card.getting_sliced and not context.blueprint then
      local my_pos = nil
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
          my_pos = i; break
        end
      end
      if my_pos and G.jokers.cards[my_pos + 1]
          and not card.getting_sliced and not G.jokers.cards[my_pos + 1].ability.eternal
          and not G.jokers.cards[my_pos + 1].getting_sliced then
        local sliced_card = G.jokers.cards[my_pos + 1]
        sliced_card.getting_sliced = true
        card.ability.extra_value = card.ability.extra_value + card.ability.extra.sell_value
        card:set_cost()

        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
        G.E_MANAGER:add_event(Event({
          func = function()
            G.GAME.joker_buffer = 0
            card:juice_up(0.8, 0.8)
            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
            play_sound('slice1', 0.96 + math.random() * 0.08)
            return true
          end
        }))
        card_eval_status_text(self, 'extra', nil, nil, nil,
          {
            message = localize { type = 'variable',
vars = { card.ability.extra.sell_value } },
            colour = G.C.RED,
            no_juice = true
          })
      end
    end
  end,
})

-- Styx (Russell Walk)
local Russell_Walk = J({
name = "Russell_Walk",
  pos = { x = 4, y = 1 },
  config = { extra = { chips_mod = 9, triggered = false } },
  loc_vars = function(self, info_queue, center)
    local current_chips = 0
    if G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot > 0 then
      current_chips = G.GAME.consumeable_usage_total.tarot * center.ability.extra.chips_mod
    end
    return { vars = { current_chips, center.ability.extra.chips_mod } }
  end,
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.DF,
  pteam = "ina_team_occult",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand
        and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot > 0 then
      if context.joker_main then
        local current_chips = G.GAME.consumeable_usage_total.tarot * card.ability.extra.chips_mod
        card.ability.extra.triggered = true
        return {
          message = localize { type = 'variable',
vars = { current_chips } },
          colour = G.C.CHIPS,
          chip_mod = current_chips
        }
      end
    end
  end,
})

-- Creepy (Jason Jones)
local Jason_Jones = J({
  name = "Jason_Jones",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.DF,
  pteam = "ina_team_occult",
})

-- Franky (Ken Furan)
local Ken_Furan = J({
name = "Ken_Furan",
  pos = { x = 6, y = 1 },
  config = { extra = { mult_mod = 16, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.mult_mod } }
  end,
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = C.Mountain,
  pposition = C.DF,
  techtype = C.UPGRADES.Number,
  pteam = "ina_team_occult",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and context.scoring_name == "High Card" then
        card.ability.extra.triggered = true
        return {
          message = localize { type = 'variable',
vars = { card.ability.extra.mult_mod } },
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult_mod
        }
      end
    end
  end,
})

-- Undead (Jerry Fulton)
local Jerry_Fulton = J({
  name = "Jerry_Fulton",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "ina_team_occult",
})

-- Jiangshi (Ray Mannings)
local Ray_Mannings = J({
  name = "Ray_Mannings",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "ina_team_occult",
})

-- Mummy (Robert Mayer)
local Robert_Mayer = J({
name = "Robert_Mayer",
  pos = { x = 9, y = 1 },
  config = { extra = { mult_mod = 4, chip_mod = 4, suit = "Clubs", triggered = false } },
  loc_vars = function(self, info_queue, center)
    return {
      vars = { center.ability.extra.mult_mod,
        center.ability.extra.chip_mod, localize(center.ability.extra.suit, 'suits_singular') }
    }
  end,
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.MF,
  pteam = "ina_team_occult",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
      if not context.end_of_round and not context.before and not context.after and not context.other_card.debuff then
        card.ability.extra.triggered = true
        return {
          message = "AAAAAAA",
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult_mod,
          chip_mod = card.ability.extra.chip_mod,
          card = card
        }
      end
    end
  end,
})

-- Grave (Alexander Brave)
local Alexander_Brave = J({
name = "Alexander_Brave",
  pos = { x = 10, y = 1 },
  config = { extra = { odds = 5, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { '' .. (G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds } }
  end,
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = C.Fire,
  pposition = C.MF,
  pteam = "ina_team_occult",
  techtype = C.UPGRADES.Plus,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if context.scoring_hand and context.other_card:get_id() == 6 and
            pseudorandom('Grave') < G.GAME.probabilities.normal / card.ability.extra.odds then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          card.ability.extra.triggered = true
          return {
            extra = {
              focus = card,
              message = localize('k_plus_tarot'),
              colour = G.C.PURPLE,
              func = function()
                G.E_MANAGER:add_event(Event({
                  trigger = 'before',
                  delay = 0.0,
                  func = function()
                    local card_type = 'Tarot'
                    local _card = create_card(card_type, G.consumeables, nil, nil, nil, nil, 'c_death')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    G.GAME.consumeable_buffer = 0
                    return true
                  end
                }))
              end
            }
          }
        end
      end
    end
  end
})

-- Talisman (Johan Tassman)
local Johan_Tassman = J({
name = "Johan_Tassman",
  pos = { x = 11, y = 1 },
  config = { extra = { evolving_retriggers = 1, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.evolving_retriggers } }
  end,
  rarity = 3,
  pools = { ["Occult"] = true },
  cost = 8,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "ina_team_occult",
  techtype = C.UPGRADES.Plus,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
      card.ability.extra.triggered = true;
      local index
      for k, v in ipairs(G.jokers.cards) do
        if v == card then
          index = k
          break
        end
      end
      if context.other_card == G.jokers.cards[index + 1] and is_team(context.other_card, "Occult") then
        return {
          repetitions = card.ability.extra.evolving_retriggers,
        }
      else
        return nil, true
      end
    end
  end,
})

-- Wolfy (Troy Moon)
local Troy_Moon = J({
name = "Troy_Moon",
  pos = { x = 12, y = 1 },
  config = { extra = { xmult_mod = 0.4, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { 1 + center.ability.extra.xmult_mod * (G.GAME.used_moon_cards or 0), center.ability.extra.xmult_mod } }
  end,
  rarity = 2,
  pools = { ["Occult"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Fire,
  pposition = C.FW,
  techtype = C.UPGRADES.Number,
  pteam = "ina_team_occult",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand
        and 1 + card.ability.extra.xmult_mod * (G.GAME.used_moon_cards or 0) > 1 then
      card.ability.extra.triggered = true
      return {
        message =
            localize { type = 'variable',
vars = { 1 + card.ability.extra.xmult_mod * (G.GAME.used_moon_cards or 0) } },
        colour = G.C.MULT,
        Xmult_mod = 1 + card.ability.extra.xmult_mod * (G.GAME.used_moon_cards or 0)
      }
    end
  end,
})

-- Blood (Burt Wolf)
local Burt_Wolf = J({
name = "Burt_Wolf",
  pos = { x = 0, y = 2 },
  config = { extra = { drain = 1, chips_mod = 10, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.drain, center.ability.extra.chips_mod, center.sell_cost * center.ability.extra.chips_mod } }
  end,
  rarity = 2,
  pools = { ["Occult"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Mountain,
  pposition = C.MF,
  pteam = "ina_team_occult",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        card.ability.extra.triggered = true
        return {
          message = localize { type = 'variable',
vars = { card.sell_cost * card.ability.extra.chips_mod } },
          colour = G.C.MULT,
          chip_mod = card.sell_cost * card.ability.extra.chips_mod
        }
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local adjacent = get_adjacent_jokers(card)
      for _, adjacent_card in ipairs(adjacent) do
        drain(card, adjacent_card, card.ability.extra.drain)
      end
    end
  end,
})

-- Zombie (Rob Crombie)
local Rob_Crombie = J({
  name = "Rob_Crombie",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Mountain,
  pposition = C.GK,
  pteam = "ina_team_occult",
})

-- Dollman (Chuck Dollman)
local Chuck_Dollman = J({
  name = "Chuck_Dollman",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "ina_team_occult",
})

-- Alien (Uxley Allen)
local Uxley_Allen = J({
  name = "Uxley_Allen",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.FW,
  pteam = "ina_team_occult",
})

-- Noir (Phil Noir)
local Phil_Noir = J({
  name = "Phil_Noir",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "ina_team_occult",
})

-- Ghost (Mick Askley)
local Mick_Askley = J({
  name = "Mick_Askley",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.MF,
  pteam = "ina_team_occult",
})

return {
  name = "Occult",
  list = { Nathan_Jones, Russell_Walk, Ken_Furan, Robert_Mayer, Alexander_Brave, Johan_Tassman, Troy_Moon, Burt_Wolf },
}
