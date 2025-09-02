-- Kevin Dragonfly
local Kevin = J({
  name = "Kevin",
  pos = { x = 11, y = 0 },
  config = { extra = { retriggers = 1, cooldown_base = 6, current_cooldown = 6 } },
  loc_vars = function(self, info_queue, card)
    return {
      key = (card.ability.extra.tech_level or 0) < 5
          and 'j_ina_Kevin' or 'j_ina_Kevin_inf',
      vars = { card.ability.extra.cooldown_base, card.ability.extra.current_cooldown }
    }
  end,
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "FW",
  pteam = "Raimon",
  techtype = C.UPGRADES.Plus,
  calculate = function(self, card, context)
    if card.ability.extra.current_cooldown == 0 and
        context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
      if context.other_card == get_right_joker(card) and is_position(context.other_card, "FW") then
        return {
          message = localize("k_again_ex"),
          repetitions = card.ability.extra.retriggers,
          card = card,
        }
      else
        return nil, true
      end
    elseif card.ability.extra.current_cooldown > 0 and
        Pokerleven.is_joker_turn(context) then
      card.ability.extra.current_cooldown = card.ability.extra.current_cooldown - 1
    end

    if card.ability.extra.current_cooldown == 0 and
        context.end_of_round then
      card.ability.extra.current_cooldown = card.ability.extra.cooldown_base
    end
  end,
})

