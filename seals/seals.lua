local training_seal = {
    name = "training",
    key = "training",
    badge_colour = HEX("5A00FF"),
    atlas = "stickers02",
    pos = { x = 3, y = 0 },
    calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition_only and context.main_scoring and G.GAME.current_round.hands_left == 0 then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        local selected_combination
                        if pseudorandom('training_seal', 1, 5) > 4 then
                            local combinations = Pokerleven.get_all_type_pos_combinations()
                            selected_combination = pseudorandom_element(combinations, pseudoseed('training_seal'))
                        end

                        local _card = create_card(C.TRAINING, G.consumeables, nil, nil, false, false,
                            selected_combination or nil, nil)
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        card:juice_up()
                    end
                    return true
                end,
            }))
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize("ina_training_upgrades"), colour = G.ARGS.LOC_COLOURS["training"] })
            end
        end
    end,
}

return {
    name = "Seals",
    list = { training_seal }
}
