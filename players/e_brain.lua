-- Feldt
local Feldt = J({
    name = "Feldt",
    pos = { x = 0, y = 5 },
    config = { extra = { barriers = 1, Xmult_mod = 1 } },
    loc_vars = function(self, info_queue, center)
        local Xmult_mod = center.ability.extra.Xmult_mod
        local current_mult = Xmult_mod * #find_player_type('Forest')
        return { vars = { center.ability.extra.barriers, Xmult_mod, current_mult } }
    end,
    rarity = 3, -- Rare
    pools = { ["Brain"] = true },
    cost = 8,
    atlas = "Jokers01",
    ptype = "Forest",
    pposition = "GK", -- Goalkeeper
    pteam = "Brain",
    techtype = C.UPGRADES.Number,
    numberTechType = C.UPGRADES.NumberType.Z,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if Pokerleven.is_joker_last_hand(context) and G.GAME.current_round.barriers > 0 then
            local current_mult = #find_player_type('Forest') * card.ability.extra.Xmult_mod
            Pokerleven.ease_barriers(-G.GAME.current_round.barriers)
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { current_mult } },
                colour = G.C.MULT,
                Xmult_mod = current_mult
            }
        end

        if Pokerleven.is_joker_turn(context) then
            if Pokerleven.get_cards_of_suite('Spades', context.scoring_hand) >= 3 then
                local barriers = card.ability.extra.barriers
                return Pokerleven.ease_barriers(barriers)
            end
        end
    end
})

-- Marvel
local Marvel = {
    name = "Marvel",
    pos = { x = 3, y = 5 },
    config = { extra = { mult_mod = 10, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult_mod } }
    end,
    rarity = 1, -- Common
    pools = { ["Brain"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Mountain",
    pposition = "DF", -- Defense
    pteam = "Brain",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            function count_ones_in_binary(n)
                local count = 0
                while n > 0 do
                    if n % 2 == 1 then
                        count = count + 1
                    end
                    n = math.floor(n / 2)
                end
                return count
            end

            if count_ones_in_binary(context.other_card:get_chip_bonus()) == 3 then
                card.ability.extra.triggered = true
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } },
                    colour = G.C.MULT,
                    mult_mod = card.ability.extra.mult_mod
                }
            end
        end
    end
}

-- Tell
local Tell = {
    name = "Tell",
    pos = { x = 6, y = 5 },
    config = { extra = { Xchips_mod = 3.1416 } },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 2, -- Uncommon
    pools = { ["Brain"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Forest",
    pposition = "MF", -- Midfielder
    pteam = "Brain",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and G.hand and G.hand.cards then
            local values = {}
            for _, c in ipairs(G.hand.cards) do
                table.insert(values, c:get_id())
            end

            for i = 1, #values - 2 do
                if values[i] == 3 and values[i + 1] == 14 and values[i + 2] == 4 then
                    return {
                        message = "Pi!",
                        colour = G.C.RED,
                        card = card,
                        Xchip_mod = card.ability.extra.Xchips_mod
                    }
                end
            end
        end
    end,
}

-- Seller
local Seller = {
    name = "Seller",
    pos = { x = 8, y = 5 },
    config = { extra = { sell_potential = 0, sell_mod = 1, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.sell_potential, center.ability.extra.sell_mod } }
    end,
    rarity = 1, -- Common
    pools = { ["Brain"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "FW", -- Forward
    pteam = "Brain",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and context.main_eval then
            card.ability.extra.triggered = true
            card.ability.extra.sell_potential =
                (card.ability.extra.sell_potential or 0) + (card.ability.extra.sell_mod or 0)
            return {
                message = localize("ina_potential_increased"),
                colour = G.C.DARK_EDITION,
                card = card,
            }
        end

        if context.selling_self then
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    joker.sell_cost = (joker.sell_cost or 0) + (card.ability.extra.sell_potential or 0)
                end
            end
            card.ability.extra.triggered = true
            return {
                message = localize("ina_sell_increased"),
                colour = G.C.DARK_EDITION,
                card = card,
            }
        end
    end,
    ina_credits = {
        idea = { "Shadorossa" }
    }
}

-- Kind
local Kind = {
    name = "Kind",
    pos = { x = 9, y = 5 },
    config = { extra = { triggered = false } },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 2, -- Uncommon
    pools = { ["Brain"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Forest",
    pposition = "MF", -- Midfielder
    pteam = "Brain",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local ids = {}
            for i = 1, 5 do
                local card_i = context.scoring_hand[i]
                if card_i then
                    table.insert(ids, card_i:get_id())
                end
            end

            local function is_sequence_palindrome(tbl)
                local len = #tbl
                for i = 1, math.floor(len / 2) do
                    if tostring(tbl[i]) ~= tostring(tbl[len - i + 1]) then
                        return false
                    end
                end
                return len > 1
            end

            if is_sequence_palindrome(ids) then
                card.ability.extra.triggered = true
                local retriggerCount = 1
                if context.other_card == context.scoring_hand[1] or context.other_card == context.scoring_hand[#context.scoring_hand] then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = retriggerCount,
                        card = context.other_card
                    }
                end
            end
        end
    end
}

-- Turner
local Turner = {
    name = "Turner",
    pos = { x = 10, y = 5 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 2, -- Uncommon
    pools = { ["Brain"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "FW", -- Forward
    pteam = "Brain",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and G.GAME.current_round.hands_played == 0
            and next(context.poker_hands['Four of a Kind']) then
            card.ability.extra.triggered = true
            for i = 1, #find_player_team("Brain") do
                G.E_MANAGER:add_event(Event({
                    delay = 2,
                    func = function()
                        local copied_card = copy_card(context.scoring_hand[1], nil, nil, G.playing_card or 1)
                        copied_card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        G.hand:emplace(copied_card)
                        table.insert(G.playing_cards, copied_card)
                        playing_card_joker_effects({ true })

                        return true
                    end
                }))
            end
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                card = card,
                playing_cards_created = { true }
            }
        end
    end
}

-- Under
local Under = {
    name = "Under",
    pos = { x = 11, y = 5 },
    config = { extra = { chips_mod = 120, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chips_mod, #find_player_position("GK") or 0 } }
    end,
    rarity = 1, -- Common
    pools = { ["Brain"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Forest",
    pposition = "GK", -- Goalkeeper
    pteam = "Brain",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local gkCount = #find_player_position("GK")
            local result = card.ability.extra.chips_mod / (math.log(gkCount + 1) / math.log(2))
            card.ability.extra.triggered = true

            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { result } },
                colour = G.C.CHIPS,
                chip_mod = result
            }
        end
    end
}

return {
    name = "Brain",
    list = { Feldt, Marvel, Tell, Seller, Kind, Turner, Under },
}
