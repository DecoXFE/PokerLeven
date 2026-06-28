-- Galileo
local Galileo = J({
  name = "Galileo",
  pos = { x = 1, y = 0 },
  config = { extra = { x1_scaling = 1, current_mult = 0 } },
  loc_vars = function(self, info_queue, center)
    local per_level = center.ability.extra.x1_scaling or 1
    local mult_per_card = 2 + per_level
    return { vars = { mult_per_card, center.ability.extra.current_mult } }
  end,
  rarity = 2, -- Uncommon
  pools = { ["Geminis"] = true },
  cost = 6,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.GK,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Grade,
  unlocked = false,
  unlock_condition = { type = 'c_cards_destroyed', extra = 100 },
  locked_loc_vars = function(self, info_queue, card)
    return { vars = { G.PROFILES[G.SETTINGS.profile].career_stats.c_cards_destroyed or 0, 100 } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.remove_playing_cards and not context.blueprint then
      if #context.removed > 0 then
        local mult_per_card = 2 + (card.ability.extra.x1_scaling or 1)
        card.ability.extra.current_mult = card.ability.extra.current_mult +
            (mult_per_card * #context.removed)
        G.E_MANAGER:add_event(Event({
          func = function()
            card_eval_status_text(card, 'extra', nil, nil, nil, {
              message = localize('k_upgrade_ex'),
              colour = G.C.MULT
            })
            return true
          end
        }))
        return
      end
    end

    if context.joker_main and card.ability.extra.current_mult > 0 then
      return {
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
        mult_mod = card.ability.extra.current_mult,
        colour = G.C.MULT
      }
    end
  end
})

-- Coral
local Coral = J({
  name = "Coral",
  pos = { x = 2, y = 0 },
  config = { extra = { half_scaling = 10 } },
  loc_vars = function(self, info_queue, center)
    local df_count = G.jokers and #find_player_position("DF") or 0
    local mult = center.ability.extra.half_scaling or 10
    if df_count >= 2 then mult = mult * 2 end
    return { vars = { mult } }
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 4,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.DF,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Plus,
  unlocked = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      if #context.scoring_hand <= 3 then
        local mult_gain = card.ability.extra.half_scaling or 10
        local df_count = #find_player_position("DF")
        if df_count >= 2 then
          mult_gain = mult_gain * 2
        end
        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { mult_gain } },
          mult_mod = mult_gain,
          colour = G.C.MULT
        }
      end
    end
  end
})

-- Gigs
local Gigs = J({
  name = "Gigs",
  pos = { x = 3, y = 0 },
  config = { extra = { evolving_retriggers = 1 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.evolving_retriggers } }
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 4,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Plus,
  unlocked = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition and not context.repetition_only then
      if context.other_card == context.scoring_hand[1] then
        local fire_count = #find_player_type("Fire")
        if fire_count >= 2 then
          return {
            message = localize('k_again_ex'),
            repetitions = card.ability.extra.evolving_retriggers,
            card = card
          }
        end
      end
    end
  end
})

-- Ganymede
local Ganymede = J({
  name = "Ganymede",
  pos = { x = 4, y = 0 },
  config = { extra = { mult_mod_low = 20 } },
  loc_vars = function(self, info_queue, center)
    local tech = center.ability.extra.tech_level or 0
    local key = tech >= 1 and 'j_ina_Ganymede_1' or 'j_ina_Ganymede'
    local money_val = tech >= 1 and center.ability.extra.mult_mod_low or 0
    return { key = key, vars = { money_val } }
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 4,
  atlas = "Jokers02",
  ptype = C.Mountain,
  pposition = C.DF,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Plus,
  unlocked = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.game_over and not G.GAME.perish_prevented and not G.GAME.game_over_check then
      local mountain_count = #find_player_type("Mountain")
      if mountain_count >= 2 then
        local tech = card.ability.extra.tech_level or 0

        G.GAME.game_over_check = true
        G.E_MANAGER:add_event(Event({
          func = function()
            G.hand_text_area.blind_chips:juice_up()
            G.hand_text_area.game_chips:juice_up()
            play_sound('tarot1')
            card:start_dissolve()
            return true
          end
        }))

        local money_gain = tech >= 1 and card.ability.extra.mult_mod_low or 0
        if money_gain > 0 then
          ease_dollars(money_gain)
        end

        return {
          message = localize('k_saved'),
          saved = true,
          colour = G.C.RED
        }
      end
    end
  end
})

