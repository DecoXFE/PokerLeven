-- Poseidon
local Poseidon = {
  name = "Poseidon",
  pos = { x = 6, y = 12 },
  config = { extra = { min_face = 3, barriers_added = 1, chips_mod = 40, barriers = 1 } },
  loc_vars = function(self, info_queue, center)
    table.insert(info_queue, { set = "Other", key = "Frontal" })
    local barriers = center.ability.extra.barriers_added
    local chips_mod = center.ability.extra.chips_mod
    local min_face = center.ability.extra.min_face

    local current_barriers = G.GAME.current_round.barriers or 0
    local actual_chips_mod = current_barriers * chips_mod
    return { vars = { barriers, min_face, chips_mod, actual_chips_mod } }
  end,
  rarity = 3, -- Rare
  pools = { ["Zeus"] = true },
  cost = 8,
  atlas = "Jokers01",
  ptype = "Mountain",
  pposition = "GK",
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if Pokerleven.is_joker_turn(context)
        and card:is_leftmost_joker()
        and card:has_enough_barriers() then
      local current_barriers = G.GAME.current_round.barriers
      local chips_mod = current_barriers * card.ability.extra.chips_mod
      card_eval_status_text(card, 'extra', nil, nil, nil, Pokerleven.ease_barriers(-current_barriers))
      return {
        chips = chips_mod
      }
    end

    if Pokerleven.is_joker_turn(context)
        and #context.scoring_hand > 2
        and Pokerleven.are_all_face(context) then
      local barriers = card.ability.extra.barriers_added
      return Pokerleven.ease_barriers(barriers)
    end
  end
}

