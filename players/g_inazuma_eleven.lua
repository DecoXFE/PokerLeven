-- Inazuma Eleven Jokers
local hillman = J({
  name = "Hillman",
  pos = { x = 6, y = 7 },
  config = { extra = { Xchip_mod = 0.2, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return {
      vars = {
        center.ability.extra.Xchip_mod,
        1 + center.ability.extra.Xchip_mod * (G.GAME.strat_cards_used or 0) }
    }
  end,
  rarity = 3, -- Rare
  pools = { ["Inazuma Eleven"] = true },
  cost = 8,
  atlas = "Jokers01",
  ptype = "Mountain",
  pposition = "GK",
  pteam = "Inazuma Eleven",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      return {
        message = localize {
          type = 'variable',
          key = 'a_xchips',
          vars = { 1 + card.ability.extra.Xchip_mod * (G.GAME.strat_cards_used or 0) } },
        colour = G.C.CHIPS,
        Xchip_mod = 1 + card.ability.extra.Xchip_mod * (G.GAME.strat_cards_used or 0),
      }
    end
  end,
  ina_credits = {
    idea = { 'LegendaryAd' }
  }
})

local island = J({
  name = "Island",
  pos = { x = 7, y = 7 },
  config = { extra = { current_chips = 0, chips_mod = 10, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return {
      vars = {
        center.ability.extra.chips_mod,
        center.ability.extra.current_chips
      }
    }
  end,
  rarity = 1, -- Common
  pools = { ["Inazuma Eleven"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "DF",
  pteam = "Inazuma Eleven",
  techtype = C.UPGRADES.Number,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers
        and next(context.poker_hands['Two Pair']) and not context.blueprint then
      card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.chips_mod

      card.ability.extra.triggered = true
      return {
        message = localize('k_upgrade_ex'),
        colour = G.C.CHIPS,
        card = card
      }
    end

    if context.scoring_hand and context.joker_main then
      card.ability.extra.triggered = true
      return {
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
        colour = G.C.CHIPS,
        chip_mod = card.ability.extra.current_chips
      }
    end
  end,
  ina_credits = {
    idea = { 'Shadorossa' }
  }
})

-- Sweet
local sweet = J({
  name = "Sweet",
  pos = { x = 9, y = 7 },
  config = {
    extra = {
      triggered = false,
      rarity_chance = 0.20,
      raimon_chance = 0.5
    }
  },
  rarity = 1, -- Common
  pools = { ["Inazuma Eleven"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Mountain",
  pposition = "DF",
  pteam = "Inazuma Eleven",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local spawn_effect = spawn_random_ina_joker(card, context,
        {
          ["Common"] = 0.8,
          ["Uncommon"] = 0.2
        },
        {
          ["Raimon"] = 0.5,
          ["Inazuma Eleven"] = 0.5,
        }
      )
      spawn_effect.func()
    end
  end,
  ina_credits = {
    idea = { 'LegendaryAd' }
  }
})

-- Butler
local butler = J({
  name = "Butler",
  pos = { x = 10, y = 7 },
  config = {
    extra = {
      dollars_mod = 4,
      chips_mod = 1,
      triggered = false,
      bankrupt_at = 20
    }
  },
  loc_vars = function(self, info_queue, center)
    return {
      vars = { center.ability.extra.bankrupt_at, center.ability.extra.dollars_mod,
        center.ability.extra.chips_mod }
    }
  end,
  rarity = 1, -- Common
  pools = { ["Inazuma Eleven"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "MF",
  pteam = "Inazuma Eleven",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.scoring_hand and context.cardarea == G.play
        and context.other_card and to_big(G.GAME.dollars) < to_big(0) then
      local raw_division = -to_number(G.GAME.dollars) / 4
      local chips_to_add = math.floor(raw_division) * card.ability.extra.chips_mod
      if chips_to_add ~= 0 then
        context.other_card.ability.bonus =
            context.other_card.ability.bonus + chips_to_add
        card.ability.extra.triggered = true
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.CHIPS,
          card = context.other_card
        }
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.bankrupt_at
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.bankrupt_at
  end
})

-- Barista
local barista = J({
  name = "Barista",
  pos = { x = 1, y = 8 },
  config = {},
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 2, -- Uncommon
  pools = { ["Inazuma Eleven"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Wind",
  pposition = "FW",
  pteam = "Inazuma Eleven",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.scoring_hand and context.cardarea == G.play
        and context.other_card == context.scoring_hand[#context.scoring_hand] then
      return {
        chips = context.other_card:get_chip_bonus() * 2,
        card = context.other_card
      }
    end
  end,
  ina_credits = {
    idea = { 'LegendaryAd' }
  }
})

local builder = J({
  name = "Builder",
  pos = { x = 3, y = 8 },
  config = {},
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 2, -- Uncommon
  pools = { ["Inazuma Eleven"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Fire",
  pposition = "FW",
  pteam = "Inazuma Eleven",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.final_scoring_step
        and next(context.poker_hands['Full House']) and not context.blueprint then
      local steelCard = pseudorandom_element(context.scoring_hand, pseudoseed("steel_card"))
      local filtered_cards = {}
      for _, c in ipairs(context.scoring_hand) do
        if c ~= steelCard then
          table.insert(filtered_cards, c)
        end
      end

      card.ability.extra.triggered = true

      local destroyedCard = pseudorandom_element(filtered_cards, pseudoseed("destroyed_card"))
      local destroy_index
      for i, v in ipairs(context.scoring_hand) do
        if v == destroyedCard then
          destroy_index = i
        end
      end

      context.full_hand[destroy_index].to_be_removed_by = card

      convert_cards_to(steelCard, { mod_conv = "m_steel", true, true })
      card_eval_status_text(steelCard, 'extra', nil, nil, nil,
        { message = localize("ina_convert"), colour = G.C.MULT })
    end

    if context.destroy_card and context.destroy_card.to_be_removed_by == card and not context.blueprint then
      context.destroy_card.to_be_removed_by = nil
      card.ability.extra.triggered = true
      card_eval_status_text(context.destroy_card, 'extra', nil, nil, nil,
        { message = localize("ina_destroy"), colour = G.C.DARK_EDITION })
      return {
        remove = true,
      }
    end
  end,
})

return {
  name = "Inazuma Eleven",
  list = { hillman, island, sweet, butler, barista, builder },
}
