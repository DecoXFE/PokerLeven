-- John Neville
local John_Neville = J({
name = "John_Neville",
    pos = { x = 2, y = 11 },
    config = { extra = { new_glass_denom = 6 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { G.GAME.probabilities.normal, G.GAME.probabilities.new_glass_denom or center.ability.extra.new_glass_denom } }
    end,
    rarity = 1, -- Common
    pools = { ["Kirkwood"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.GK,
    pteam = "ina_team_kirkwood",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.probabilities.new_glass_denom = card.ability.extra.new_glass_denom
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.probabilities.new_glass_denom = nil
    end,
})

-- Malcolm Night
local Malcolm_Night = J({
name = "Malcolm_Night",
    pos = { x = 3, y = 11 },
    config = {},
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 3, -- Rare
    pools = { ["Kirkwood"] = true },
    cost = 8,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.DF,
    pteam = "ina_team_kirkwood",
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

-- Alfred Meenan
local Alfred_Meenan = J({
    name = "Alfred_Meenan",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.DF,
    pteam = "ina_team_kirkwood",
})

-- Dan Mirthful
local Dan_Mirthful = J({
    name = "Dan_Mirthful",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.DF,
    pteam = "ina_team_kirkwood",
})

-- Ricky Clover
local Ricky_Clover = J({
    name = "Ricky_Clover",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_kirkwood",
})

-- Toby Damian
local Toby_Damian = J({
name = "Toby_Damian",
    pos = { x = 7, y = 11 },
    config = { extra = { chips_mod = 7, current_chips = 0, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chips_mod, center.ability.extra.current_chips } }
    end,
    rarity = 1, -- Common
    pools = { ["Kirkwood"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.MF,
    pteam = "ina_team_kirkwood",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.ending_shop then
            card.ability.extra.triggered = true
            local count = #find_player_type(C.Fire)

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
                    message = localize { type = 'variable',
vars = { card.ability.extra.current_chips } },
                    colour = G.C.CHIPS,
                    chip_mod = card.ability.extra.current_chips
                }
            end
        end
    end,
})

-- York Nashmith
local York_Nashmith = J({
name = "York_Nashmith",
    pos = { x = 8, y = 11 },
    config = { extra = { chip_mod = 15 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.chip_mod } }
    end,
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.MF,
    pteam = "ina_team_kirkwood",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card then
            if context.other_card:is_suit("Spades") then
                local forest_count = #find_player_type(C.Forest) or 0
                local extra_chips = card.ability.extra.chip_mod * forest_count

                if extra_chips > 0 then
                    return {
                        message = localize {
                            type = 'variable',
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

-- Zachary Moore
local Zachary_Moore = J({
    name = "Zachary_Moore",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.MF,
    pteam = "ina_team_kirkwood",
})

-- Marvin Murdock
local Marvin_Murdock = J({
name = "Marvin_Murdock",
    pos = { x = 10, y = 11 },
    config = { extra = { mult_mod_low = 4 } },
    loc_vars = function(self, info_queue, center)
        local mult_mod = center.ability.extra.mult_mod_low
        table.insert(info_queue, { set = "Other",
})
        return { vars = { mult_mod } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Kirkwood"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.FW,
    pteam = "ina_team_kirkwood",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local scoring_card = Pokerleven.card_scoring(context)
        if context.individual and scoring_card and scoring_card:is_uneven() then
            local mult_mod = card.ability.extra.mult_mod_low
            return {
                mult = mult_mod,
                card = card
            }
        end
    end,
})

local has_all_brothers = function()
    return next(find_joker("Marvin_Murdock")) and next(find_joker("Thomas_Murdock")) and next(find_joker("Tyler_Murdock"))
end

-- Thomas Murdock
local Thomas_Murdock = J({
name = "Thomas_Murdock",
    pos = { x = 11, y = 11 },
    config = { extra = { chips_mod = 15, retrigger_count = 1 } },
    loc_vars = function(self, info_queue, center)
        local chips_mod = center.ability.extra.chips_mod
        table.insert(info_queue, { set = "Other",
})
        return { vars = { chips_mod } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Kirkwood"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.FW,
    pteam = "ina_team_kirkwood",
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

-- Tyler Murdock
local Tyler_Murdock = J({
name = "Tyler_Murdock",
    pos = { x = 12, y = 11 },
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, center)
        table.insert(info_queue, { set = "Other",
})
        return { vars = { G.GAME.probabilities.normal or 1, center.ability.extra.odds } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Kirkwood"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.FW,
    pteam = "ina_team_kirkwood",
    blueprint_compat = true,
    calculate = function(self, card, context)
        local scoring_card = Pokerleven.card_scoring(context)
        if context.individual and scoring_card
            and scoring_card:is_uneven()
            and card:odds_triggered('Tyler_Murdock') then
            if Pokerleven.has_enough_consumables_space() then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

                return card:create_consumable_as_joker('Tarot')
            end
        end
    end
})

-- Simon Calier
local Simon_Calier = J({
    name = "Simon_Calier",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.GK,
    pteam = "ina_team_kirkwood",
})

-- Brody Gloom
local Brody_Gloom = J({
    name = "Brody_Gloom",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.MF,
    pteam = "ina_team_kirkwood",
})

-- Victor Talis
local Victor_Talis = J({
    name = "Victor_Talis",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.MF,
    pteam = "ina_team_kirkwood",
})

-- Eren Middleton
local Eren_Middleton = J({
    name = "Eren_Middleton",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_kirkwood",
})

-- Peter Wells
local Peter_Wells = J({
    name = "Peter_Wells",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Kirkwood"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.DF,
    pteam = "ina_team_kirkwood",
})

return {
    name = "Kirkwood",
    list = { John_Neville, Malcolm_Night, Toby_Damian, York_Nashmith, Marvin_Murdock, Thomas_Murdock, Tyler_Murdock }
}
