-- Convert cards
conversion_event_helper = function(func, delay, immediate)
    if immediate then
        func()
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = delay or 0.1,
            func = function()
                func()
                return true
            end
        }))
    end
end

convert_cards_to = function(cards, t, noflip, immediate)
    if not cards then return end
    if cards and cards.is and cards:is(Card) then cards = { cards } end
    if not t.seal and not noflip then
        for i = 1, #cards do
            conversion_event_helper(function()
                cards[i]:flip(); cards[i]:juice_up(0.3, 0.3)
            end)
        end
        delay(0.2)
    end
    for i = 1, #cards do
        if t.mod_conv then
            conversion_event_helper(function() cards[i]:set_ability(G.P_CENTERS[t.mod_conv]) end, nil, immediate)
        end
        if t.edition then
            conversion_event_helper(function() cards[i]:set_edition(t.edition, true) end, nil, immediate)
        end
        if t.suit_conv then
            conversion_event_helper(function() cards[i]:change_suit(t.suit_conv) end, nil, immediate)
        end
        if t.seal then
            conversion_event_helper(function() cards[i]:set_seal(t.seal, nil, true) end, nil, immediate)
        end
        if t.random then
            vary_rank(cards[i], nil, nil, immediate)
        end
        if t.set_rank then
            conversion_event_helper(function()
                local new_card = SMODS.change_base(cards[i], nil, t.set_rank)
                if new_card then cards[i] = new_card end
            end, nil, immediate)
        end
        if t.up or t.down then
            vary_rank(cards[i], not t.up, nil, immediate)
        end
        if t.bonus_chips then
            local bonus_add = function()
                cards[i].ability.perma_bonus = cards[i].ability.perma_bonus or 0
                cards[i].ability.perma_bonus = cards[i].ability.perma_bonus + t.bonus_chips
            end
            conversion_event_helper(bonus_add, nil, immediate)
        end
    end
    if not t.seal and not noflip then
        for i = 1, #cards do
            conversion_event_helper(function()
                cards[i]:flip(); cards[i]:juice_up(0.3, 0.3)
            end, 0.2)
        end
    end
    if not noflip then delay(0.3) end
    if noflip then
        for i = 1, #cards do
            conversion_event_helper(function() cards[i]:juice_up(0.3, 0.3) end, 0.2)
        end
    end
    if cards == G.hand.highlighted then
        conversion_event_helper(function() G.hand:unhighlight_all() end)
    end
end

vary_rank = function(card, decrease, seed, immediate)
    -- if it doesn't have a rank/suit within SMODS, don't do anything
    if not card.base or not card.base.value or not card.base.suit or not SMODS.Ranks[card.base.value] then return end

    local next_rank = nil
    if decrease == nil then
        -- randomize rank (decrease is nil)
        local poss_ranks = {}
        for _, v in pairs(G.P_CARDS) do
            if v.suit == card.base.suit then
                table.insert(poss_ranks, v.value)
            end
        end
        if #poss_ranks > 0 then
            next_rank = pseudorandom_element(poss_ranks, pseudoseed(seed or 'random_rank'))
        end
    elseif decrease then
        -- only need to do this due to prev being a bad table (should be fixed in the next update)
        local poss_ranks = {}
        for _, v in pairs(SMODS.Ranks[card.base.value].prev) do
            if SMODS.Ranks[v] and type(SMODS.Ranks[v].next) == "table" then
                for _, _r in pairs(SMODS.Ranks[v].next) do
                    if _r == card.base.value then
                        table.insert(poss_ranks, v)
                        break
                    end
                end
            end
        end
        if #poss_ranks > 0 then
            next_rank = pseudorandom_element(poss_ranks, pseudoseed(seed or 'decrease_rank'))
        end

        -- once prev table is fixed can use this:
        --[[
    if #SMODS.Ranks[card.base.value].prev > 0 then
      next_rank = pseudorandom_element(SMODS.Ranks[card.base.value].prev, pseudoseed(seed or 'decrease_rank'))
    end
    --]]
    else
        if #SMODS.Ranks[card.base.value].next > 0 then
            next_rank = pseudorandom_element(SMODS.Ranks[card.base.value].next, pseudoseed(seed or 'increase_rank'))
        end
    end

    if immediate then
        card = SMODS.change_base(card, nil, next_rank)
    else
        G.E_MANAGER:add_event(Event({
            func = function()
                card = SMODS.change_base(card, nil, next_rank)
                return true
            end
        }))
    end
