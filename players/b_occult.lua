-- Talisman
local Talisman = {
  name = "Talisman",
  pos = { x = 11, y = 1 },
  config = { extra = { retriggers = 2, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = {} }
  end,
  rarity = 3,
  pools = { ["Occult"] = true },
  cost = 8,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "FW",
  pteam = "Occult",
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
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.retriggers,
          card = card,
        }
      else
        return nil, true
      end
    end
  end,
}

-- Wolfy
local Wolfy = {
  name = "Wolfy",
  pos = { x = 12, y = 1 },
  config = { extra = { xmult_mod = 0.26, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { 1 + center.ability.extra.xmult_mod * (G.GAME.used_moon_cards or 0), center.ability.extra.xmult_mod } }
  end,
  rarity = 2,
  pools = { ["Occult"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Fire",
  pposition = "FW",
  techtype = C.UPGRADES.Number,
  pteam = "Occult",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand
        and 1 + card.ability.extra.xmult_mod * (G.GAME.used_moon_cards or 0) > 1 then
      card.ability.extra.triggered = true
      return {
        message =
            localize { type = 'variable', key = 'a_xmult',
              vars = { 1 + card.ability.extra.xmult_mod * (G.GAME.used_moon_cards or 0) } },
        colour = G.C.MULT,
        Xmult_mod = 1 + card.ability.extra.xmult_mod * (G.GAME.used_moon_cards or 0)
      }
    end
  end,
}

-- Blood
local Blood = {
  name = "Blood",
  pos = { x = 0, y = 2 },
  config = { extra = { drain = 1, chips_mod = 10, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.drain, center.ability.extra.chips_mod, center.sell_cost * center.ability.extra.chips_mod } }
  end,
  rarity = 2,
  pools = { ["Occult"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Mountain",
  pposition = "MF",
  pteam = "Occult",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        card.ability.extra.triggered = true
        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { card.sell_cost * card.ability.extra.chips_mod } },
          colour = G.C.MULT,
          chip_mod = card.sell_cost * card.ability.extra.chips_mod
        }
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local adjacent = get_adjacent_jokers(card)
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] ~= card then
          drain(card, G.jokers.cards[i], card.ability.extra.drain)
        end
      end
    end
  end,
}

-- Grave
local Grave = {
  name = "Grave",
  pos = { x = 10, y = 1 },
  config = { extra = { odds = 5, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { '' .. (G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds } }
  end,
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Fire",
  pposition = "MF",
  pteam = "Occult",
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
}

-- Mask
local Mask = {
  name = "Mask",
  pos = { x = 3, y = 1 },
  config = { extra = { sell_value = 6 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.sell_value } }
  end,
  rarity = 2,
  pools = { ["Occult"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Wind",
  pposition = "GK",
  pteam = "Occult",
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
        card.sell_cost = card.sell_cost + card.ability.extra.sell_value

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
            message = localize { type = 'variable', key = 'a_mult',
              vars = { card.ability.extra.sell_value } },
            colour = G.C.RED,
            no_juice = true
          })
      end
    end
  end,
}

-- Styx
local Styx = {
  name = "Styx",
  pos = { x = 4, y = 1 },
  config = { extra = { chips_mod = 6, triggered = false } },
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
  ptype = "Forest",
  pposition = "DF",
  pteam = "Occult",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand
        and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot > 0 then
      if context.joker_main then
        local current_chips = G.GAME.consumeable_usage_total.tarot * card.ability.extra.chips_mod
        card.ability.extra.triggered = true
        return {
          message = localize { type = 'variable', key = 'a_chips', vars = { current_chips } },
          colour = G.C.CHIPS,
          chip_mod = current_chips
        }
      end
    end
  end,
}

-- Franky
local Franky = {
  name = "Franky",
  pos = { x = 6, y = 1 },
  config = { extra = { mult_mod = 16, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.mult_mod } }
  end,
  rarity = 1,
  pools = { ["Occult"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Mountain",
  pposition = "DF",
  techtype = C.UPGRADES.Number,
  pteam = "Occult",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main and #context.scoring_hand == 1 then
        card.ability.extra.triggered = true
        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } },
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult_mod
        }
      end
    end
  end,
}

-- Mummy
local Mummy = {
  name = "Mummy",
  pos = { x = 9, y = 1 },
  config = { extra = { mult_mod = 6, chip_mod = 6, suit = "Clubs", triggered = false } },
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
  ptype = "Forest",
  pposition = "MF",
  pteam = "Occult",
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
}

return {
  name = "Occult",
  list = { Mask, Styx, Franky, Mummy, Grave, Talisman, Wolfy, Blood },
}
