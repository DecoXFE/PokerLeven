find_player_type = function(target_type, is_not)
    local found = {}
    if G.jokers and G.jokers.cards then
        for _, v in pairs(G.jokers.cards) do
            if v.ability then
                local extra = v.ability.extra
                local has_sticker = v.ability[string.lower(target_type) .. "_sticker"]

                if extra and type(extra) == "table" then
                    if is_not then
                        if extra.ptype ~= target_type then
                            table.insert(found, v)
                        end
                    else
                        if extra.ptype == target_type then
                            table.insert(found, v)
                        end
                    end
                elseif has_sticker then
                    table.insert(found, v)
                end
            end
        end
    end
    return found
end

find_player_position = function(target_type)
    local found = {}
    if G.jokers and G.jokers.cards then
        for k, v in pairs(G.jokers.cards) do
            if v.ability and ((v.ability.extra and type(v.ability.extra) == "table"
                    and target_type == v.ability.extra.pposition) or v.ability[string.lower(target_type) .. "_sticker"]) then
                table.insert(found, v)
            end
        end
    end
    return found
end

--- Returns players of target type and position
---@param target_type string the type of the player
---@param target_position string the position of the player
---@return table
Pokerleven.find_player_type_and_position = function(target_type, target_position)
    local found = {}
    if G.jokers and G.jokers.cards then
        for _, v in pairs(G.jokers.cards) do
            if v.ability and v.ability.extra and type(v.ability.extra) == "table" then
                if v.ability.extra.ptype == target_type and v.ability.extra.pposition == target_position then
                    table.insert(found, v)
                end
            end
        end
    end
    return found
end

---@param selected_pos string
---@param required number
---@return boolean
Pokerleven.has_enough_position = function(selected_pos, required)
    return #find_player_position(selected_pos) >= required
end

---Returns the team with most players
---@return string|nil most_played Team with most players
Pokerleven.most_played_team = function()
    local team_counts = {}

    if G.jokers and G.jokers.cards then
        for _, v in pairs(G.jokers.cards) do
            if v.ability and v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.pteam and v.config.center_key ~= "j_ina_Bobby" then
                local team = v.ability.extra.pteam
                team_counts[team] = (team_counts[team] or 0) + 1
            end
        end
    end

    local most_played = nil
    local max_count = 0

    for team, count in pairs(team_counts) do
        if count > max_count then
            most_played = team
            max_count = count
        end
    end

    return most_played
end

find_player_team = function(target_type)
    local found = {}
    if G.jokers and G.jokers.cards then
        for k, v in pairs(G.jokers.cards) do
            if v.ability and ((v.ability.extra and type(v.ability.extra) == "table"
                    and target_type == v.ability.extra.pteam) or v.ability[string.lower(target_type) .. "_sticker"]) then
                table.insert(found, v)
            end
        end
    end
    return found
end

is_team = function(card, target_team)
    if card.ability and (card.ability.extra and type(card.ability.extra) == "table" and target_team == card.ability.extra.pteam) then
        return true
    else
        return false
    end
end

is_position = function(card, target_position)
    if card.ability and (card.ability.extra and type(card.ability.extra) == "table" and target_position == card.ability.extra.pposition) then
        return true
    else
        return false
    end
end

is_type = function(card, target_type)
    if card.ability and (card.ability.extra and type(card.ability.extra) == "table" and target_type == card.ability.extra.ptype) then
        return true
    else
        return false
    end
end

get_team = function(card)
    if card.ability then
        if type(card.ability.extra) == "table" and card.ability.extra.pteam then
            return card.ability.extra.pteam
        end
    end
    return nil
end

local player_in_bench = function(name)
    if (not Pokerleven.ina_bench_area or not Pokerleven.ina_bench_area.cards) then
        return false
    end

    for _, card in ipairs(Pokerleven.ina_bench_area.cards) do
        if name == card.config.center.name then
            return true
        end
    end
    return false
end

player_in_pool = function(self)
    if self.special then
        return false
    end

    if next(find_joker("Custom")) and self.ptype == "Wind" then
        return true
    end

    local name
    if not self.name and self.ability.name then
        name = self.ability.name
    else
        name = self.name or "Mark"
    end
    if next(find_joker(name)) or player_in_bench(name) or self.pteam == 'Scout' then
        return false
    else
        return true
    end
end

get_adjacent_jokers = function(card)
    local jokers = {}
    if #G.jokers.cards > 1 then
        local pos = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                pos = i
                break
            end
        end
        if pos > 1 and G.jokers.cards[pos - 1] then
            table.insert(jokers, G.jokers.cards[pos - 1])
        end
        if pos < #G.jokers.cards and G.jokers.cards[pos + 1] then
            table.insert(jokers, G.jokers.cards[pos + 1])
        end
    end
    return jokers