end

-- CUSTOM PROBABILITIES HOOK
local original_get_probability_vars = SMODS.get_probability_vars
function SMODS.get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll)
    if identifier == "lucky_mult" then
        return G.GAME.probabilities.normal, 5
    elseif identifier == "lucky_money" then
        local lucky = G.GAME.probabilities.new_lucky or G.GAME.probabilities.normal
        return lucky, 15
    elseif identifier == "glass" then
        local glass = G.GAME.probabilities.new_glass_denom or 4
        return G.GAME.probabilities.normal, glass
    end
    return original_get_probability_vars(trigger_obj, base_numerator, base_denominator, identifier, from_roll)
end

-- * Strat cards used on run counter
local original_card_use = Card.use_consumeable
function Card:use_consumeable(area, copier)
    if self.ability.set == "Strat" then
        G.GAME.strat_cards_used = (G.GAME.strat_cards_used or 0) + 1
    end
    return original_card_use(self, area, copier)
end

--- Get the cards of a suite in played_hand
---@param suite string
---@param hand Card[]|table[]
---@return number
function Pokerleven.get_cards_of_suite(suite, hand)
    local count = 0
    for _, played_card in ipairs(hand) do
        if played_card:is_suit(suite) then
            count = count + 1
        end
    end
    return count
end

---Changes the current barriers. If you use it as a return it will print a message
---@param mod any
---@param instant any
---@return table Loc the message to print on the joker calling this method
function Pokerleven.ease_barriers(mod, instant)
    local function _mod(mod)
        local barrier_UI = G.ina_resources_info:get_UIE_by_ID('barrier_text_UI')
        mod = mod or 0
        local text = '+'
        local col = G.ARGS.LOC_COLOURS['mountain']
        if mod < 0 then
            text = '-'
            col = G.C.RED
        end

        G.GAME.current_round.barriers = (G.GAME.current_round.barriers or 0) + mod
        G.GAME.current_round.barriers = math.max(G.GAME.current_round.barriers, 0)

        if barrier_UI and barrier_UI.config and barrier_UI.config.object and barrier_UI.config.object.update then
            barrier_UI.config.object:update()
        end

        G.HUD:recalculate()

        attention_text({
            text = text .. tostring(math.abs(mod)),
            scale = 0.8,
            hold = 0.7,
            cover = barrier_UI and barrier_UI.parent,
            cover_colour = col,
            align = 'cm',
        })

        play_sound('tarot1')
    end

    if instant then
        _mod(mod)
    else
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                _mod(mod)
                return true
            end
        }))
    end
    return {
        message = localize('ina_generate_barriers'),
        colour = G.C.ORANGE
    }
end

local original_unlock_card = unlock_card

function unlock_card(card)
    if card.set == 'Joker' and not card.ptype then
        return
    end
    original_unlock_card(card)
end

Pokerleven.select_random_seal = function(seed)
    return pseudorandom_element(C.SEALS, seed)
end

Pokerleven.set_random_seals_to_highlighted_hand = function(seed)
    for i = 1, #G.hand.highlighted do
        local seal = Pokerleven.select_random_seal(seed)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                G.hand.highlighted[i]:set_seal(seal, true);
                return true
            end
        }))
    end
end

Pokerleven.get_all_type_pos_combinations = function()
    local combinations = {}
    local c_set = {}
    for _, t in ipairs(C.ALL_TYPES) do
        for _, p in ipairs(C.ALL_POSITIONS) do
            local key = C.INA_UPGRADE_TECHNIQUE_KEY .. t .. "_" .. p
            if #Pokerleven.find_player_type_and_position(t, p) > 0 and not c_set[key] then
                table.insert(combinations, key)
                c_set[key] = true
            end
        end
    end

    return combinations
end

Pokerleven.get_random_type_pos_held = function()
    local combinations = Pokerleven.get_all_type_pos_combinations()
    local selected_combination = pseudorandom_element(combinations, pseudoseed('training'))
    return selected_combination;
end
