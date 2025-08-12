-- Kevin Dragonfly
local Kevin = J({
  name = "Kevin",
  pos = { x = 11, y = 0 },
  config = { extra = { retriggers = 1, triggered = false } },
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "FW",
  pteam = "Raimon",
  techtype = C.UPGRADES.Plus,
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
      if context.other_card == G.jokers.cards[index + 1] and is_position(context.other_card, "FW") then
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
})

-- Mark Evans
local Mark = J({
  name = "Mark",
  pos = { x = 0, y = 0 },
  config = { extra = { extra_hands = 1 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.extra_hands } }
  end,
  rarity = 4,
  cost = 15,
  atlas = "Jokers01",
  ptype = "Mountain",
  pposition = "GK",
  discovered = true,
  pteam = "Raimon",
  blueprint_compat = true,
  add_to_deck = function(self, card, from_debuff)
    SMODS.change_play_limit(card.ability.extra.extra_hands)
    SMODS.change_discard_limit(card.ability.extra.extra_hands)
  end,
  remove_from_deck = function(self, card, from_debuff)
    SMODS.change_play_limit(-card.ability.extra.extra_hands)
    SMODS.change_discard_limit(-card.ability.extra.extra_hands)
  end,
  set_sprites = function(self, card, front)
    if card.children and card.children.center and card.children.center.set_visible then
      card.children.center:set_visible(true)
    end
  end,
})


-- Nathan
local Nathan = J({
  name = "Nathan",
  pos = { x = 1, y = 0 },
  config = { extra = { xmult = 1.25, triggered = false } },
  loc_vars = function(self, info_queue, center)
    local count = #find_player_team("Raimon");
    return { vars = { count, center.ability.extra.xmult } }
  end,
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Wind",
  pposition = "DF",
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.debuff and context.other_joker and is_team(context.other_joker, "Raimon") then
      card.ability.extra.triggered = true;
      G.E_MANAGER:add_event(Event({
        func = function()
          context.other_joker:juice_up(0.5, 0.5)
          return true
        end
      }))
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.xmult
      }
    end
  end,
})

-- Jack
local Jack = {
  name = "Jack",
  pos = { x = 2, y = 0 },
  config = { extra = { chips_mod = 8, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod } }
  end,
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Mountain",
  techtype = C.UPGRADES.Plus,
  pposition = "DF",
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play
        and not context.other_card.debuff and not context.end_of_round
        and SMODS.has_enhancement(context.other_card, 'm_stone') then
      card.ability.extra.triggered = true;

      local count = #find_player_position("DF");
      context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0;
      context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus +
          card.ability.extra.chips_mod * count;
      return {
        extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
        colour = G.C.CHIPS,
        card = card
      }
    end
  end,
}

-- Axel Blaze
local Axel = {
  name = "Axel",
  pos = { x = 10, y = 0 },
  config = { extra = { xmult = 3.5, suit = "Hearts", triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.xmult } }
  end,
  rarity = 3,
  pools = { ["Raimon"] = true },
  cost = 8,
  atlas = "Jokers01",
  ptype = "Fire",
  pposition = "FW",
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local count = 0
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i]:is_suit(card.ability.extra.suit) then
          count = count + 1
        end
      end
      if count == 5 then
        card.ability.extra.triggered = true
        return {
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
          colour = G.C.MULT,
          Xmult_mod = card.ability.extra.xmult
        }
      end
    end
  end,
}

-- Shadow
local Shadow = {
  name = "Shadow",
  pos = { x = 2, y = 1 },
  config = { extra = { current_mult = 0, mult_mod = 2 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.current_mult, center.ability.extra.mult_mod } }
  end,
  rarity = 1,
  pools = { ["Raimon"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "FW",
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
        colour = G.C.MULT,
        mult_mod = card.ability.extra.current_mult
      }
    end

    if context.after and not card.debuff then
      local other_triggered = false
      for _, j in ipairs(G.jokers.cards) do
        if j ~= card and j.ability and j.ability.extra and j.ability.extra.triggered then
          other_triggered = true
          break
        end
      end
      for _, c in ipairs(G.jokers.cards) do
        if c.ability and c.ability.extra then
          c.ability.extra.triggered = false
        end
      end
      if not other_triggered then
        card.ability.extra.current_mult = (card.ability.extra.current_mult or 0) + card.ability.extra.mult_mod
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT
        }
      end
    end
  end,
}