end

-- Creates random card
create_random_ina_joker = function(pseed, inararity, area, inateam, enable_dupes, special, exclude_keys)
    local create_args = { set = "Joker", area = nil, key = '' }
    create_args.key = get_random_joker_key(pseed, inararity, area, inateam, exclude_keys or nil, enable_dupes or nil,
        special or nil)

    return SMODS.create_card(create_args)
end

get_random_joker_key = function(pseed, inararity, area, inateam, exclude_keys, enable_dupes, special)
    local ina_keys = {}
    local inaarea = area or G.jokers
    local ina_key
    exclude_keys = exclude_keys or { j_ina_Jude_Raimon = true }

    if inararity and type(inararity) == "string" then
        if string.lower(inararity) == "common" then inararity = 1 end
        if string.lower(inararity) == "uncommon" then inararity = 2 end
        if string.lower(inararity) == "rare" then inararity = 3 end
    end

    for _, v in pairs(G.P_CENTERS) do
        if ((special and v.special == special) or v.pteam)
            and not (inararity and v.rarity ~= inararity)
            and not (inateam and v.pteam and inateam ~= v.pteam)
            and (
                (special and v.special == special) -- cuando hay special, valida solo esto
                or (not special and (player_in_pool(v) or (inateam == 'Scout' and v.pteam == 'Scout')))
            )
            and not v.aux_ina
            and not exclude_keys[v.key]
        then
            local no_dup = true
            if not enable_dupes and inaarea and inaarea.cards and not next(find_joker("Showman")) then
                if inaarea == Pokerleven.ina_bench_area then
                    for _, m in pairs(G.jokers.cards) do
                        if v.key == m.config.center_key then
                            no_dup = false
                            break
                        end
                    end
                end
                for _, m in pairs(inaarea.cards) do
                    if v.key == m.config.center_key then
                        no_dup = false
                        break
                    end
                end
            end

            if no_dup then
                table.insert(ina_keys, v.key)
            end
        end
    end

    if #ina_keys == 0 and enable_dupes then
        for _, v in pairs(G.P_CENTERS) do
            if v.pteam
                and not (inararity and v.rarity ~= inararity)
                and not (inateam and inateam ~= v.pteam)
                and not v.aux_ina
                and not exclude_keys[v.key] then
                -- Para enable_dupes ignoramos player_in_pool y repetición
                table.insert(ina_keys, v.key)
            end
        end
    end

    if #ina_keys > 0 then
        ina_key = pseudorandom_element(ina_keys, pseudoseed(pseed))
    else
        ina_key = "j_ina_Willy"
    end

    return ina_key
end

--- Spawns a random Ina Joker with custom rarity/team tables.
---@param card table The card triggering the effect
---@param context table The current game context
---@param rarity_table table<string, number> A table of rarities and their corresponding chance
---@param team_table table<string, number> A table of team names and their corresponding chance
---@return table Effect table with a `.func` function to be executed to spawn the joker
function spawn_random_ina_joker(card, context, rarity_table, team_table)
    local function roll_from_table(t, seed)
        local roll = pseudorandom(seed)
        local cumulative = 0
        for key, chance in pairs(t) do
            cumulative = cumulative + chance
            if roll < cumulative then return key end
        end

        local last_key = nil
        for k in pairs(t) do last_key = k end
        return last_key
    end

    return {
        func = function()
            local created_joker = false
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                created_joker = true
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1

                local rarity = roll_from_table(rarity_table, 'ina_rarity')
                local team = roll_from_table(team_table, 'ina_team')

                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        G.GAME.joker_buffer = 0
                        print("Rarity:", rarity)
                        print("Team:", team)
                        local _card = create_random_ina_joker('sweet', rarity, G.jokers, team, true, nil,
                            { j_ina_Jude_Raimon = true })
                        _card:add_to_deck()
                        G.jokers:emplace(_card)
                        return true
                    end
                }))
            end

            if created_joker then
                card.ability.extra.triggered = true
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                    message = localize('k_plus_joker'),
                    colour = G.C.BLUE
                })
            end

            return true
        end
    }
end

