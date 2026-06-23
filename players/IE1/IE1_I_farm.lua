-- Albert Green
local Albert_Green = J({
name = "Albert_Green",
    pos = { x = 12, y = 9 },
    config = { extra = { barriers_added = 1, DF_required = 2, barriers = 3 } },
    loc_vars = function(self, info_queue, center)
        table.insert(info_queue, { set = 'Other',
})
        return {
            vars = { center.ability.extra.barriers_added, center.ability.extra.DF_required,
                center.ability.extra.barriers }
        }
    end,
    rarity = 1, -- Common
    pools = { ["Farm"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.GK,
    pteam = "ina_team_farm",
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

-- Seward Hayseed
local Seward_Hayseed = J({
name = "Seward_Hayseed",
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
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_farm",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand and context.joker_main
            and card.ability.extra.current_mult > 0 then
            return {
                message = localize { type = 'variable',
vars = { card.ability.extra.current_mult } },
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

-- Kent Work
local Kent_Work = J({
    name = "Kent_Work",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.DF,
    pteam = "ina_team_farm",
})

-- Mark Hillvalley
local Mark_Hillvalley = J({
name = "Mark_Hillvalley",
    pos = { x = 2, y = 10 },
    config = { extra = { current_chips = 0, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.current_chips } }
    end,
    rarity = 1, -- Common
    pools = { ["Farm"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_farm",
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
                message = localize { type = 'variable',
vars = { card.ability.extra.current_chips } },
                colour = G.C.CHIPS,
                chip_mod = card.ability.extra.current_chips
            }
        end
    end,
})

-- Herb Sherman
local Herb_Sherman = J({
name = "Herb_Sherman",
    pos = { x = 3, y = 10 },
    config = { extra = { current_chips = 0, chip_mod = 5 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chip_mod, center.ability.extra.current_chips } }
    end,
    rarity = 1, -- Common
    pools = { ["Farm"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.DF,
    pteam = "ina_team_farm",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.post_trigger and context.other_card ~= card
            and context.other_card.ability and context.other_card.ability.extra.pteam
            and Pokerleven.normalize_team(context.other_card.ability.extra.pteam) == Pokerleven.normalize_team("Farm") then
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
                    message = localize { type = 'variable',
vars = { card.ability.extra.current_chips } },
                    colour = G.C.CHIPS,
                    chip_mod = card.ability.extra.current_chips
                }
            end
        end
    end,
})

-- Joe Small
local Joe_Small = J({
    name = "Joe_Small",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.MF,
    pteam = "ina_team_farm",
})

-- Ike Steiner
local Ike_Steiner = J({
    name = "Ike_Steiner",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.MF,
    pteam = "ina_team_farm",
})

-- Orville Newman
local Orville_Newman = J({
name = "Orville_Newman",
    pos = { x = 6, y = 10 },
    config = { extra = { current_Xmult = 1, max_money = 4, Xmult_mod = 0.25, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.max_money, center.ability.extra.Xmult_mod, center.ability.extra.current_Xmult } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Farm"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.MF,
    pteam = "ina_team_farm",
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
                message = localize { type = 'variable',
vars = { card.ability.extra.current_Xmult } },
                colour = G.C.XMULT,
                Xmult_mod = card.ability.extra.current_Xmult
            }
        end
    end,
})

-- Tom Walters
local Tom_Walters = J({
    name = "Tom_Walters",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.MF,
    pteam = "ina_team_farm",
})

-- Daniel Dawson
local Daniel_Dawson = J({
name = "Daniel_Dawson",
    pos = { x = 7, y = 10 },
    config = { extra = { max_money = 2, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.max_money } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Farm"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.MF,
    pteam = "ina_team_farm",
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

-- Stuart Racoonfur
local Stuart_Racoonfur = J({
name = "Stuart_Racoonfur",
    pos = { x = 8, y = 10 },
    config = { extra = { current_mult = 0, mult_mod_low = 3, triggered = false } },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = 'Other',
}
        return { vars = { center.ability.extra.mult_mod_low, center.ability.extra.current_mult } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Farm"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.FW,
    pteam = "ina_team_farm",
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
                message = localize { type = 'variable',
vars = { card.ability.extra.current_mult } },
                colour = G.C.MULT,
                mult_mod = card.ability.extra.current_mult,
            }
        end
    end,
})

-- Lorne Mower
local Lorne_Mower = J({
    name = "Lorne_Mower",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.GK,
    pteam = "ina_team_farm",
})

-- Homer Grower
local Homer_Grower = J({
    name = "Homer_Grower",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_farm",
})

-- Rolf Howells
local Rolf_Howells = J({
    name = "Rolf_Howells",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.DF,
    pteam = "ina_team_farm",
})

-- Luke Lively
local Luke_Lively = J({
    name = "Luke_Lively",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.DF,
    pteam = "ina_team_farm",
})

-- Ben Nevis
local Ben_Nevis = J({
    name = "Ben_Nevis",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Farm"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.DF,
    pteam = "ina_team_farm",
})

return {
    name = "Farm",
    list = { Albert_Green, Seward_Hayseed, Mark_Hillvalley, Herb_Sherman, Orville_Newman, Daniel_Dawson, Stuart_Racoonfur },
}
