-- Otaku
local Idol = {
    name = "Idol",
    pos = { x = 3, y = 6 },
    config = { extra = { odds = 2, retrigger_count = 1, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { G.GAME.probabilities.normal, center.ability.extra.odds } }
    end,
    rarity = 1, -- Common
    pools = { ["Otaku"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Mountain",
    pposition = "GK",
    pteam = "Otaku",
    techtype = C.UPGRADES.Plus,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.repetition and context.scoring_hand and context.other_card then
            if context.other_card:get_id() == 4
                and pseudorandom('Idol') < G.GAME.probabilities.normal / card.ability.extra.odds then
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
}

local Hero = {
    name = "Hero",
    pos = { x = 6, y = 6 },
    config = { extra = { triggered = false } },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1, -- Common
    pools = { ["Otaku"] = true },
    cost = 5,
    atlas = "Jokers01",
    ptype = "Fire",
    pposition = "DF",
    pteam = "Otaku",
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
}

local Custom = {
    name = "Custom",
    pos = { x = 9, y = 6 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 2, -- Common
    pools = { ["Otaku"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "FW",
    pteam = "Otaku",
    blueprint_compat = true,
    calculate = function(self, card, context)
    end
}

local Robot = {
    name = "Robot",
    pos = { x = 10, y = 6 },
    config = { extra = { retrigger_count = 1, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 2, -- Uncommon
    pools = { ["Otaku"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "MF",
    pteam = "Otaku",
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
}

local Gamer = {
    name = "Gamer",
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
    ptype = "Fire",
    pposition = "FW",
    pteam = "Otaku",
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
}

local Artist = {
    name = "Artist",
    pos = { x = 12, y = 6 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 3, -- Rare
    pools = { ["Otaku"] = true },
    cost = 8,
    atlas = "Jokers01",
    ptype = "Wind",
    pposition = "FW",
    pteam = "Otaku",
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
}

local Arcade = {
    name = "Arcade",
    pos = { x = 0, y = 7 },
    config = { extra = { new_lucky = 5, minus_dollars = -5, triggered = false } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.new_lucky, center.ability.extra.minus_dollars } }
    end,
    rarity = 2, -- Uncommon
    pools = { ["Otaku"] = true },
    cost = 7,
    atlas = "Jokers01",
    ptype = "Forest",
    pposition = "FW",
    pteam = "Otaku",
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
        G.GAME.probabilities.new_lucky = card.ability.extra.new_lucky
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.probabilities.new_lucky = nil
    end,
    ina_credits = {
        idea = { "Shadorossa" }
    }
}

return {
    name = "Otaku",
    list = { Idol, Hero, Custom, Robot, Gamer, Artist, Arcade }
}
