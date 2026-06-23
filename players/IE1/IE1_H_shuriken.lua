-- Morgan Sanders
local Morgan_Sanders = J({
name = "Morgan_Sanders",
    pos = { x = 9, y = 8 },
    config = {
        extra = {
            xmult_mod = 0.6,
            triggered = false,
            pposition = C.GK
        }
    },
    loc_vars = function(self, info_queue, center)
        local count = #find_player_position("GK")
        return { vars = { center.ability.extra.xmult_mod, count * (center.ability.extra.xmult_mod or 0) + 1 } }
    end,
    rarity = 2,
    pools = { ["Shuriken"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.GK,
    pteam = "ina_team_shuriken",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
            local count = #find_player_position("GK")
            local total_xmult = count * card.ability.extra.xmult_mod + 1
            card.ability.extra.triggered = true
            return {
                message = localize { type = 'variable',
vars = { total_xmult } },
                colour = G.C.XMULT,
                Xmult_mod = total_xmult
            }
        end
    end,
})

-- Newton Flust
local Newton_Flust = J({
    name = "Newton_Flust",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_shuriken",
})

-- Jim Hillfort
local Jim_Hillfort = J({
name = "Jim_Hillfort",
    pos = { x = 11, y = 8 },
    config = { extra = { triggered = false, chips_mod = 1, current_chips = 0, dollars_needed = 1 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chips_mod, center.ability.extra.dollars_needed, center.ability.extra.current_chips } }
    end,
    rarity = 1, -- Common
    pools = { ["Shuriken"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.DF,
    pteam = "ina_team_shuriken",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind then
            local wind_players = find_player_type(C.Wind)
            if #wind_players > 0 then
                local chips_mod = card.ability.extra.chips_mod * Pokerleven.calculate_total_sell_cost(wind_players)
                card.ability.extra.current_chips = card.ability.extra.current_chips + chips_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            end
        end
        if Pokerleven.is_joker_turn(context) and
            card.ability.extra.current_chips > 0 then
            return {
                chips = card.ability.extra.current_chips
            }
        end
    end,
})

-- Galen Thunderbird
local Galen_Thunderbird = J({
    name = "Galen_Thunderbird",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_shuriken",
})

-- Finn Stoned
local Finn_Stoned = J({
    name = "Finn_Stoned",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.DF,
    pteam = "ina_team_shuriken",
})

-- Phil Wingate
local Phil_Wingate = J({
name = "Phil_Wingate",
    pos = { x = 1, y = 9 },
    config = { extra = { { triggered = false } } },
    rarity = 2, -- Uncommon
    pools = { ["Shuriken"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.MF,
    pteam = "ina_team_shuriken",
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

-- Jez Shell
local Jez_Shell = J({
name = "Jez_Shell",
    pos = { x = 2, y = 9 },
    config = { extra = { mult_mod_low = 1, money = 1, suit = "Diamonds", triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.money, center.ability.extra.mult_mod_low } }
    end,
    rarity = 1, -- Common
    pools = { ["Shuriken"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.MF,
    pteam = "ina_team_shuriken",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            if context.scoring_hand then
                card.ability.extra.triggered = true
                return {
                    message = localize("ina_dribbling"),
                    colour = G.C.DARK_EDITION,
                    mult_mod = card.ability.extra.mult_mod_low,
                    dollars = card.ability.extra.money,
                    card = card
                }
            end
        end
    end,
})

-- Jupiter Jumper
local Jupiter_Jumper = J({
name = "Jupiter_Jumper",
    pos = { x = 3, y = 9 },
    config = {},
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, -- Common
    pools = { ["Shuriken"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.MF,
    pteam = "ina_team_shuriken",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind then
            local right_joker = get_right_joker(card)
            if right_joker then
                local selected_joker =
                    get_random_joker_key("Jupiter_Jumper", right_joker.config.center.rarity, nil, nil, nil, false)
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

-- Sam Samurai
local Sam_Samurai = J({
    name = "Sam_Samurai",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.FW,
    pteam = "ina_team_shuriken",
})

-- Hank Sullivan
local Hank_Sullivan = J({
name = "Hank_Sullivan",
    pos = { x = 5, y = 9 },
    config = { extra = { copies_number = 2 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.copies_number } }
    end,
    rarity = 2,
    pools = { ["Shuriken"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.MF,
    pteam = "ina_team_shuriken",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.GAME.joker_buffer = 0

                    for _ = 1, card.ability.extra.copies_number do
                        local create_args = {
                            set = 'Joker',
edition = 'e_negative'
                        }
                        local _card = SMODS.create_card(create_args)
                        _card:add_to_deck()
                        _card.can_sell_card = function(self, context)
                            return false
                        end

                        _card.calculate_joker = function(self, context)
                            if context.end_of_round and context.main_eval then
                                self:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                                self:remove_from_deck()
                            end
                        end
                        _card.can_calculate = function()
                            return true
                        end

                        G.jokers:emplace(_card)
                    end
                    return true
                end
            }))
        end
    end,
    ina_credits = {
        idea = { "LegendaryAd" },
    }
})

-- Sail Bluesea
local function can_duplicate_joker(card, context)
    return card:is_leftmost_joker()
        and context.setting_blind
        and #G.jokers.cards > 1
end

local function generate_cloack_card(perish_tally, tech_level)
    local joker_index = pseudorandom("Sail_Bluesea", 2, #G.jokers.cards)
    local new_joker = copy_card(G.jokers.cards[joker_index])
    if tech_level ~= 5 then
        new_joker.ability.perishable = true
        new_joker.ability.perish_tally = perish_tally
    end
    new_joker:set_edition('e_negative')
    return new_joker
end

local Sail_Bluesea = J({
name = "Sail_Bluesea",
    pos = { x = 6, y = 9 },
    atlas = "Jokers01",
    rarity = 3,
    cost = 8,
    ptype = C.Fire,
    pposition = C.FW,
    pteam = "ina_team_shuriken",
    pools = { ["Shuriken"] = true },
    blueprint_compat = true,
    config = {
        extra = {
            barriers = 5,
            perish_tally = 1
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = { set = 'Other',
}
        return {
            key = (center.ability.extra.tech_level or 0) < 5 and 'j_ina_Sail_Bluesea' or 'j_ina_Sail_Bluesea_inf',
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
    ina_credits = {
        idea = { "Shadorossa" },
    }
})

-- Kevin Castle
local Kevin_Castle = J({
    name = "Kevin_Castle",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.GK,
    pteam = "ina_team_shuriken",
})

-- John Reynolds
local John_Reynolds = J({
    name = "John_Reynolds",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.FW,
    pteam = "ina_team_shuriken",
})

-- Dan Hopper
local Dan_Hopper = J({
    name = "Dan_Hopper",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_shuriken",
})

-- Cal Trops
local Cal_Trops = J({
    name = "Cal_Trops",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.MF,
    pteam = "ina_team_shuriken",
})

-- Winston Falls
local Winston_Falls = J({
    name = "Winston_Falls",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Shuriken"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.MF,
    pteam = "ina_team_shuriken",
})

return {
    name = "Shuriken",
    list = { Morgan_Sanders, Jim_Hillfort, Phil_Wingate, Jez_Shell, Jupiter_Jumper, Hank_Sullivan, Sail_Bluesea },
}