--- Returns the average sell value of a group of type jokers
---@param ptype string The reference type
---@return number|nil avg_sell_value Average sell value of the group of jokers. Nil for collection
calculate_avg_sell_cost = function(ptype)
    local sumSellCost = 0
    if G.jokers then
        for _, v in pairs(G.jokers.cards) do
            if ptype == nil then
                sumSellCost = sumSellCost + v.sell_cost
            else
                if v.ability.extra.ptype == ptype then
                    sumSellCost = sumSellCost + v.sell_cost
                end
            end
        end

        if ptype == nil then
            return sumSellCost / #G.jokers.cards
        else
            return sumSellCost / #find_player_type(ptype)
        end
    end

    return nil
end

Pokerleven.calculate_total_sell_cost = function(cards)
    local sumSellCost = 0
    for _, card in ipairs(cards) do
        sumSellCost = sumSellCost + card.sell_cost
    end
    return sumSellCost
end

--- Returns the joker to the right of the given joker in the active jokers row.
---@param main_card SMODS.Joker The reference joker.
---@return SMODS.Joker|nil Right_Joker Joker immediately to the right, or nil if not found or at the end.
function get_right_joker(main_card)
    sendDebugMessage("Looking for main_card in G.jokers.cards")
    for k, v in ipairs(G.jokers.cards) do
        if v == main_card then
            return G.jokers.cards[k + 1]
        end
    end
    return nil
end

--- Returns the joker with the key provided, in the area provided or jokers if nil
---@param key string The reference joker key
---@param areaCards table | nil The area to search
---@return Card|SMODS.Joker|nil Selected_Joker Joker with that key or nil if not found
function get_joker_with_key(key, areaCards)
    for _, v in ipairs(areaCards or G.jokers.cards) do
        if v.config.center_key == key then
            return v
        end
    end
end

Pokerleven.destroy_all_jokers = function()
    for _, c in ipairs(G.jokers.cards) do
        c:start_dissolve({ HEX("57ecab") }, nil, 1.6)
        c:remove_from_deck()
    end
end

---@param manager_key string
Pokerleven.destroy_manager_with_key = function(manager_key)
    local manager = get_joker_with_key(manager_key, Pokerleven.ina_manager_area.cards)

    if manager then
        manager:start_dissolve({ HEX("57ecab") }, nil, 1.6)
        manager:remove_from_deck()
    end
end

---Aplica un elemento a un jugador, priorizando el más a la izquierda
---@param element string Elemento a aplicar (ej: "Fire")
---@param message_key string Clave de localización del mensaje (ej: "ina_onfire")
---@param colour table Color para el texto (ej: G.C.RED)
apply_element = function(element, message_key, colour)
    local without_that_element = find_player_type(element, true)

    if #without_that_element > 0 then
        for _, player in ipairs(without_that_element) do
            apply_property_sticker(player, element, "type")
            card_eval_status_text(player, 'extra', nil, nil, nil, {
                message = localize(message_key),
                colour = colour or G.C.WHITE
            })
        end
    end
end

restore_types_for_area = function()
    local function restore_types(area)
        if area and area.cards then
            for _, player in ipairs(area.cards) do
                if player and player.config and player.config.center and player.config.center.ptype then
                    apply_property_sticker(player, player.config.center.ptype, "type")
                end
            end
        end
    end

    if G and G.jokers then
        restore_types(G.jokers)
    end

    if Pokerleven.ina_bench_area and Pokerleven.ina_bench_area.cards then
        restore_types(Pokerleven.ina_bench_area)
    end
end

Pokerleven.get_random_team_from_actuals = function()
    local possible_teams = {}
    if G.jokers and G.jokers.cards then
        for _, v in pairs(G.jokers.cards) do
            if v.ability and type(v.ability.extra) == "table" and v.ability.extra.pteam
                and v.ability.extra.pteam ~= "Scout" then
                possible_teams[v.ability.extra.pteam] = true
            end
        end
    end

    local team_list = {}
    for team, _ in pairs(possible_teams) do
        table.insert(team_list, team)
    end

    local selected_team = nil
    if #team_list > 0 then
        selected_team = pseudorandom_element(team_list, pseudoseed("teamselect"))
    end
    if not selected_team then
        selected_team = "Raimon"
    end

    return selected_team
end

---@param enh_name string
---@return integer
Pokerleven.get_enhancement_count = function(c, enh_name)
    local count = 0
    if SMODS.has_enhancement(c, enh_name) then
        count = count + 1
    end
    return count
end

Pokerleven.get_jokers_to_the_left = function(card)
    for i, c in ipairs(G.jokers.cards) do
        if c == card then
            return i - 1
        end
    end
    return 0
end

Pokerleven.get_jokers_to_the_right = function(card)
    for i, c in ipairs(G.jokers.cards) do
        if c == card then
            return #G.jokers.cards - i
        end
    end
    return 0
end
