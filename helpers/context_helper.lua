---Returns true if it's the turn of the self joker
---@param context table|CalcContext
---@return boolean?
Pokerleven.is_joker_turn = function(context)
    return context.scoring_hand and context.cardarea == G.jokers and
        context.joker_main
end

------Returns true if it's the turn of the self joker and the last hand
---@param context table|CalcContext
---@return boolean?
Pokerleven.is_joker_last_hand = function(context)
    return Pokerleven.is_joker_turn(context) and G.GAME.current_round.hands_left == 0
end

---Returns true if its the joker turn at the end of the round
---@param context table|CalcContext
---@return boolean?
Pokerleven.is_joker_end_of_round = function(context)
    return context.end_of_round and context.main_eval
end

---Returns true if the joker is the leftmost one
---@return boolean
Card.is_leftmost_joker = function(self)
    return G.jokers.cards[1] == self
end


---Returns true if the joker is the rightmost one
---@return boolean
Card.is_rightmost_joker = function(self)
    return G.jokers.cards[#G.jokers.cards] == self
end

---Emplaces joker and adds it to deck
---@param card Card
Pokerleven.add_card_to_jokers = function(card)
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            G.jokers:emplace(card)
            card:add_to_deck()
            return true
        end
    }))
end

---Emplaces consumable and adds it to deck
---@param card Card
Pokerleven.add_card_to_consumables = function(card)
    if card then
        card:add_to_deck()
        G.consumeables:emplace(card)
    end
end

--- Returns true if current barriers > card.ability.extra.barriers
---@return boolean
Card.has_enough_barriers = function(self)
    return G.GAME.current_round.barriers >= self.ability.extra.barriers
end

--- Returns true if consumables limit > current consumables
---@return boolean
Pokerleven.has_enough_consumables_space = function()
    return #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
end

--- Returns true if bench limit > current consumables
---@return boolean
Pokerleven.has_enough_bench_space = function()
    return Pokerleven.ina_bench_area.config.card_limit > Pokerleven.ina_bench_area.config.card_count
end

---Returns true if all cards played are face
---@param context CalcContext
---@return boolean
Pokerleven.are_all_face = function(context)
    for _, card in ipairs(context.scoring_hand) do
        if not card:is_face() then
            return false
        end
    end
    return true
end

---Returns a single card scoring or nil if it is not
---@param context table|CalcContext
---@return Card|nil
Pokerleven.card_scoring = function(context)
    if context.cardarea == G.play and context.other_card and context.scoring_hand then
        return context.other_card
    end
    return nil
end

---Returns true if card is uneven
---@return boolean
Card.is_uneven = function(self)
    if not self:is_face() and (self:get_id() % 2 ~= 0 or self:get_id() == 14) then
        return true
    end
    return false
end

---Returns true if odds of card triggered
---@param self Card
---@return boolean
Card.odds_triggered = function(self, seed)
    return pseudorandom(seed) < G.GAME.probabilities.normal / self.ability.extra.odds
end

---Shows a text on the card
---@param self Card
---@param text_key string
Card.show_text = function(self, text_key)
    card_eval_status_text(self, 'extra', nil, nil, nil, { message = localize(text_key) })
end

---Executes a function with a certain delay
---@param action function
---@param delay number
Pokerleven.execute_function_with_delay = function(action, delay)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = delay,
        func = function()
            action()
            return true
        end
    }))
end

function Pokerleven.clone_table(tbl)
    local copy = {}
    for i, v in ipairs(tbl) do copy[i] = v end
    return copy
end

Card.set_as_harvestable = function(self)
    self.ability["ina_harvest_sticker"] = true
    card_eval_status_text(self, 'extra', nil, nil, nil, {
        message = localize("ina_harvest"),
        colour = G.C.GREEN
    })
end

Card.create_consumable_as_joker = function(self, consumable_type)
    return {
        extra = {
            focus = self,
            message = localize('k_plus_tarot'),
            colour = G.C.PURPLE,
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        local _card = create_card(consumable_type, G.consumeables, nil, nil, nil, nil, nil)
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            end
        }
    }
end

-- Función para comprobar si estamos en la fase después de la puntuación
---@param context table
---@return boolean True
Pokerleven.after_scoring_phase = function(context)
    return context.after and context.cardarea == G.jokers
end