-- Mark Evans
local Mark = J({
  name = "Mark",
  pos = { x = 0, y = 0 },
  soul_pos = { x = 0, y = 1 },
  config = { extra = { extra_hands = 1, extra_back_size = 1 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.extra_hands, center.ability.extra.extra_back_size } }
  end,
  rarity = 4,
  cost = 15,
  atlas = "legendary01",
  ptype = "Mountain",
  pposition = "GK",
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  discovered = true,
  blueprint_compat = true,
  add_to_deck = function(self, card, from_debuff)
    G.hand.config.card_limit = G.hand.config.card_limit + card.ability.extra.extra_back_size
    SMODS.change_play_limit(card.ability.extra.extra_hands)
    SMODS.change_discard_limit(card.ability.extra.extra_hands)
  end,
  remove_from_deck = function(self, card, from_debuff)
    SMODS.change_play_limit(-card.ability.extra.extra_hands)
    SMODS.change_discard_limit(-card.ability.extra.extra_hands)
    G.hand.config.card_limit = G.hand.config.card_limit - card.ability.extra.extra_back_size
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
  ptype = C.Wind,
  pposition = C.DF,
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
  config = { extra = { chips_mod = 10, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod } }
  end,
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Mountain,
  pposition = C.DF,
  techtype = C.UPGRADES.Plus,
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
local Axel = J({
  name = "Axel",
  pos = { x = 2, y = 0 },
  soul_pos = { x = 2, y = 1 },
  config = { extra = { xmult = 4.5, suit = "Hearts", triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.xmult } }
  end,
  rarity = "ina_top",
  pools = { ["Raimon"] = true },
  cost = 8,
  atlas = "top",
  ptype = C.Fire,
  pposition = C.FW,
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand
        and next(context.poker_hands['Flush']) and
        context.scoring_hand[1]:is_suit('Hearts') then
      card.ability.extra.triggered = true
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
        colour = G.C.MULT,
        Xmult_mod = card.ability.extra.xmult
      }
    end
  end,
})

-- Shadow
local Shadow = {
  name = "Shadow",
  pos = { x = 2, y = 1 },
  config = { extra = { clone = false } },
  loc_vars = function(self, info_queue, center)
    return {
      key = center.ability.extra.clone and 'j_ina_Shadow_clone' or 'j_ina_Shadow',
      vars = {}
    }
  end,
  rarity = 1,
  pools = { ["Raimon"] = true },
  cost = 2,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.FW,
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind
        and #G.jokers.cards == 1 then
      local create_args = {
        set = 'Joker',
        key = 'j_ina_Shadow',
        edition = 'e_negative',
      }

      local _card = SMODS.create_card(create_args)
      _card.ability.extra.clone = true
      _card.calculate_joker = function(self, context)
      end
      _card:add_to_deck()
      G.jokers:emplace(_card)
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
  ptype = C.Forest,
  pposition = C.FW,
  techtype = C.UPGRADES.Plus,
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
  ptype = C.Wind,
  pposition = C.FW,
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
  config = { extra = { current_mult = 0, mult_mod_low = 1, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.current_mult, center.ability.extra.mult_mod_low } }
  end,
  rarity = 1,
  pools = { ["Raimon"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.GK,
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if G.GAME.current_round.hands_left == 0 then
      if context.individual and Pokerleven.card_scoring(context) then
        card.ability.extra.current_mult =
            card.ability.extra.current_mult + card.ability.extra.mult_mod_low;
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end
      if context.cardarea == G.jokers and context.scoring_hand then
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
  end
}

-- Jude
local Jude_Raimon = J({
  name = "Jude_Raimon",
  pos = { x = 1, y = 0 },
  soul_pos = { x = 1, y = 1 },
  config = {
    extra = { current_xmult = 1, xmult_mod = 0.08, next_xmult = 1, triggered = false
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.current_xmult, center.ability.extra.xmult_mod } }
  end,
  rarity = "ina_top",
  cost = 8,
  atlas = "top",
  stage = "one",
  ptype = C.Wind,
  pposition = C.MF,
  techtype = C.UPGRADES.Plus,
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
  pos = { x = 0, y = 0 },
  config = { extra = { chips_mod = 30 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod } }
  end,
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "JokersBobby",
  ptype = C.Forest,
  pposition = C.DF,
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
  config = { extra = { chip_mod = 6, mult_mod_low = 3, money = 1 } },
  loc_vars = function(self, info_queue, center)
    local count = #find_player_team("Raimon")
    return { vars = { center.ability.extra.chip_mod, center.ability.extra.mult_mod_low, center.ability.extra.money, count * center.ability.extra.chip_mod, count * center.ability.extra.mult_mod_low } }
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
        mult_mod = card.ability.extra.mult_mod_low * count,
      }
    end
  end,
  calc_dollar_bonus = function(self, card)
    return card.ability.extra.money
  end
})

local old_use_consumeable = Card.use_consumeable

-- Erik
local Erik = J({
  name = "Erik",
  pos = { x = 1, y = 1 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 2,
  pools = { ["Raimon"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.MF,
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  add_to_deck = function(self, card, from_debuff)
    function Card:use_consumeable(area, copier)
      if self.ability and self.ability.name == "The Magician" then
        stop_use()
        if not copier then set_consumeable_usage(self) end
        if self.debuff then return nil end

        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.2,
          func = function()
            play_sound("tarot1")
            self:juice_up(0.5, 0.8)

            Pokerleven.flip_highlighted_hand('card1')
            Pokerleven.set_random_seals_to_highlighted_hand('Erik')
            Pokerleven.flip_highlighted_hand()
            Pokerleven.unhighlight_hand()
            delay(0.5)
            return true
          end
        }))

        return
      else
        return old_use_consumeable(self, area, copier)
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    function Card:use_consumeable(area, copier)
      return old_use_consumeable(self, area, copier)
    end
  end
})

-- Jim
local Jim = J({
  name = "Jim",
  pos = { x = 3, y = 0 },
  config = { extra = { chips_mod = 1 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod } }
  end,
  rarity = 1,
  pools = { ["Raimon"] = true },
  cost = 3,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.DF,
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if Pokerleven.is_joker_turn(context) then
      return {
        chips = card.ability.extra.chips
      }
    end
  end
})

-- Tod
local Tod = J({
  name = "Tod",
  pos = { x = 4, y = 0 },
  config = { extra = { chip_mod = 20 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chip_mod } }
  end,
  rarity = 1,
  pools = { ["Raimon"] = true },
  cost = 3,
  atlas = "Jokers01",
  ptype = C.Fire,
  pposition = C.DF,
  techtype = C.UPGRADES.Plus,
  pteam = "Raimon",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if Pokerleven.is_joker_turn(context) and context.cardarea == G.jokers and context.joker_main and context.scoring_hand then
      local count = 0
      -- Count played metal cards
      for _, c in ipairs(context.scoring_hand) do
        count = count + Pokerleven.get_enhancement_count(c, 'm_steel')
      end

      -- Count metal cards in hand
      for _, c in ipairs(G.hand.cards) do
        count = count + Pokerleven.get_enhancement_count(c, 'm_steel')
      end

      local total_chips = count * card.ability.extra.chip_mod
      if total_chips > 0 then
        return {
          message = localize { type = 'variable', key = 'a_chips', vars = { total_chips } },
          colour = G.C.CHIPS,
          chip_mod = total_chips
        }
      end
    end
  end,
  ina_credits = {
    idea = { "Lovahi" }
  }
})

return {
  name = "Raimon",
  list = { Mark, Nathan, Jack, Jim, Tod, Steve, Peabody, Max, Axel, Kevin, Willy, Bobby, Erik, Jude_Raimon, Shadow },
}
