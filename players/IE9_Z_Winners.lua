-- Versión 1

-- Turiño
local Turi = {
    name = "Turi",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = { extra = { xmult_mod = 0.02, triggered = false, requiered_cards = 3, current_tarot_used = 0 } },
    loc_vars = function(self, info_queue, center)
        local tarot_count = (G.GAME.used_star_cards or 0) + (G.GAME.used_moon_cards or 0) +
            (G.GAME.used_world_cards or 0) + (G.GAME.used_sun_cards or 0)
        local tarot_units = math.floor(tarot_count / center.ability.extra.requiered_cards)
        local bonus = tarot_units > 0 and center.ability.extra.xmult_mod * (2 ^ (tarot_units - 1)) or 0
        return { vars = { 1 + bonus, center.ability.extra.xmult_mod, center.ability.extra.requiered_cards, center.ability.extra.current_tarot_used + tarot_count } }
    end,
    rarity = "ina_winner",
    pools = { ["Scout"] = true },
    cost = 20,
    atlas = "tournaments",
    ptype = C.Forest,
    pposition = C.FW,
    pteam = "Torneo",
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_hand then
            local tarot_count = (G.GAME.used_star_cards or 0) + (G.GAME.used_moon_cards or 0) +
                (G.GAME.used_world_cards or 0) + (G.GAME.used_sun_cards or 0)
            local tarot_units = math.floor(tarot_count / card.ability.extra.requiered_cards)
            local bonus = tarot_units > 0 and card.ability.extra.xmult_mod * (2 ^ (tarot_units - 1)) or 0

            if 1 + bonus > 1 then
                card.ability.extra.triggered = true
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { 1 + bonus } },
                    colour = G.C.MULT,
                    Xmult_mod = 1 + bonus
                }
            end
        end
    end,
}

return {
    name = "Scout",
    list = { Turi },
}
