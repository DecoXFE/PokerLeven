-- Dulce
---@param card Card
local select_random_cards_for_harvest = function(card)
    local count = #Pokerleven.find_player_type_and_position("Wind", "MF")

    if count > 0 and G.deck and G.deck.cards and #G.deck.cards > 0 then
        table.unpack = table.unpack or unpack
        local candidates = { table.unpack(G.deck.cards) }

        for i = 1, count do
            if #candidates == 0 then break end

            local target = pseudorandom_element(candidates, pseudoseed("dulce_harvest_" .. i))
            if target then
                target:set_as_harvestable()

                for j, c in ipairs(candidates) do
                    if c == target then
                        table.remove(candidates, j)
                        break
                    end
                end
            end
        end
    end
end

local Dulce = J({
    name = "Dulce",
    pos = { x = 10, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 3,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = "Wind",
    pposition = "DF",
    pteam = "Scout",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.blind_defeated and not context.blueprint then
            return select_random_cards_for_harvest(card)
        end
    end,
})

-- Ryoma
local Ryoma = J({
    name = "Ryoma",
    pos = { x = 9, y = 0 },
    config = { extra = { current_mult = 0, mult_mod = 2 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult_mod, center.ability.extra.current_mult } }
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = "Mountain",
    pposition = "GK",
    pteam = "Scout",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.post_trigger and
            context.other_card ~= card and
            context.other_card.ability.extra.pposition == C.GK then
            card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
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
        if Pokerleven.is_joker_turn(context) then
            return {
                mult = card.ability.extra.current_mult
            }
        end
    end
})

-- Blazer
local Blazer = J({
    name = "Blazer",
    pos = { x = 1, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = C.Fire,
    pposition = C.GK,
    pteam = "Scout",
    blueprint_compat = true,
    allow_element_application = true,
    calculate = function(self, card, context)
        for _, player in pairs(G.jokers.cards) do
            if player.config.center_key == 'j_ina_Weathervane' or
                player.config.center_key == 'j_ina_Blazer' or
                player.config.center_key == 'j_ina_Montayne' or
                player.config.center_key == 'j_ina_Noggin' then
                leftmost = player
                break
            end
        end

        if leftmost == card then
            apply_element("Fire", "ina_onfire", G.ARGS.LOC_COLOURS['fire'])
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        restore_types_for_area()
    end
})

-- Weathervane
local Weathervane = J({
    name = "Weathervane",
    pos = { x = 2, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = "Wind",
    pposition = "DF",
    pteam = "Scout",
    blueprint_compat = true,
    allow_element_application = true,
    calculate = function(self, card, context)
        for _, player in pairs(G.jokers.cards) do
            if player.config.center_key == 'j_ina_Blazer' or
                player.config.center_key == 'j_ina_Montayne' or
                player.config.center_key == 'j_ina_Weathervane' or
                player.config.center_key == 'j_ina_Noggin' then
                leftmost = player
                break
            end
        end

        if leftmost == card then
            apply_element("Wind", "ina_onwind", G.ARGS.LOC_COLOURS['wind'])
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        restore_types_for_area()
    end
})

-- Noggin
local Noggin = J({
    name = "Noggin",
    pos = { x = 3, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = "Forest",
    pposition = "MF",
    pteam = "Scout",
    blueprint_compat = true,
    allow_element_application = true,
    calculate = function(self, card, context)
        for _, player in pairs(G.jokers.cards) do
            if player.config.center_key == 'j_ina_Weathervane' or
                player.config.center_key == 'j_ina_Noggin' or
                player.config.center_key == 'j_ina_Montayne' or
                player.config.center_key == 'j_ina_Blazer' then
                leftmost = player
                break
            end
        end

        if leftmost == card then
            apply_element("Forest", "ina_onforest", G.ARGS.LOC_COLOURS['forest'])
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        restore_types_for_area()
    end
})

-- Montayne
local Montayne = J({
    name = "Montayne",
    pos = { x = 6, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = "Mountain",
    pposition = "FW",
    pteam = "Scout",
    blueprint_compat = true,
    allow_element_application = true,
    calculate = function(self, card, context)
        for _, player in pairs(G.jokers.cards) do
            if player.config.center_key == 'j_ina_Weathervane' or
                player.config.center_key == 'j_ina_Montayne' or
                player.config.center_key == 'j_ina_Noggin' or
                player.config.center_key == 'j_ina_Blazer' then
                leftmost = player
                break
            end
        end

        if leftmost == card then
            apply_element("Mountain", "ina_onmountain", G.ARGS.LOC_COLOURS['mountain'])
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        restore_types_for_area()
    end
})

-- Chester
local Chester = J({
    name = "Chester",
    pos = { x = 4, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = "Forest",
    pposition = "MF",
    pteam = "Scout",
    blueprint_compat = true,
    calculate = function(self, card, context)
        -- TODO Add logic
    end
})

-- Mach
local Mach = J({
    name = "Mach",
    pos = { x = 7, y = 0 },
    config = { extra = { current_xmult = 1, xmult_mod = 0.25 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.xmult_mod, center.ability.extra.current_xmult } }
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = "Wind",
    pposition = "FW",
    pteam = "Scout",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.selling_card and
            context.card.ability.set == "Joker" then
            card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.xmult_mod
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

        if Pokerleven.is_joker_turn(context) then
            return {
                Xmult = card.ability.extra.current_xmult
            }
        end
    end
})

-- Miles
local Miles = {
    name = "Miles",
    pos = { x = 8, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = "Wind",
    pposition = "DF",
    pteam = "Scout",
    blueprint_compat = true,
    calculate = function(self, card, context)
        -- TODO Add logic
    end
}

-- Winters
local Winters = {
    name = "Winters",
    pos = { x = 5, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = C.Forest,
    pposition = C.FW,
    pteam = "Scout",
    blueprint_compat = true,
    calculate = function(self, card, context)

    end
}

-- Ace Server
local Ace_Server = J({
    name = "Ace_Server",
    pos = { x = 0, y = 0 },
    config = { extra = { odds = 5, hand_level_up = 1, ammount_needed = 2, rank_played = 14, } },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.odds, center.ability.extra.hand_level_up, center.ability.extra.ammount_needed, center.ability.extra.rank_played }
        }
    end,
    rarity = 2,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = C.Wind,
    pposition = C.GK,
    pteam = "Scout",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if Pokerleven.after_scoring_phase(context) and
            card:odds_triggered('AceServer') and
            Pokerleven.has_enough_cards_of_rank(context.scoring_hand, card.ability.extra.rank_played, card.ability.extra.ammount_needed) then
            return Pokerleven.level_up_hand(card.ability.extra.hand_level_up)
        end
    end,
    ina_credits = {
        idea = { "Shadorossa" },
    }
})

-- Holly Cricket
local Holly_Cricket = {
    name = "Holly_Cricket",
    pos = { x = 12, y = 0 },
    config = { extra = { consumable_slots = 1 } },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.consumable_slots }
        }
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = C.Fire,
    pposition = C.MF,
    pteam = "Scout",
    blueprint_compat = true,
    add_to_deck = function(self, card)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumable_slots
        card_eval_status_text(card, 'extra', nil, nil, nil, {
            message = "¡Consumibles ampliados!",
            colour = G.C.GREEN
        })
    end,
    remove_from_deck = function(self, card)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumable_slots
    end,
    ina_credits = {
        idea = { "Shadorossa" },
    }
}

-- Rex George
local Rex_George = J({
    name = "Rex_George",
    pos = { x = 0, y = 1 },
    config = { extra = { needed_rank = 2, converted_rank = 9 } },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                tostring(center.ability.extra.needed_rank),
                tostring(center.ability.extra.converted_rank)
            }
        }
    end,
    rarity = 1,
    pools = { ["Scout"] = true },
    cost = 5,
    atlas = "Jokers10",
    ptype = C.Forest,
    pposition = C.GK,
    pteam = "Scout",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == card.ability.extra.needed_rank then
            convert_cards_to(context.other_card, { set_rank = tostring(card.ability.extra.converted_rank) })
            return {
                message = localize("ina_convert"),
                colour = G.C.XMULT,
            }
        end
    end,
    ina_credits = {
        idea = { "Shadorossa" },
    }
})


return {
    name = "Scout",
    list = { Blazer, Weathervane, Noggin, Montayne, Ace_Server, Rex_George, Holly_Cricket, Dulce, Ryoma, Mach },
}