-- Charon
local Charon = J({
  name = "Charon",
  pos = { x = 5, y = 0 },
  config = { extra = { mult_mod = 15 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.mult_mod } }
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 4,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.DF,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Plus,
  unlocked = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand and next(context.poker_hands['Flush']) then
      local rightmost = nil
      if G.hand.cards and #G.hand.cards > 0 then
        rightmost = G.hand.cards[#G.hand.cards]
      end

      if rightmost and not rightmost.getting_sliced then
        SMODS.destroy_cards({ rightmost }, { bypass_eternal = true, colours = { G.C.FIRE } })
        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } },
          mult_mod = card.ability.extra.mult_mod,
          colour = G.C.MULT
        }
      end
    end
  end
})

-- Pandora
local Pandora = J({
  name = "Pandora",
  pos = { x = 6, y = 0 },
  config = { extra = { odds_8percent = 5 } },
  loc_vars = function(self, info_queue, center)
    local wind_count = G.jokers and (#find_player_type("Wind")) or 0
    return { vars = { G.GAME.probabilities.normal, center.ability.extra.odds_8percent, math.max(0, wind_count) } }
  end,
  rarity = 2, -- Uncommon
  pools = { ["Geminis"] = true },
  cost = 6,
  atlas = "Jokers02",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Plus,
  unlocked = false,
  check_for_unlock = function(self, args)
    if args.type == 'consumeable_usage' and args.consumeable.ability.set == 'Planet' then
      G.GAME.round_planets_used = (G.GAME.round_planets_used or 0) + 1
      if G.GAME.round_planets_used >= 4 then
        unlock_card(self)
      end
    end
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.remove_playing_cards and not context.blueprint then
      if #context.removed > 0 then
        local probability = math.max(0, (#find_player_type("Wind")))

        if probability * G.GAME.probabilities.normal >= card.ability.extra.odds_8percent then
          G.E_MANAGER:add_event(Event({
            func = function()
              local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'Pandora')
              _card:set_edition({ negative = true }, true)
              _card:add_to_deck()
              G.consumeables:emplace(_card)
              return true
            end
          }))
          card_eval_status_text(card, 'extra', nil, nil, nil, {
            message = localize('k_plus_planet'),
            colour = G.C.SECONDARY_SET.Planet
          })
        elseif pseudorandom('Pandora') < (probability * G.GAME.probabilities.normal / card.ability.extra.odds_8percent) then
          G.E_MANAGER:add_event(Event({
            func = function()
              local _card = create_card('Planet', G.consumeables, nil, nil, nil, nil, nil, 'Pandora')
              _card:add_to_deck()
              G.consumeables:emplace(_card)
              return true
            end
          }))
          card_eval_status_text(card, 'extra', nil, nil, nil, {
            message = localize('k_plus_planet'),
            colour = G.C.SECONDARY_SET.Planet
          })
        end
      end
    end
  end
})

-- Grengo
local Grengo = J({
  name = "Grengo",
  pos = { x = 7, y = 0 },
  config = { extra = { x075_scaling = 10 } },
  loc_vars = function(self, info_queue, center)
    local total = 0
    for _, area in ipairs({ G.deck, G.hand, G.discard, G.play }) do
      if area and area.cards then total = total + #area.cards end
    end
    local diff = math.max(0, 52 - total)
    local chips_mod = center.ability.extra.x075_scaling
    return { vars = { chips_mod, diff * chips_mod } }
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 4,
  atlas = "Jokers02",
  ptype = C.Mountain,
  pposition = C.MF,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Grade,
  unlocked = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.cardarea == G.jokers then
      local total = 0
      for _, area in ipairs({ G.deck, G.hand, G.discard, G.play }) do
        if area and area.cards then total = total + #area.cards end
      end
      local diff = math.max(0, 52 - total)
      if diff > 0 then
        local chips_gain = diff * card.ability.extra.x075_scaling
        return {
          message = localize { type = 'variable', key = 'a_chips', vars = { chips_gain } },
          chip_mod = chips_gain,
          colour = G.C.CHIPS
        }
      end
    end
  end
})

-- Io
local Io = J({
  name = "Io",
  pos = { x = 8, y = 0 },
  config = { extra = { chips_mod = 35 } },
  loc_vars = function(self, info_queue, center)
    local fire_count = G.jokers and #find_player_type("Fire") or 0
    return { vars = { center.ability.extra.chips_mod, fire_count * center.ability.extra.chips_mod } }
  end,
  rarity = 1, -- Common
  pools = { ["Geminis"] = true },
  cost = 4,
  atlas = "Jokers02",
  ptype = C.Fire,
  pposition = C.MF,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Plus,
  unlocked = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.cardarea == G.jokers then
      local fire_count = #find_player_type("Fire")
      if fire_count > 0 then
        local chips_gain = fire_count * card.ability.extra.chips_mod
        return {
          message = localize { type = 'variable', key = 'a_chips', vars = { chips_gain } },
          chip_mod = chips_gain,
          colour = G.C.CHIPS
        }
      end
    end
  end
})

-- Rihm
local Rihm = J({
  name = "Rihm",
  pos = { x = 9, y = 0 },
  config = { extra = { odds = 3 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { G.GAME.probabilities.normal, center.ability.extra.odds } }
  end,
  rarity = 2, -- Uncommon
  pools = { ["Geminis"] = true },
  cost = 4,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Plus,
  unlocked = false,
  check_for_unlock = function(self, args)
    if args.type == 'cards_destroyed' and args.count >= 5 then
      unlock_card(self)
    end
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      if pseudorandom('Rihm') < (G.GAME.probabilities.normal / card.ability.extra.odds) then
        local to_destroy = {}
        for _, c in ipairs(context.scoring_hand) do
          if not c.ability.eternal then table.insert(to_destroy, c) end
        end

        if #to_destroy > 0 then
          SMODS.destroy_cards(to_destroy)
          return {
            message = localize('k_destroyed'),
            colour = G.C.RED
          }
        end
      end
    end
  end
})

-- Janus
local Janus = J({
  name = "Janus",
  pos = { x = 10, y = 0 },
  config = { extra = { xmult_mod_high = 0.1 } },
  loc_vars = function(self, info_queue, center)
    local planet_count = G.GAME and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0
    local gain = center.ability and center.ability.extra.xmult_mod_high or center.config.extra.xmult_mod_high
    return { vars = { 1 + (planet_count * gain), gain } }
  end,
  rarity = 3, -- Rare
  pools = { ["Geminis"] = true },
  cost = 8,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.MF,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Grade,
  unlocked = false,
  unlock_condition = { type = 'c_planetarium_used', extra = 70 },
  locked_loc_vars = function(self, info_queue, card)
    return { vars = { G.PROFILES[G.SETTINGS.profile].career_stats.c_planetarium_used or 0, 70 } }
  end,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local planet_count = G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.planet or 0
      local current_xmult = 1 + (planet_count * card.ability.extra.xmult_mod_high)

      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { current_xmult } },
        Xmult_mod = current_xmult,
        colour = G.C.XMULT
      }
    end
  end
})

-- Diam
local Diam = J({
  name = "Diam",
  pos = { x = 11, y = 0 },
  config = { extra = { chips_mod = 40 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod } }
  end,
  rarity = 2, -- Uncommon
  pools = { ["Geminis"] = true },
  cost = 6,
  atlas = "Jokers02",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "Tormenta de Géminis",
  techtype = C.UPGRADES.Plus,
  unlocked = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      -- Count Gemini Jokers
      local gemini_count = #find_player_team("Tormenta de Géminis")

      local destroyed_count = 0
      if gemini_count > 0 and G.hand.cards and #G.hand.cards > 0 then
        local available_cards = {}
        for _, v in ipairs(G.hand.cards) do
          if not v.getting_sliced then table.insert(available_cards, v) end
        end

        local to_destroy = {}
        for i = 1, gemini_count do
          if #available_cards > 0 then
            local card_to_remove, key = pseudorandom_element(available_cards, pseudoseed('diam'))
            table.insert(to_destroy, card_to_remove)
            table.remove(available_cards, key)
            destroyed_count = destroyed_count + 1
          end
        end

        if #to_destroy > 0 then
          SMODS.destroy_cards(to_destroy)
        end
      end

      if destroyed_count > 0 then
        local chips_gain = destroyed_count * card.ability.extra.chips_mod
        return {
          message = localize { type = 'variable', key = 'a_chips', vars = { chips_gain } },
          chip_mod = chips_gain,
          colour = G.C.CHIPS
        }
      end
    end
  end
})

return {
  name = "Tormenta de Géminis",
  list = { Galileo, Coral, Gigs, Ganymede, Charon, Pandora, Grengo, Io, Rihm, Janus, Diam },
}
