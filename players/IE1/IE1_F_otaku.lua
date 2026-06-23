-- Sam Idol
local Sam_Idol = J({
name = "Sam_Idol",
    pos = { x = 3, y = 6 },
    config = { extra = { odds2 = 2, retrigger_count = 1, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { G.GAME.probabilities.normal, center.ability.extra.odds2 } }
    end,
    rarity = 1, -- Common
    pools = { ["Otaku"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.GK,
    pteam = "ina_team_otaku",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.scoring_hand and context.other_card then
            if context.other_card:get_id() == 4
                and pseudorandom('Idol') < G.GAME.probabilities.normal / card.ability.extra.odds2 then
                card.ability.extra.triggered = true
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.retrigger_count,
                    card = context.other_card
                }
            end
        end
    end,
    ina_credits = {
        idea = { 'LegendaryAd' }
    }
})

-- Marcus Train
local Marcus_Train = J({
    name = "Marcus_Train",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.DF,
    pteam = "ina_team_otaku",
})

-- Light Nobel
local Light_Nobel = J({
    name = "Light_Nobel",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.MF,
    pteam = "ina_team_otaku",
})

-- Walter Valiant
local Walter_Valiant = J({
name = "Walter_Valiant",
    pos = { x = 6, y = 6 },
    config = { extra = { triggered = false } },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, -- Common
    pools = { ["Otaku"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.MF,
    pteam = "ina_team_otaku",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and context.other_card then
            if context.other_card:get_id() == 11 or context.other_card:get_id() == 12 or context.other_card:get_id() == 13 then
                card.ability.extra.triggered = true
                convert_cards_to(context.other_card, { set_rank = "4" }, false, false)
                return {
                    message = localize("ina_convert"),
                    colour = G.C.XMULT,
                    card = context.other_card,
                }
            end
        end
    end,
    ina_credits = {
        idea = { "LegendaryAd" }
    }
})

-- Spencer Gates
local Spencer_Gates = J({
    name = "Spencer_Gates",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_otaku",
})

-- Josh Spear
local Josh_Spear = J({
    name = "Josh_Spear",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.FW,
    pteam = "ina_team_otaku",
})

-- Gaby Farmer
local Gaby_Farmer = J({
name = "Gaby_Farmer",
    pos = { x = 9, y = 6 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 2, -- Common
    pools = { ["Otaku"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.FW,
    pteam = "ina_team_otaku",
    blueprint_compat = true,
    calculate = function(self, card, context)
    end
})

-- Anthony Woodbridge
local Anthony_Woodbridge = J({
name = "Anthony_Woodbridge",
    pos = { x = 10, y = 6 },
    config = { extra = { retrigger_count = 1, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 2, -- Uncommon
    pools = { ["Otaku"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.MF,
    pteam = "ina_team_otaku",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and next(context.poker_hands['Straight']) then
            for pos, joker in ipairs(G.jokers.cards) do
                if is_position(joker, "MF") then
                    if context.other_card == context.scoring_hand[pos]
                        and SMODS.has_enhancement(context.other_card, 'm_lucky') then
                        joker.ability.extra.triggered = true
                        return {
                            message = localize('k_again_ex'),
                            repetitions = card.ability.extra.retrigger_count,
                            card = context.other_card
                        }
                    end
                end
            end
        end
    end
})

-- Gus Gamer
local Gus_Gamer = J({
name = "Gus_Gamer",
    pos = { x = 11, y = 6 },
    config = { extra = { triggered = false } },
    loc_vars = function(self, info_queue, center)
        local otaku_count = #find_player_team("Otaku")
        local fps = love.timer.getFPS()
        if fps > 144 then
            fps = 144
        end
        return { vars = { otaku_count > 1 and fps or fps / 2 } }
    end,
    rarity = 1, -- Uncommon
    pools = { ["Otaku"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.FW,
    pteam = "ina_team_otaku",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand and context.joker_main then
            local fps = love.timer.getFPS()
            local otaku_count = #find_player_team("Otaku")
            card.ability.extra.triggered = true

            if fps > 144 then
                fps = 144
            end
            return {
                message = fps .. " FPS!",
                chip_mod = otaku_count > 1 and fps or fps / 2,
                colour = G.C.DARK_EDITION,
            }
        end
    end
})

-- Mark Gambling
local Mark_Gambling = J({
name = "Mark_Gambling",
    pos = { x = 12, y = 6 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 3, -- Rare
    pools = { ["Otaku"] = true },
    cost = 8,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.FW,
    pteam = "ina_team_otaku",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local hasQueen = false
            local hasKing = false
            for i, c in ipairs(context.scoring_hand) do
                if c:get_id() == 12 then
                    hasQueen = true
                end
                if c:get_id() == 13 then
                    hasKing = true
                end
            end

            if (hasQueen and hasKing) then
                convert_cards_to(context.scoring_hand, { mod_conv = "m_lucky" })
                card.ability.extra.triggered = true
                return {
                    message = localize("ina_convert"),
                    colour = G.C.XMULT,
                }
            end
        end
    end,
    ina_credits = {
        idea = { "Shadorossa" }
    }
})

-- Theodore Master
local Theodore_Master = J({
name = "Theodore_Master",
    pos = { x = 0, y = 7 },
    config = { extra = { new_lucky = 5, minus_dollars = -2, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { G.GAME.probabilities.new_lucky or center.ability.extra.new_lucky, center.ability.extra.minus_dollars } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Otaku"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.FW,
    pteam = "ina_team_otaku",
    techtype = C.UPGRADES.Number,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.get_enhancements(context.other_card)["m_lucky"] == true then
                return {
                    dollars = card.ability.extra.minus_dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.probabilities.new_lucky = (G.GAME.probabilities.new_lucky or 0) + card.ability.extra.new_lucky
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.probabilities.new_lucky = nil
    end,
    ina_credits = {
        idea = { "Shadorossa" }
    }
})

-- Grant Eldorado
local Grant_Eldorado = J({
    name = "Grant_Eldorado",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Fire,
    pposition = C.GK,
    pteam = "ina_team_otaku",
})

-- Ham Signalman
local Ham_Signalman = J({
    name = "Ham_Signalman",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.MF,
    pteam = "ina_team_otaku",
})

-- Bill Formby
local Bill_Formby = J({
    name = "Bill_Formby",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Mountain,
    pposition = C.DF,
    pteam = "ina_team_otaku",
})

-- Mike Vox
local Mike_Vox = J({
name = "Mike_Vox",
    pos = { x = 4, y = 7 },
    config = { extra = { chip_mod = 30, triggered = false } },
    loc_vars = function(self, info_queue, center)
        table.insert(info_queue, { set = 'Other',
})
        return { vars = { center.ability.extra.chip_mod } }
    end,
    rarity = 1, -- Common
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Wind,
    pposition = C.DF,
    pteam = "ina_team_otaku",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if Pokerleven.is_joker_turn(context) and context.joker_main and context.scoring_hand and card:is_rightmost_joker() then
            local count = Pokerleven.get_jokers_to_the_left(card)

            if count > 0 then
                return {
                    message = localize { type = 'variable',
vars = { card.ability.extra.chip_mod * count } },
                    colour = G.C.CHIPS,
                    chip_mod = card.ability.extra.chip_mod * count,
                }
            end
        end
    end,
    ina_credits = {
        idea = { "Lovahi" }
    }
})

-- Ollie Webb
local Ollie_Webb = J({
    name = "Ollie_Webb",
    pos = { x = 0, y = 0 },
    config = {},
    rarity = 1,
    pools = { ["Otaku"] = true },
    cost = 4,
    atlas = "Jokers01",
    ptype = C.Forest,
    pposition = C.DF,
    pteam = "ina_team_otaku",
})

return {
    name = "Otaku",
    list = { Sam_Idol, Walter_Valiant, Gaby_Farmer, Anthony_Woodbridge, Gus_Gamer, Mark_Gambling, Theodore_Master, Mike_Vox }
}
