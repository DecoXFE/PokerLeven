local hillman = Ba({
    name = "hillman",
    key = "hillman",
    order = 1,
    unlocked = true,
    discovered = true,
    config = { managers = 2, ante = 4, strats_created = 1 },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                self.config.managers,
                self.config.ante,
                self.config.strats_created
            }
        }
    end,
    pos = { x = 1, y = 0 },
    atlas = "decks",
    apply = function(self, back)
        Pokerleven.ina_manager_area.config.card_limit = self.config.managers
        G.GAME.modifiers.ina_hillman_deck_ante = 4
    end
})

local original_ease_round = ease_round
function ease_round(mod)
    if G.GAME.modifiers.ina_hillman_deck_ante and
        G.GAME.round_resets.ante >= G.GAME.modifiers.ina_hillman_deck_ante
        and Pokerleven.has_enough_consumables_space() then
        local strat = create_card('Strat', G.consumeables, nil, nil, false, false, nil, nil)
        Pokerleven.add_card_to_consumables(strat)
    end
    original_ease_round(mod)
end

local ray_dark = Ba({
    name = "Ray Dark",
    key = "ray_dark",
    order = 2,
    unlocked = false,
    discovered = true,
    config = { managers = 0 },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                self.config.managers
            }
        }
    end,
    pos = { x = 2, y = 0 },
    atlas = "decks",
    apply = function(self, back)
        Pokerleven.ina_manager_area.config.card_limit = self.config.managers
        G.GAME.spectral_rate = 2.25
    end,
    check_for_unlock = function(self, args)
        if args.type == "ray_dark" then
            unlock_card(self)
        end
    end
})

local newton_thomas = Ba({
    name = "Newton Thomas",
    key = "newton_thomas",
    order = 2,
    unlocked = true,
    discovered = true,
    config = { managers = 1 },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                self.config.managers
            }
        }
    end,
    pos = { x = 6, y = 0 },
    atlas = "decks",
    apply = function(self, back)
        Pokerleven.ina_manager_area.config.card_limit = self.config.managers
        G.GAME.scry_amount = 3
        ease_hands_played(-1)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
    end,
})

local wintersea = Ba({
    name = "Wintersea",
    key = "wintersea",
    order = 2,
    unlocked = true,
    discovered = true,
    config = { managers = 1 },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                self.config.managers
            }
        }
    end,
    pos = { x = 0, y = 0 },
    atlas = "decks",
    apply = function(self, back)
        Pokerleven.ina_manager_area.config.card_limit = self.config.managers
    end,
    calculate = function(self, back, context)
        if context.card_added and #G.jokers.cards == 0 then
            if context.card and context.card.ability
                and context.card.ability.extra
                and context.card.ability.extra.ptype then
                context.card.ability.eternal = true
                context.card.pinned = true
                context.card:set_edition('e_polychrome')
            end
        end
    end
})

return {
    name = "Decks",
    list = { hillman, ray_dark, newton_thomas, wintersea }
}