local Hephestus = J({
  name = "Hephestus",
  pos = { x = 10, y = 12 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
  end,
  rarity = 2,
  pools = { ["Zeus"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Fire",
  pposition = "DF",
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.blind_defeated and not context.blueprint then
      local count = #Pokerleven.find_player_type_and_position("Fire", "DF")

      if count > 0 and G.deck and G.deck.cards and #G.deck.cards > 0 then
        table.unpack = table.unpack or unpack

        local candidates = { table.unpack(G.deck.cards) }

        for i = 1, count do
          if #candidates == 0 then break end

          local steelCard = pseudorandom_element(candidates, pseudoseed("steel_card_" .. i))
          if steelCard then
            convert_cards_to(steelCard, { mod_conv = "m_steel", true, true })
            card_eval_status_text(steelCard, 'extra', nil, nil, nil,
              { message = localize("ina_convert"), colour = G.C.MULT })

            for j, c in ipairs(candidates) do
              if c == steelCard then
                table.remove(candidates, j)
                break
              end
            end
          end
        end
      end
    end
  end
})

-- Apollo
local Apollo = {
  name = "Apollo",
  pos = { x = 7, y = 12 },
  config = { extra = { chips_mod = 11, alt_chips_mod = 4, current_chips = 0, triggered = false } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips_mod, center.ability.extra.alt_chips_mod, center.ability.extra.current_chips } }
  end,
  rarity = 1,
  pools = { ["Zeus"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "DF",
  pteam = "Zeus",
  blueprint_compat = true,

  calculate = function(self, card, context)
    if Pokerleven.is_joker_turn(context) and card.ability.extra.current_chips > 0 then
      return {
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
        chip_mod = card.ability.extra.current_chips,
        colour = G.C.CHIPS
      }
    end

    if context.before and context.cardarea == G.jokers and context.scoring_hand
        and next(context.poker_hands["Two Pair"]) then
      local hour = tonumber(os.date("%H"))
      local mod = card.ability.extra.alt_chips_mod

      if hour >= 14 and hour < 19 then
        mod = card.ability.extra.chips_mod
      end

      card.ability.extra.current_chips = card.ability.extra.current_chips + mod

      return {
        message = localize("k_upgrade_ex"),
        colour = G.C.CHIPS
      }
    end
  end,
}

-- Artemis
local Artemis = J({
  name = "Artemis",
  pos = { x = 10, y = 12 },
  config = { extra = { current_chips = 0, chips_mod = 10 } },
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue + 1] = { set = 'Other', key = 'Harvester' }
    return { vars = { center.ability.extra.chips_mod, center.ability.extra.current_chips } }
  end,
  rarity = 2, -- Uncommon
  pools = { ["Zeus"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Wind",
  pposition = "MF", -- Midfielder
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.discard and context.other_card.ability["ina_harvest_sticker"] == true then
      card.ability.extra.current_chips =
          card.ability.extra.current_chips + card.ability.extra.chips_mod
      context.other_card.ability["ina_harvest_sticker"] = false
      return {
        message = localize("ina_harvest"),
        colour = G.C.MULT,
        card = context.other_card
      }
    end
    if context.individual
        and context.cardarea == G.play
        and context.scoring_hand
        and context.other_card ~= nil
        and context.other_card:is_face() then
      context.other_card.ability["ina_harvest_sticker"] = true
      return {
        message = localize("ina_seed"),
        colour = G.C.MULT,
        card = context.other_card
      }
    end

    if context.scoring_hand and context.cardarea == G.jokers and context.joker_main
        and card.ability.extra.current_chips > 0 then
      card.ability.extra.triggered = true
      return {
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
        colour = G.C.CHIPS,
        mult_mod = card.ability.extra.current_chips,
      }
    end
  end,
})

-- Hermes
local Hermes = {
  name = "Hermes",
  pos = { x = 11, y = 12 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, center)
    return {}
  end,
  rarity = 2, -- Uncommon
  pools = { ["Zeus"] = true },
  cost = 7,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "MF", -- Midfielder
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.individual and context.other_card and G.GAME.current_round.hands_played == 0
        and context.cardarea == G.play and context.scoring_hand
        and next(context.poker_hands["Pair"]) and #context.scoring_hand == 2 then
      convert_cards_to(context.other_card, {
        mod_conv = "m_gold"
      }, false, false)
      return {
        message = localize("ina_convert"),
        colour = G.C.XMULT,
        card = context.other_card,
      }
    end
  end
}

-- Demeter
local Demeter = {
  name = "Demeter",
  pos = { x = 0, y = 13 },
  config = { extra = { mult_mod = 4, chip_mod = 10 } },
  loc_vars = function(self, info_queue, center)
    local remaining_discards = G.GAME and G.GAME.current_round and G.GAME.current_round.discards_left or 0
    return {
      vars = {
        center.ability.extra.mult_mod,
        center.ability.extra.chip_mod,
        remaining_discards * center.ability.extra.mult_mod,
        remaining_discards * center.ability.extra.chip_mod
      }
    }
  end,
  rarity = 1,
  pools = { ["Zeus"] = true },
  cost = 5,
  atlas = "Jokers01",
  ptype = "Fire",
  pposition = "FW",
  pteam = "Zeus",
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      local remaining_discards = G.GAME.current_round.discards_left or 0
      local extra_mult = card.ability.extra.mult_mod * remaining_discards
      local extra_chips = card.ability.extra.chip_mod * remaining_discards

      if extra_mult > 0 or extra_chips > 0 then
        return {
          message = localize("ina_divine"),
          colour = G.C.MULT,
          mult_mod = extra_mult,
          chip_mod = extra_chips,
        }
      end
    end
  end,
}

-- Aphrodite
---@param card Card
local swap_random_to_fw_or_mf = function(card)
  local POS_FW = "FW"
  local POS_MF = "MF"

  local roll = math.random()
  local selected_pos = (roll < card.ability.extra.mf_probability) and POS_MF or POS_FW

  apply_property_sticker(card, selected_pos, "position")

  card_eval_status_text(card, 'extra', nil, nil, nil,
    { message = selected_pos, colour = G.C.DARK_EDITION })
end

local get_byron_xmult = function(card, selected_position)
  local MULT_KEYS = {
    MF = "byron_mult_mf",
    FW = "byron_mult_fw"
  }

  local position_count = #find_player_position(selected_position)
  local zeus_count = #find_player_team("Zeus")

  local mult_key = MULT_KEYS[selected_position] or MULT_KEYS.MF
  local selected_mult = card.ability.extra[mult_key]

  local turns_left = (selected_position == "FW")
      and G.GAME.current_round.discards_left
      or G.GAME.current_round.hands_left

  local factor = position_count + zeus_count
  local Xmult_mod = 1 + selected_mult * factor * turns_left
  return Xmult_mod
end

---@param card Card
---@param selected_position string
local select_byron_ability = function(card, selected_position)
  local Xmult_mod = get_byron_xmult(card, selected_position)

  return {
    message = localize {
      type = 'variable',
      key = 'a_xmult',
      vars = { Xmult_mod }
    },
    colour = G.C.MULT,
    Xmult_mod = Xmult_mod
  }
end

local Aphrodite = J({
  name = "Aphrodite",
  pos = { x = 1, y = 13 },
  config = { extra = { mf_probability = 0.7, byron_mult_fw = 0.3, byron_mult_mf = 0.15 } },
  loc_vars = function(self, info_queue, center)
    local position = center.ability.extra.pposition
    return { vars = { center.ability.extra.byron_mult_fw, center.ability.extra.byron_mult_mf, get_byron_xmult(center, position) } }
  end,
  rarity = 4, -- Legendary
  cost = 15,
  atlas = "Jokers01",
  ptype = "Forest",
  pposition = "MF", -- Midfielder
  pteam = "Zeus",
  techtype = C.UPGRADES.Plus,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if Pokerleven.is_joker_end_of_round(context) then
      return swap_random_to_fw_or_mf(card)
    end

    if Pokerleven.is_joker_turn(context) then
      byron_position = card.ability.extra.pposition
      return select_byron_ability(card, byron_position)
    end
  end,
  unlocked = false,
  check_for_unlock = function(self, args)
    if G and G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante and G.GAME.round_resets.ante > 8 then
      unlock_card(self)
    end
  end,
})

return {
  name = "Zeus",
  list = { Poseidon, Apollo, Hephestus, Artemis, Hermes, Demeter, Aphrodite },
}
