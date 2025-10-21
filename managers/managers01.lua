-- Nelly
local Nelly = J({
    name = "Nelly",
    pos = { x = 0, y = 0 },
    config = { extra = { min_money = 1, max_money = 5, dead_money = 100, dead_ante = 4 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.min_money, center.ability.extra.max_money, center.ability.extra.dead_ante, center.ability.extra.dead_money } }
    end,
    rarity = 2,
    special = "Manager",
    pools = { ["Manager"] = true },
    cost = 7,
    atlas = "Managers01",
    generate_ui = Pokerleven.generate_info_ui,
    calc_dollar_bonus = function(self, card)
        return math.floor(pseudorandom("nelly", card.ability.extra.min_money, card.ability.extra.max_money + 1))
    end,
    calculate = function(self, card, context)
        if context.game_over then
            Pokerleven.destroy_all_jokers()
            Pokerleven.destroy_manager_with_key('j_ina_Nelly')
            if G.GAME.round_resets.ante >= card.ability.extra.dead_ante then
                return {
                    message = localize('k_saved_ex'),
                    saved = 'ina_saved',
                    dollars = card.ability.extra.dead_money - G.GAME.dollars,
                    colour = G.C.RED,
                }
            end
            return {
                message = localize('k_saved_ex'),
                saved = 'ina_saved',
                colour = G.C.RED,
            }
        end
    end
})

-- Celia
local Celia = J({
    name = "Celia",
    pos = { x = 1, y = 0 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 3,
    special = "Manager",
    pools = { ["Manager"] = true },
    cost = 7,
    atlas = "Managers01",
    calculate = function(self, card, context)
        if context.starting_shop then
            jude = get_joker_with_key("j_ina_Jude")
            if jude then
                return {
                    message = ina_evolve(jude, "j_ina_Jude_Raimon")
                }
            end
        end
        if context.setting_blind then
            if Pokerleven.has_enough_bench_space() then
                local selected_joker = create_random_ina_joker('Celia', nil, G.ina_bench_area, 'Scout', false)
                Pokerleven.add_to_bench(selected_joker)
                Pokerleven.open_bench(true, true)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 2.0,
                    func = (function()
                        Pokerleven.open_bench(true, false)
                        return true
                    end)
                }))
            end
        end
    end,
    ina_credits = {
        idea = { "Killer_Patata" }
    }
})

-- Silvia
local Silvia = J({
    name = "Silvia",
    pos = { x = 2, y = 0 },
    config = { extra = { boosters = 1 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.boosters } }
    end,
    rarity = 2,
    special = "Manager",
    cost = 4,
    atlas = "Managers01",
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(card.ability.extra.boosters)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_booster_limit(-card.ability.extra.boosters)
    end
})

-- Aurelia
local Aurelia = J({
    name = "Aurelia",
    pos = { x = 3, y = 0 },
    config = { extra = { shop_rerolls = 1 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.shop_rerolls } }
    end,
    rarity = 1,
    special = "Manager",
    cost = 4,
    atlas = "Managers01",
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.shop_rerolls)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-card.ability.extra.shop_rerolls)
    end
})

-- Silvia
local Koudera = J({
    name = "Koudera",
    pos = { x = 6, y = 1 },
    config = { extra = { consumables_slots = 2 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.consumables_slots } }
    end,
    rarity = 2,
    special = "Manager",
    cost = 8,
    atlas = "Managers01",
    calculate = function(self, card, context)
        -- TODO Add logic
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.consumables_slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.consumables_slots
    end,
    ina_credits = {
        art = { "KirineMoe" },
        idea = { "Shadorossa" }
    }
})

-- Akihiro
local Akihiro = J({
    name = "Akihiro",
    pos = { x = 3, y = 5 },
    soul_pos = { x = 4, y = 5 },
    config = { extra = { antes_remaining = 14 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.consumables_slots } }
    end,
    rarity = 4,
    special = "Manager",
    cost = 8,
    atlas = "Managers01",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and
            card.ability.extra.antes_remaining > 0 then
            card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize("ina_akihiro"), colour = G.C.DARK_EDITION })
            play_sound('gong', 0.76, 1.6)
            ease_ante(-1)
            card.ability.extra.antes_remaining = card.ability.extra.antes_remaining - 1
        end
    end,
    ina_credits = {
        idea = { "Turiño" },
    },
})

-- Chester
local Chester = J({
    name = "Chester",
    pos = { x = 0, y = 4 },
    config = { extra = { scry_ammount = 2 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.scry_ammount } }
    end,
    rarity = 1,
    special = "Manager",
    cost = 6,
    atlas = "Managers01",
    add_to_deck = function(self, card, from_debuff)
        G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry_ammount
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.scry_amount = (G.GAME.scry_amount or 0) - card.ability.extra.scry_ammount
    end
})

return {
    name = "Managers",
    list = { Nelly, Celia, Silvia, Koudera, Aurelia, Chester, Akihiro }
}
