local hood = J({
    name = "Hood",
    pos = { x = 9, y = 8 },
    config = {
        extra = {
            xmult_per_gk = 0.5,
            triggered = false,
            pposition = "GK"
        }
    },
    loc_vars = function(self, info_queue, center)
        local count = #find_player_position("GK")
        return { vars = { center.ability.extra.xmult_per_gk, count * (center.ability.extra.xmult_per_gk or 0) + 1 } }
    end,
    rarity = 2,
    pools = { ["Shuriken"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Forest",
    pteam = "Shuriken",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
            local count = #find_player_position("GK")
            local total_xmult = count * card.ability.extra.xmult_per_gk + 1
            card.ability.extra.triggered = true
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { total_xmult } },
                colour = G.C.XMULT,
                Xmult_mod = total_xmult
            }
        end
    end,
})

local hillfort = J({
    name = "Hillfort",
    pos = { x = 11, y = 8 },
    config = { extra = { triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { calculate_avg_sell_cost("Wind") or 0 } }
    end,
    rarity = 1, -- Common
    pools = { ["Shuriken"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "DF",
    pteam = "Shuriken",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand then
            card.ability.extra.triggered = true
            return {
                chips = calculate_avg_sell_cost("Wind") or 0
            }
        end
    end,
})

local code = J({
    name = "Code",
    pos = { x = 1, y = 9 },
    config = { extra = { { triggered = false } } },
    rarity = 2, -- Uncommon
    pools = { ["Shuriken"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Mountain",
    pposition = "MF",
    pteam = "Shuriken",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand
            and context.other_card
            and SMODS.has_enhancement(context.other_card, 'm_gold') then
            card.ability.extra.triggered = true
            local count = #find_player_team("Shuriken")
            return {
                message = localize('k_again_ex'),
                repetitions = count,
                card = card
            }
        end
    end,
})

local star = J({
    name = "Star",
    pos = { x = 2, y = 9 },
    config = { extra = { mult_mod = 1, money = 1, suit = "Diamonds", triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.money, center.ability.extra.mult_mod } }
    end,
    rarity = 1, -- Common
    pools = { ["Shuriken"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "MF",
    pteam = "Shuriken",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            if context.scoring_hand then
                card.ability.extra.triggered = true
                return {
                    message = localize("ina_dribbling"),
                    colour = G.C.DARK_EDITION,
                    mult_mod = card.ability.extra.mult_mod,
                    dollars = card.ability.extra.money,
                    card = card
                }
            end
        end
    end,
})

local cleats = J({
    name = "Cleats",
    pos = { x = 3, y = 9 },
    config = {},
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, -- Common
    pools = { ["Shuriken"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "MF",
    pteam = "Shuriken",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind then
            local right_joker = get_right_joker(card)
            if right_joker then
                local selected_joker =
                    get_random_joker_key("Cleats", right_joker.config.center.rarity, nil, nil, nil)
                return {
                    message = ina_evolve(right_joker, selected_joker)
                }
            end
        end
    end,
    ina_credits = {
        idea = { 'LegendaryAd' }
    }
})

local hattori = J({
    name = "Hattori",
    pos = { x = 5, y = 9 },
    config = { extra = { copies = {}, copies_number = 2, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.copies_number } }
    end,
    rarity = 2,
    pools = { ["Shuriken"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Forest",
    pposition = "MF",
    pteam = "Shuriken",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.GAME.joker_buffer = 0
                    card.ability.extra.copies = card.ability.extra.copies or {}

                    for _ = 1, card.ability.extra.copies_number do
                        local create_args = {
                            set = 'Joker',
                            key = 'j_ina_Hattori',
                            edition = 'e_negative'
                        }
                        local _card = SMODS.create_card(create_args)
                        _card:add_to_deck()
                        _card.can_sell_card = function(self, context)
                            return false
                        end

                        _card.calculate_joker = function(self, context)
                            if context.end_of_round then
                                self:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                                self:remove_from_deck()
                            end
                        end

                        G.jokers:emplace(_card)
                        table.insert(card.ability.extra.copies, _card)
                    end

                    card.ability.extra.triggered = true
                    return true
                end
            }))
        end
    end,
})

--- Cloack
local function can_duplicate_joker(card, context)
    return card:is_leftmost_joker()
        and context.setting_blind
        and #G.jokers.cards > 1
end

local function generate_cloack_card(perish_tally, tech_level)
    local joker_index = pseudorandom("Cloack", 2, #G.jokers.cards)
    local new_joker = copy_card(G.jokers.cards[joker_index])
    if tech_level ~= 5 then
        new_joker.ability.perishable = true
        new_joker.ability.perish_tally = perish_tally
    end
    new_joker:set_edition('e_negative')
    return new_joker
end

local cloack = J({
    name = "Cloack",
    pos = { x = 6, y = 9 },
    atlas = "Jokers01",
    rarity = 3,
    cost = 8,
    ptype = "Fire",
    pposition = "FW",
    pteam = "Shuriken",
    pools = { ["Shuriken"] = true },
    blueprint_compat = true,
    config = {
        extra = {
            barriers = 5,
            perish_tally = 1
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = 'Other', key = 'Frontal' }
        return {
            key = (center.ability.extra.tech_level or 0) < 5 and 'j_ina_Cloack' or 'j_ina_Cloack_inf',
            vars = { center.ability.extra.barriers, center.ability.extra.perish_tally }
        }
    end,
    calculate = function(self, card, context)
        if card:has_enough_barriers() and can_duplicate_joker(card, context) then
            local new_joker = generate_cloack_card(
                card.ability.extra.perish_tally, card.ability.extra.tech_level or 0)
            Pokerleven.add_card_to_jokers(new_joker)
            Pokerleven.ease_barriers(-card.ability.extra.barriers)
        end
    end,
})

return {
    name = "Shuriken",
    list = { hood, hillfort, code, star, cleats, hattori, cloack },
}
