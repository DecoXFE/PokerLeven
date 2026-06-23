-- Joseph King
local Joseph_King = J({
name = "Joseph_King",
  pos = { x = 6, y = 2 },
  config = { extra = { triggered = false } },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 2,
  pools = { ["Royal Academy"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Fire,
  pposition = C.GK,
  pteam = "ina_team_royal_academy",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      local rankCount = 0
      for i, c in ipairs(context.scoring_hand) do
        if c:get_id() == 13 then
          rankCount = rankCount + 1
        end
      end

      if rankCount >= 3 then
        local rightmost_king = nil
        for i = #context.full_hand, 1, -1 do
          local c = context.full_hand[i]
          if c and c:get_id() == 13 then
            rightmost_king = c
            break
          end
        end

        if rightmost_king then
          card.ability.extra.triggered = true
          G.E_MANAGER:add_event(Event({
            delay = 0.5,
            func = function()
              local copied_card = copy_card(rightmost_king, nil, nil, G.playing_card or 1)
              copied_card:add_to_deck()
              G.deck.config.card_limit = G.deck.config.card_limit + 1
              G.deck:emplace(copied_card)
              table.insert(G.playing_cards, copied_card)
              playing_card_joker_effects({ true })

              G.E_MANAGER:add_event(Event({
                func = function()
                  copied_card:start_materialize()
                  return true
                end
              }))

              return true
            end
          }))

          return {
            message = "KING!",
            colour = G.C.XMULT
          }
        end
      end
    end
  end
})

-- Peter Drent
local Peter_Drent = J({
name = "Peter_Drent",
  pos = { x = 7, y = 2 },
  config = { extra = { odds = 5, triggered = false } },
  loc_vars = function(self, info_queue, center)
    local count = #find_player_type("Mountain");
    local odds = center.ability.extra.odds - count
    if odds < 0 then
      odds = 1
    end
    return { vars = { G.GAME.probabilities.normal, odds } }
  end,
  rarity = 2,
  pools = { ["Royal Academy"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Mountain,
  pposition = C.DF,
  pteam = "ina_team_royal_academy",
  techtype = C.UPGRADES.Plus,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.after and context.cardarea == G.jokers then
      local count = #find_player_type("Mountain");
      local odds = card.ability.extra.odds - count
      if odds < 0 then
        odds = 1
      end
      if pseudorandom('group_0_05214300') < G.GAME.probabilities.normal / odds then
        SMODS.calculate_effect({
          func = function()
            local created_tarot = false
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
              created_tarot = true
              G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
              G.E_MANAGER:add_event(Event({
                func = function()
                  local tarot_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_tower')
                  tarot_card:add_to_deck()
                  G.consumeables:emplace(tarot_card)
                  G.GAME.consumeable_buffer = 0
                  return true
                end
              }))
              card.ability.extra.triggered = true
            end
            if created_tarot then
              card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                { message = "Quake!", colour = G.C.PURPLE })
            end
            return true
          end
        }, card)
      end
    end
  end
})

-- Ben Simmons
local Ben_Simmons = J({
  name = "Ben_Simmons",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.DF,
  pteam = "ina_team_royal_academy",
})

-- Alan Master
local Alan_Master = J({
name = "Alan_Master",
  pos = { x = 9, y = 2 },
  config = { extra = { mult_mod = 7, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.mult_mod } }
  end,
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "ina_team_royal_academy",
  techtype = C.UPGRADES.Plus,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      local index
      for k, v in ipairs(G.jokers.cards) do
        if v == card then
          index = k
          break
        end
      end
      if not G.jokers.cards[index - 1] then
        local count = #find_player_team("Royal Academy")
        return {
          message = localize { type = 'variable',
vars = { card.ability.extra.mult_mod * count } },
          colour = G.C.MULT,
          mult_mod = card.ability.extra.mult_mod * count
        }
      end
    end
  end,
})

-- Gus Martin
local Gus_Martin = J({
name = "Gus_Martin",
  pos = { x = 10, y = 2 },
  config = { extra = { common_mult = 6, uncommon_mult = 12, rare_xmult = 1.5, legendary_exp = 1.15, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return {
      vars = { center.ability.extra.common_mult, center.ability.extra.uncommon_mult,
        center.ability.extra.rare_xmult, center.ability.extra.legendary_exp }
    }
  end,
  rarity = 2,
  pools = { ["Royal Academy"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.DF,
  pteam = "ina_team_royal_academy",
  techtype = C.UPGRADES.Plus,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if not context.debuff then
      if context.other_joker and not context.other_joker.debuff
          and (context.other_joker.config.center.rarity == 3 or context.other_joker.config.center.rarity == "ina_top")
          and card ~= context.other_joker then
        card.ability.extra.triggered = true;
        G.E_MANAGER:add_event(Event({
          func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
          end
        }))
        return {
          message = localize { type = 'variable',
vars = { card.ability.extra.rare_xmult } },
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.rare_xmult
        }
      elseif context.other_joker and not context.other_joker.debuff and context.other_joker.config.center.rarity == 2 and card ~= context.other_joker then
        card.ability.extra.triggered = true;
        G.E_MANAGER:add_event(Event({
          func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
          end
        }))
        return {
          message = localize { type = 'variable',
vars = { card.ability.extra.uncommon_mult } },
          colour = G.C.MULT,
          mult_mod = card.ability.extra.uncommon_mult
        }
      elseif context.other_joker and not context.other_joker.debuff and context.other_joker.config.center.rarity == 1 and card ~= context.other_joker then
        card.ability.extra.triggered = true;
        G.E_MANAGER:add_event(Event({
          func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
          end
        }))
        return {
          message = localize { type = 'variable',
vars = { card.ability.extra.common_mult } },
          colour = G.C.MULT,
          mult_mod = card.ability.extra.common_mult
        }
      elseif context.other_joker and not context.other_joker.debuff and context.other_joker.config.center.rarity == 4 and card ~= context.other_joker then
        card.ability.extra.triggered = true;
        G.E_MANAGER:add_event(Event({
          func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
          end
        }))
        return {
          mult_message = {
            message = localize({
              type = "variable",
vars = { number_format(card.ability.extra.legendary_exp) },
            }),
            colour = G.C.DARK_EDITION,
          },
          mult = (mult ^ card.ability.extra.legendary_exp) - mult,
        }
      end
    end
  end,
})

-- Herman Waldon
local Herman_Waldon = J({
  name = "Herman_Waldon",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "ina_team_royal_academy",
})

-- John Bloom
local John_Bloom = J({
name = "John_Bloom",
  pos = { x = 12, y = 2 },
  config = { extra = { Xmult_mod = 3 } },
  loc_vars = function(self, info_queue, center)
    local grand_total = 0
    for _, card in pairs(G.GAME.cards_played) do
      grand_total = grand_total + card.total
    end
    return { vars = { center.ability.extra.Xmult_mod, grand_total } }
  end,
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = C.Fire,
  pposition = C.MF,
  pteam = "ina_team_royal_academy",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    local grand_total = 0
    for _, card in pairs(G.GAME.cards_played) do
      grand_total = grand_total + card.total
    end
    if context.joker_main and context.scoring_hand and next(context.poker_hands['Straight'])
        and grand_total >= 3 then
      return {
        Xmult = card.ability.extra.Xmult_mod
      }
    end
  end,
})

-- Derek Swing
local Derek_Swing = J({
name = "Derek_Swing",
  pos = { x = 0, y = 3 },
  config = { extra = { chips_mod = 60, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod } }
  end,
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "ina_team_royal_academy",
  blueprint_compat = true,
  techtype = C.UPGRADES.Number,
  calculate = function(self, card, context)
    if context.scoring_hand and context.joker_main and next(context.poker_hands['Three of a Kind']) then
      local count = #find_player_team("Royal Academy")
      card.ability.extra.triggered = true
      return {
        message = localize { type = 'variable',
vars = { card.ability.extra.chips_mod * count } },
        colour = G.C.CHIPS,
        chip_mod = card.ability.extra.chips_mod * count
      }
    end
  end,
})

-- Daniel Hatch
local Daniel_Hatch = J({
  name = "Daniel_Hatch",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "ina_team_royal_academy",
})

-- Jude Sharp
local Jude_Sharp = J({
name = "Jude_Sharp",
  pos = { x = 0, y = 0 },
  soul_pos = { x = 0, y = 1 },
  config = {
    extra = { current_xmult = 1, xmult_mod = 0.08, next_xmult = 1, triggered = false
    }
  },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.current_xmult, center.ability.extra.xmult_mod } }
  end,
  rarity = "ina_top",
  pools = { ["Royal Academy"] = true },
  cost = 8,
  atlas = "top",
  ptype = C.Wind,
  stage = "base",
  pposition = C.MF,
  pteam = "ina_team_royal_academy",
  techtype = C.UPGRADES.Plus,
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
        message = localize { type = 'variable',
vars = { card.ability.extra.current_xmult } },
        colour = G.C.XMULT,
        Xmult_mod = card.ability.extra.current_xmult
      }
    end
  end,
})

-- David Samford
local David_Samford = J({
name = "David_Samford",
  pos = { x = 4, y = 3 },
  config = { extra = { xmult_mod = 3, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.xmult_mod } }
  end,
  rarity = 2,
  pools = { ["Royal Academy"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.FW,
  pteam = "ina_team_royal_academy",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      if #find_player_position("FW") >= 2 and #find_player_position("MF") >= 1 then
        card.ability.extra.triggered = true
        return {
          message = localize { type = 'variable',
vars = { card.ability.extra.xmult_mod } },
          colour = G.C.XMULT,
          Xmult_mod = card.ability.extra.xmult_mod
        }
      end
    end
  end,
})

-- Bob Carlton
local Bob_Carlton = J({
  name = "Bob_Carlton",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Forest,
  pposition = C.GK,
  pteam = "ina_team_royal_academy",
})

-- Cliff Tomlinson
local Cliff_Tomlinson = J({
  name = "Cliff_Tomlinson",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.FW,
  pteam = "ina_team_royal_academy",
})

-- Jim Lawrenson
local Jim_Lawrenson = J({
  name = "Jim_Lawrenson",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.FW,
  pteam = "ina_team_royal_academy",
})

-- Barry Potts
local Barry_Potts = J({
  name = "Barry_Potts",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Wind,
  pposition = C.MF,
  pteam = "ina_team_royal_academy",
})

-- Steve Ingham
local Steve_Ingham = J({
  name = "Steve_Ingham",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Mountain,
  pposition = C.FW,
  pteam = "ina_team_royal_academy",
})

-- Caleb Stonewall
local Caleb_Stonewall = J({
  name = "Caleb_Stonewall",
  pos = { x = 0, y = 0 },
  config = {},
  rarity = 1,
  pools = { ["Royal Academy"] = true },
  cost = 4,
  atlas = "Jokers01",
  ptype = C.Fire,
  pposition = C.MF,
  pteam = "ina_team_royal_academy",
})

return {
  name = "Royal Academy",
  list = { Joseph_King, Peter_Drent, Gus_Martin, Alan_Master, John_Bloom, Derek_Swing, Jude_Sharp, David_Samford },
}
