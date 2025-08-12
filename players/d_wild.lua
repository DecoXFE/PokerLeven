-- Chicken
local Chicken = {
    name = "Chicken",
    pos = { x = 11, y = 3 },
    config = { extra = { money = 4, odds = 2, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { '' .. (G.GAME and G.GAME.probabilities.normal or 1), center.ability.extra.odds, center.ability.extra.money } }
    end,
    rarity = 3, -- Rare
    pools = { ["Wild"] = true },
    cost = 8,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "MF", -- Midfielder
    pteam = "Wild",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and not context.end_of_round and context.cardarea == G.play and context.scoring_hand then
            if SMODS.has_enhancement(context.other_card, 'm_wild') then
                if pseudorandom('chicken') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    card.ability.extra.triggered = true
                    return {
                        dollars = card.ability.extra.money,
                        card = card
                    }
                end
            end
        end
    end,
}

-- Boar
local Boar = {
    name = "Boar",
    pos = { x = 10, y = 3 },
    config = { extra = { triggered = false } },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, -- Common
    pools = { ["Wild"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "GK", -- Goalkeeper
    pteam = "Wild",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.scoring_name == "Pair" and context.destroying_card and not context.blueprint then
            if context.scoring_hand[1]:get_id() == 2
                and not context._wildtag_triggered then
                context._wildtag_triggered = true
                card.ability.extra.triggered = true
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_ina_wild_tag'))
                        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end)
                }))
            end
            return true
        end
    end,
    ina_credits = {
        idea = { "YellowAlberto" }
    }
}

-- Chamaleon
local Chamaleon = J({
    name = "Chamaleon",
    pos = { x = 2, y = 4 },
    config = { extra = { triggered = false } },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 2, -- Uncommon
    pools = { ["Wild"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "MF", -- Midfielder
    pteam = "Wild",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main
            and next(context.poker_hands['Flush']) then
            local suit_counts = {
                Clubs = 0,
                Hearts = 0,
                Spades = 0,
                Diamonds = 0
            }

            for _, c in ipairs(context.full_hand) do
                if c:is_suit("Clubs") and not SMODS.has_enhancement(c, 'm_wild') then
                    suit_counts.Clubs = suit_counts
                        .Clubs + 1
                end
                if c:is_suit("Hearts") and not SMODS.has_enhancement(c, 'm_wild') then
                    suit_counts.Hearts = suit_counts
                        .Hearts + 1
                end
                if c:is_suit("Spades") and not SMODS.has_enhancement(c, 'm_wild') then
                    suit_counts.Spades = suit_counts
                        .Spades + 1
                end
                if c:is_suit("Diamonds") and not SMODS.has_enhancement(c, 'm_wild') then
                    suit_counts.Diamonds =
                        suit_counts.Diamonds + 1
                end
            end

            local outlier_suit = nil
            for suit, count in pairs(suit_counts) do
                if count == 1 then
                    outlier_suit = suit
                    break
                end
            end

            if outlier_suit then
                for _, c in ipairs(context.full_hand) do
                    if c:is_suit(outlier_suit) and not SMODS.has_enhancement(c, 'm_wild') then
                        convert_cards_to(c, { mod_conv = "m_wild", true, true })
                        return {
                            message = localize("ina_convert"),
                            colour = G.C.DARK_EDITION,
                            card = card,
                        }
                    end
                end
            end
        end
    end,
    ina_credits = {
        idea = {
            "Shadorossa",
        }
    },
})

-- Eagle
local Eagle = {
    name = "Eagle",
    pos = { x = 3, y = 4 },
    config = { extra = { current_mult = 0, mult_mod = 1, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult_mod, center.ability.extra.current_mult } }
    end,
    rarity = 1, -- Common
    pools = { ["Wild"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "MF", -- Midfielder
    pteam = "Wild",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers
            and next(context.poker_hands['Straight']) and not context.blueprint then
            local count = 0
            for _, c in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(c, 'm_wild') then
                    count = count + 1
                end
            end
            card.ability.extra.current_mult = card.ability.extra.current_mult + (card.ability.extra.mult_mod * count)
            if count > 0 then
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT,
                    card = card
                }
            end
        end

        if context.joker_main then
            card.ability.extra.triggered = true
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.current_mult } },
                colour = G.C.MULT,
                mult_mod = card.ability.extra.current_mult
            }
        end
    end,
    ina_credits = {
        idea = {
            "Shadorossa",
        }
    },
}

-- Monkey
local Monkey = {
    name = "Monkey",
    pos = { x = 4, y = 4 },
    config = { extra = { wild_count = 0, triggered = false } },
    loc_vars = function(self, info_queue, center)
        local wild_players = #find_player_team('Wild')
        return { vars = { 1 + ((wild_players * center.ability.extra.wild_count) / 10) } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Wild"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "MF", -- Midfielder
    pteam = "Wild",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if G.STAGE == G.STAGES.RUN then
            card.ability.extra.wild_count = 0
            for k, v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, 'm_wild') then
                    card.ability.extra.wild_count = card.ability.extra.wild_count + 1
                end
            end
        end

        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                local wild_players = #find_player_team('Wild')
                card.ability.extra.triggered = true
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { 1 + ((wild_players * card.ability.extra.wild_count) / 10) } },
                    colour = G.C.MULT,
                    Xmult_mod = 1 + ((wild_players * card.ability.extra.wild_count) / 10)
                }
            end
        end
    end,
    ina_credits = {
        idea = {
            "Shadorossa",
        }
    },
}

-- Gorilla
local Gorilla = {
    name = "Gorilla",
    pos = { x = 5, y = 4 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, -- Common
    pools = { ["Wild"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Mountain",
    pposition = "FW", -- Forward
    pteam = "Wild",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_ina_wild_tag'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
        end
    end
}

-- Cheetah
local Cheetah = {
    name = "Cheetah",
    pos = { x = 7, y = 4 },
    config = { extra = { current_element = "Wind", possible_elements = { "Wind", "Fire", "Forest", "Mountain" }, triggered = false } },
    loc_vars = function(self, info_queue, center)
        G.ARGS.LOC_COLOURS["select_element"] = G.ARGS.LOC_COLOURS[string.lower(center.ability.extra.current_element)] or
            HEX("FFFFFF")
        return { vars = { center.ability.extra.current_element } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Wild"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "FW", -- Forward
    pteam = "Wild",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            card.ability.extra.current_element = pseudorandom_element(card.ability.extra.possible_elements,
                pseudoseed("elements"))
            return {
                message = localize("ina_training"),
                colour = G.C.RED,
                card = card,
            }
        end
        if context.repetition and context.cardarea == G.play then
            local wildCount = 0
            for i, c in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(c, 'm_wild') then
                    wildCount = wildCount + 1
                end
            end
            if wildCount == 5 and not context.end_of_round and not context.before and not context.after
                and not context.other_card.debuff then
                local retriggerCount = #find_player_type(card.ability.extra.current_element)
                card.ability.extra.triggered = true
                return {
                    message = localize('k_again_ex'),
                    repetitions = retriggerCount,
                    card = card
                }
            end
        end
    end,
    ina_credits = {
        idea = {
            "Shadorossa",
        }
    },
}

return {
    name = "Wild",
    list = { Boar, Chicken, Chamaleon, Eagle, Monkey, Gorilla, Cheetah },
}
