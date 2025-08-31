-- Farm Jokers

local Greeny = J({
    name = "Greeny",
    pos = { x = 12, y = 9 },
    config = { extra = { barriers_added = 1, DF_required = 2, barriers = 3 }
    },
    loc_vars = function(self, info_queue, center)
        table.insert(info_queue, { set = 'Other', key = 'Right_Footed' })
        return {
            vars = { center.ability.extra.barriers_added, center.ability.extra.DF_required,
                center.ability.extra.barriers }
        }
    end,
    rarity = 1, -- Common
    pools = { ["Farm"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "GK",
    pteam = "Farm",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind
            and card:has_enough_barriers()
            and card:is_rightmost_joker() and
            Pokerleven.has_enough_consumables_space() then
            combinations = Pokerleven.get_all_type_pos_combinations()
            local selected_combination = pseudorandom_element(combinations, pseudoseed('training'))

            local new_card = create_card(C.TRAINING, G.consumeables, nil, nil, true, true,
                selected_combination, nil)

            Pokerleven.ease_barriers(-card.ability.extra.barriers)
            Pokerleven.add_card_to_consumables(new_card)

            return {
                message = localize("ina_technique_card"),
                colour = G.C.MULT
            }
        end

        if context.setting_blind then
            local df_required = card.ability.extra.DF_required
            if Pokerleven.has_enough_position(C.DF, df_required) then
                local barriers_added = card.ability.extra.barriers_added
                return Pokerleven.ease_barriers(barriers_added, true)
            end
        end
    end
})


local Hayseed = J({
    name = "Hayseed",
    pos = { x = 0, y = 10 },
    config = {
        extra = {
            current_mult = 0,
            mult_mod_low = 4
        }
    },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult_mod_low, center.ability.extra.current_mult or 0 } }
    end,
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Mountain",
    pposition = "DF",
    pteam = "Farm",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand and context.joker_main
            and card.ability.extra.current_mult > 0 then
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
                mult_mod = card.ability.extra.current_mult,
                colour = G.C.MULT
            }
        end
        if context.before and context.cardarea == G.jokers and context.scoring_hand
            and next(context.poker_hands["Three of a Kind"]) and #context.scoring_hand == 3 then
            card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod_low
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
    end,
})


local Sherman = J({
    name = "Sherman",
    pos = { x = 3, y = 10 },
    config = { extra = { current_chips = 0, chip_mod = 5 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chip_mod, center.ability.extra.current_chips } }
    end,
    rarity = 1, -- Common
    pools = { ["Farm"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "DF",
    pteam = "Farm",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.post_trigger and context.other_card ~= card
            and context.other_card.ability and context.other_card.ability.extra.pteam
            and context.other_card.ability.extra.pteam == "Farm" then
            card.ability.extra.current_chips =
                card.ability.extra.current_chips + card.ability.extra.chip_mod

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

        if context.scoring_hand and context.cardarea == G.jokers
            and context.joker_main then
            if card.ability.extra.current_chips > 0 then
                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
                    colour = G.C.CHIPS,
                    chip_mod = card.ability.extra.current_chips
                }
            end
        end
    end,
})

local Spray = J({
    name = "Spray",
    pos = { x = 6, y = 10 },
    config = { extra = { current_Xmult = 1, max_money = 4, Xmult_mod = 0.25, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.max_money, center.ability.extra.Xmult_mod, center.ability.extra.current_Xmult } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Farm"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "MF",
    pteam = "Farm",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind then
            if G.GAME.dollars < card.ability.extra.max_money then
                card.ability.extra.current_Xmult = card.ability.extra.current_Xmult + card.ability.extra.Xmult_mod
                card.ability.extra.triggered = true
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                }
            end
        end

        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.current_Xmult > 1 then
            card.ability.extra.triggered = true
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.current_Xmult } },
                colour = G.C.XMULT,
                Xmult_mod = card.ability.extra.current_Xmult
            }
        end
    end,
})

local Dawson = J({
    name = "Dawson",
    pos = { x = 7, y = 10 },
    config = { extra = { max_money = 2, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.max_money } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Farm"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "MF",
    pteam = "Farm",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and G.GAME.dollars < card.ability.extra.max_money
            and #context.full_hand == 1 then
            G.E_MANAGER:add_event(Event({
                delay = 0.5,
                func = function()
                    local copy = copy_card(context.scoring_hand[1], nil, nil, G.playing_card)
                    copy:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copy)
                    G.deck:emplace(copy)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            copy:start_materialize()
                            return true
                        end
                    }))

                    return true
                end
            }))

            card.ability.extra.triggered = true
            return {
                message = "DAWSON!",
                colour = G.C.XMULT
            }
        end
    end,
})

local Muffs = J({
    name = "Muffs",
    pos = { x = 8, y = 10 },
    config = { extra = { current_mult = 0, mult_mod_low = 3, triggered = false } },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = 'Other', key = 'Harvester' }
        return { vars = { center.ability.extra.mult_mod_low, center.ability.extra.current_mult } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Farm"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Forest",
    pposition = "FW",
    pteam = "Farm",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.discard and context.other_card.ability["ina_harvest_sticker"] == true then
            card.ability.extra.current_mult =
                card.ability.extra.current_mult + card.ability.extra.mult_mod_low
            card.ability.extra.triggered = true
            return {
                message = localize("ina_harvest"),
                colour = G.C.MULT,
                card = context.other_card
            }
        end
        if context.after and context.cardarea == G.jokers then
            local random_index = math.random(1, #G.hand.cards)
            local selected_card = G.hand.cards[random_index]

            G.E_MANAGER:add_event(Event({
                delay = 0.5,
                func = function()
                    selected_card.ability["ina_harvest_sticker"] = true
                    return true
                end
            }))
            card.ability.extra.triggered = true
            return {
                message = localize("ina_seed"),
                colour = G.C.MULT,
                card = selected_card
            }
        end

        if context.scoring_hand and context.cardarea == G.jokers and context.joker_main
            and card.ability.extra.current_mult > 0 then
            card.ability.extra.triggered = true
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
                colour = G.C.MULT,
                mult_mod = card.ability.extra.current_mult,
            }
        end
    end,
})

local Hillvalley = J({
    name = "Hillvalley",
    pos = { x = 2, y = 10 },
    config = { extra = { current_chips = 0, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.current_chips } }
    end,
    rarity = 1, -- Common
    pools = { ["Farm"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Mountain",
    pposition = "DF",
    pteam = "Farm",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.scoring_hand and context.other_card and
            context.cardarea == G.play and
            (context.other_card:get_id() == 8 or
                context.other_card:get_id() == 9 or
                context.other_card:get_id() == 10) then
            card.ability.extra.current_chips = card.ability.extra.current_chips + context.other_card:get_id()
            card.ability.extra.triggered = true
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                card = card
            }
        end

        if context.scoring_hand and context.joker_main and card.ability.extra.current_chips > 0 then
            card.ability.extra.triggered = true
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chips } },
                colour = G.C.CHIPS,
                chip_mod = card.ability.extra.current_chips
            }
        end
    end,
})

return {
    name = "Farm",
    list = { Greeny, Hayseed, Hillvalley, Sherman, Spray, Dawson, Muffs, },
}