-- Willy
local Willy = {
  name = "Willy",
  pos = { x = 12, y = 0 },
  config = { extra = { odds = 30 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { G.GAME.probabilities.normal, center.ability.extra.odds } }
  end,
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "FW",
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if Pokerleven.is_joker_turn(context) and pseudorandom('glasis') < G.GAME.probabilities.normal / card.ability.extra.odds then
      convert_cards_to(context.scoring_hand, { mod_conv = "m_glass", edition = "e_polychrome", seal = "Red" })
      return {
        message = localize("ina_gafas"),
        colour = G.C.XMULT
      }
    end
  end,
}

-- Max
local Max = {
  name = "Max",
  pos = { x = 9, y = 0 },
  config = { extra = { chip_mod = 20, triggered = false } },
  loc_vars = function(self, info_queue, center)
    local count = #find_player_type("Wind")
    return { vars = { center.ability.extra.chip_mod, count * center.ability.extra.chip_mod } }
  end,
  rarity = 1,
  pools = { ["Raimon"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Wind",
  pposition = "FW",
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        local count = #find_player_type("Wind");
        card.ability.extra.triggered = true;
        return {
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chip_mod * count } },
          colour = G.C.CHIPS,
          chip_mod = card.ability.extra.chip_mod * count,
        }
      end
    end
  end,
}

-- Peabody
local Peabody = {
  name = "Peabody",
  pos = { x = 8, y = 0 },
  config = { extra = { current_mult = 0, mult_mod = 4, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.current_mult, center.ability.extra.mult_mod } }
  end,
  rarity = 1,
  pools = { ["Raimon"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Wind",
  pposition = "GK",
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.scoring_hand and G.GAME.current_round.hands_left == 0 then
      if context.before and not context.blueprint then
        card.ability.extra.current_mult =
            card.ability.extra.current_mult + card.ability.extra.mult_mod;
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT
        }
      end
      if context.joker_main then
        card.ability.extra.triggered = true;
        return {
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
          colour = G.C.MULT,
          mult_mod = card.ability.extra.current_mult
        }
      end
    end
  end
}

-- Jude
local Jude_Raimon = J({
  name = "Jude_Raimon",
  pos = { x = 3, y = 3 },
  config = {
    extra = { current_xmult = 1, xmult_mod = 0.10, next_xmult = 1, triggered = false
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.current_xmult, center.ability.extra.xmult_mod } }
  end,
  rarity = 3,
  pools = { ["Royal Academy"] = true },
  cost = 8,
  atlas = "Jokers01",
  stage = "one",
  ptype = "Wind",
  pposition = "MF",
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    local index
    for k, v in ipairs(G.jokers.cards) do
      if v == card then
        index = k
        break
      end
    end
    if context.post_trigger and context.other_card ~= card
        and context.other_card == G.jokers.cards[index - 1] then
      card.ability.extra.current_xmult = (card.ability.extra.current_xmult or 0) + card.ability.extra.xmult_mod

      G.E_MANAGER:add_event(Event({
        func = function()
          card_eval_status_text(card, 'extra', nil, nil, nil, {
            message = localize("ina_evolve_level"),
            colour = G.C.XMULT
          })
          return true
        end
      }))

      return {}
    end

    if context.joker_main and context.scoring_hand then
      card.ability.extra.triggered = true
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.current_xmult
      }
    end
  end,
  custom_pool_func = true,
  in_pool = function(self, args)
    return false
  end
})

-- Bobby
local Bobby = J({
  name = "Bobby",
  pos = { x = 0, y = 1 },
  config = { extra = { chips_mod = 20 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod } }
  end,
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Wind",
  pposition = "DF",
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.other_joker then
      if is_team(context.other_joker, card.ability.extra.pteam) then
        G.E_MANAGER:add_event(Event({
          func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
          end
        }))
        return {
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips_mod } },
          colour = G.C.CHIPS,
          chip_mod = card.ability.extra.chips_mod,
          card = context.other_joker
        }
      end
    end

    if context.setting_blind then
      local selected_team = Pokerleven.most_played_team()
      if selected_team and selected_team ~= card.ability.extra.pteam then
        card.ability.extra.pteam = Pokerleven.most_played_team()

        local coords = C.CUSTOM.Bobby_Teams[selected_team]
        if coords then
          G.E_MANAGER:add_event(Event({
            func = function()
              if card.evolution_timer then return true end
              card.evolution_timer = 0
              G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                ref_table = card,
                ref_value = 'evolution_timer',
                ease_to = 1.5,
                delay = 2.0,
                func = (function(t) return t end)
              }))
              G.E_MANAGER:add_event(Event({
                func = function()
                  card.children.center:set_sprite_pos({ x = coords.x, y = coords.y })
                  return true
                end
              }))
              G.E_MANAGER:add_event(Event({
                trigger = 'ease',
                ref_table = card,
                ref_value = 'evolution_timer',
                ease_to = 2.25,
                delay = 1.0,
                func = (function(t) return t end)
              }))
              G.E_MANAGER:add_event(Event({
                func = function()
                  card.evolution_timer = nil
                  play_sound('tarot1')
                  card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize("ina_evolve_success"), colour = G.C.FILTER, instant = true })
                  return true
                end
              }))
              return true
            end
          }))
        end
      end
    end
  end
})

-- Steve
local Steve = J({
  name = "Steve",
  pos = { x = 5, y = 0 },
  config = { extra = { chip_mod = 6, mult_mod = 3, money = 1 } },
  loc_vars = function(self, info_queue, center)
    local count = #find_player_team("Raimon")
    return { vars = { center.ability.extra.chip_mod, center.ability.extra.mult_mod, center.ability.extra.money, count * center.ability.extra.chip_mod, count * center.ability.extra.mult_mod } }
  end,
  rarity = 1,
  pools = { ["Raimon"] = true },
  cost = 3,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.MF,
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if Pokerleven.is_joker_turn(context) then
      local count = #find_player_team("Raimon");
      return {
        message = localize("ina_gol"),
        colour = G.C.CHIPS,
        chip_mod = card.ability.extra.chip_mod * count,
        mult_mod = card.ability.extra.mult_mod * count,
      }
    end
  end,
  calc_dollar_bonus = function(self, card)
    return card.ability.extra.money
  end
})

return {
  name = "Raimon",
  list = { Mark, Nathan, Jack, Steve, Peabody, Max, Axel, Kevin, Willy, Bobby, Jude_Raimon, Shadow, },
}
