-- Hades
local Hades = J({
    name = "Hades",
    pos = { x = 7, y = 3 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, center)
        return {}
    end,
    rarity = 1,
    pools = { ["Zeus_Ares"] = true },
    cost = 5,
    atlas = "Jokers07",
    ptype = C.Wind,
    pposition = C.DF,
    techtype = C.UPGRADES.Plus,
    pteam = "ina_team_Zeus_Ares",
    blueprint_compat = false,
    calculate = function(self, card, ctx)
    end
})

-- Perseus
local Perseus = J({
    name = "Percy_Hurst",
    pos = { x = 8, y = 3 },
    config = { extra = { mult_mod = 2, current_mult = 0, loss_countdown = 2, hands_needed_to_lose = 2, loss_percent = 0.3 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.mult_mod, center.ability.extra.loss_countdown, math.floor(center.ability.extra.loss_percent * 100), center.ability.extra.current_mult } }
    end,
    rarity = 3,
    pools = { ["Zeus_Ares"] = true },
    cost = 6,
    atlas = "Jokers07",
    ptype = C.Fire,
    pposition = C.FW,
    techtype = C.UPGRADES.Plus,
    pteam = "ZeusAres",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and context.scoring_hand then
            local hearts = Pokerleven.get_cards_of_suite("Hearts", context.scoring_hand)

            if hearts >= 2 then
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
                card.ability.extra.loss_countdown = card.ability.extra.hands_needed_to_lose
            else
                card.ability.extra.loss_countdown = card.ability.extra.loss_countdown - 1
                if card.ability.extra.loss_countdown <= 0 then
                    card.ability.extra.current_mult = math.floor(card.ability.extra.current_mult * (1 - card.ability.extra.loss_percent))
                    card.ability.extra.loss_countdown = card.ability.extra.hands_needed_to_lose
                end
            end
        end

        if Pokerleven.is_joker_turn(context) and card.ability.extra.current_mult > 0 then
            return {
                message = localize("ina_perseus_skill"),
                colour = G.C.MULT,
                mult_mod = card.ability.extra.current_mult
            }
        end
    end
})

return {
    name = "Zeus_Ares",
    list = { Perseus }
}
