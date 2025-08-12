local Neville = J({
    name = "Neville",
    pos = { x = 2, y = 11 },
    config = { extra = { new_glass_denom = 6 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { G.GAME.probabilities.normal, G.GAME.probabilities.new_glass_denom or center.ability.extra.new_glass_denom } }
    end,
    rarity = 1, -- Common
    pools = { ["Kirkwood"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "GK",
    pteam = "Kirkwood",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.probabilities.new_glass_denom = card.ability.extra.new_glass_denom
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.probabilities.new_glass_denom = nil
    end,
})

local Night = J({
    name = "Night",
    pos = { x = 3, y = 11 },
    config = {},
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 3, -- Rare
    pools = { ["Kirkwood"] = true },
    cost = 8,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "DF",
    pteam = "Kirkwood",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local spawn_effect = spawn_random_ina_joker(card, context,
                {
                    ["Common"] = 0.6,
                    ["Uncommon"] = 0.4
                },
                {
                    ["Kirkwood"] = 1,
                }
            )
            spawn_effect.func()
        end
    end,
})

local Marvin = J({
    name = "Marvin",
    pos = { x = 10, y = 11 },
    config = { extra = { mult_mod = 4 } },
    loc_vars = function(self, info_queue, center)
        local mult_mod = center.ability.extra.mult_mod
        table.insert(info_queue, { set = "Other", key = "Trillizos" })
        return { vars = { mult_mod } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Kirkwood"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "FW",
    pteam = "Kirkwood",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local scoring_card = Pokerleven.card_scoring(context)
        if context.individual and scoring_card and scoring_card:is_uneven() then
            local mult_mod = card.ability.extra.mult_mod
            return {
                mult = mult_mod,
                card = card
            }
        end
    end,
})

local has_all_brothers = function()
    return next(find_joker("Marvin")) and next(find_joker("Thomas")) and next(find_joker("Tyler"))
end

local Thomas = J({
    name = "Thomas",
    pos = { x = 11, y = 11 },
    config = { extra = { chips_mod = 15, retrigger_count = 1 } },
    loc_vars = function(self, info_queue, center)
        local chips_mod = center.ability.extra.chips_mod
        table.insert(info_queue, { set = "Other", key = "Trillizos" })
        return { vars = { chips_mod } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Kirkwood"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "FW",
    pteam = "Kirkwood",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local scoring_card = Pokerleven.card_scoring(context)
        if context.repetition and context.cardarea == G.play and
            has_all_brothers() and
            scoring_card and scoring_card:is_uneven() then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.retrigger_count,
                card = scoring_card
            }
        end

        if context.individual and scoring_card and scoring_card:is_uneven() then
            local chips_mod = card.ability.extra.chips_mod
            return {
                chips = chips_mod,
                card = card
            }
        end
    end,
})

local Tyler = J({
    name = "Tyler",
    pos = { x = 12, y = 11 },
    config = { extra = { odds = 8 } },
    loc_vars = function(self, info_queue, center)
        table.insert(info_queue, { set = "Other", key = "Trillizos" })
        return { vars = { G.GAME.probabilities.normal or 1, center.ability.extra.odds } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Kirkwood"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Mountain",
    pposition = "FW",
    pteam = "Kirkwood",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local scoring_card = Pokerleven.card_scoring(context)
        if context.individual and scoring_card
            and Pokerleven.has_enough_consumables_space()
            and scoring_card:is_uneven()
            and card:odds_triggered('Tyler') then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

            card:show_text('k_plus_tarot')

            local add_card_func = function()
                local tarot_card = create_card("Tarot", G.consumeables, nil, nil, nil, nil)
                Pokerleven.add_card_to_consumables(tarot_card)
            end

            Pokerleven.execute_function_with_delay(add_card_func, 0.1)
            return {}
        end
    end
})

local Damian = J({
    name = "Damian",
    pos = { x = 7, y = 11 },
    config = { extra = { chips_mod = 7, current_chips = 0, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chips_mod, center.ability.extra.current_chips } }
    end,
    rarity = 1, -- Common
    pools = { ["Kirkwood"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "MF",
    pteam = "Kirkwood",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.ending_shop then
            card.ability.extra.triggered = true
            local count = #find_player_type("Fire")

            if count > 0 then
                card.ability.extra.current_chips = card.ability.extra.current_chips +
                    card.ability.extra.chips_mod * count
            end
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS,
            }
        end

        if context.scoring_hand and context.cardarea == G.jokers and context.joker_main then
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

local Nashmith = J({
    name = "Nashmith",
    pos = { x = 8, y = 11 },
    config = { extra = { chip_mod = 10 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chip_mod } }
    end,
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Forest",
    pposition = "MF",
    pteam = "Kirkwood",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card:is_suit("Spades") then
                local forest_count = #find_player_type("Forest") or 0
                local extra_chips = card.ability.extra.chip_mod * forest_count

                if extra_chips > 0 then
                    return {
                        message = localize {
                            type = 'variable',
                            key = 'a_chips',
                            vars = { extra_chips }
                        },
                        chip_mod = extra_chips,
                        colour = G.C.CHIPS,
                    }
                end
            end
        end
    end,
})

--[[ local z_triangle = J({
    name = "Z_Triangle",
    pos = { x = 11, y = 6 },
    config = {},
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, -- Common
    pools = { ["Kirkwood"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "FW",
    pteam = "Kirkwood",
    blueprint_compat = true,
    calculate = function(self, card, context)
        -- Add logic
    end,
    unlocked = false,
    special = "Technique"
}) ]]

return {
    name = "Kirkwood",
    list = { Neville, Night, Damian, Nashmith, Marvin, Thomas, Tyler }
}
