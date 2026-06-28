-- CUSTOM Small And Big Blinds
function get_new_small()
    G.GAME.perscribed_small = G.GAME.perscribed_small or {
    }
    if G.GAME.perscribed_small and G.GAME.perscribed_small[G.GAME.round_resets.ante] then
        local ret_boss = G.GAME.perscribed_small[G.GAME.round_resets.ante]
        G.GAME.perscribed_small[G.GAME.round_resets.ante] = nil
        return ret_boss
    end
    if G.FORCE_SMALL then return G.FORCE_SMALL end

    local eligible_bosses = { bl_small = true }
    for k, v in pairs(G.P_BLINDS) do
        if not v.small then
            -- don't add
        elseif v.in_pool and type(v.in_pool) == 'function' then
            local res, options = v:in_pool()
            eligible_bosses[k] = res and true or nil
        elseif v.small.min <= math.max(1, G.GAME.round_resets.ante) then
            eligible_bosses[k] = true
        end
    end
    for k, v in pairs(G.GAME.banned_keys) do
        if eligible_bosses[k] then eligible_bosses[k] = nil end
    end

    for k, v in pairs(eligible_bosses) do
        local mod = G.P_BLINDS[k] and G.P_BLINDS[k].mod
        if Pokerleven.config.custom_middle_blinds == false then
            if mod and mod.id == 'Pokerleven' then
                eligible_bosses[k] = nil
            end
        else
            if not mod or mod.id ~= 'Pokerleven' then
                eligible_bosses[k] = nil
            end
        end
    end

    local _, boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'))

    return boss
end

function get_new_big()
    G.GAME.perscribed_big = G.GAME.perscribed_big or {
    }
    if G.GAME.perscribed_big and G.GAME.perscribed_big[G.GAME.round_resets.ante] then
        local ret_boss = G.GAME.perscribed_big[G.GAME.round_resets.ante]
        G.GAME.perscribed_big[G.GAME.round_resets.ante] = nil
        return ret_boss
    end
    if G.FORCE_BIG then return G.FORCE_BIG end

    local eligible_bosses = { bl_big = true }
    for k, v in pairs(G.P_BLINDS) do
        if not v.big then
            -- don't add
        elseif v.in_pool and type(v.in_pool) == 'function' then
            local res, options = v:in_pool()
            eligible_bosses[k] = res and true or nil
        elseif v.big.min <= math.max(1, G.GAME.round_resets.ante) then
            eligible_bosses[k] = true
        end
    end
    for k, v in pairs(G.GAME.banned_keys) do
        if eligible_bosses[k] then eligible_bosses[k] = nil end
    end

    for k, v in pairs(eligible_bosses) do
        local is_mod = G.P_BLINDS[k].mod and G.P_BLINDS[k].mod.id == 'Pokerleven'

        if Pokerleven.config.custom_middle_blinds == false then
            if is_mod then
                eligible_bosses[k] = nil
            end
        else
            if not is_mod then
                eligible_bosses[k] = nil
            end
        end
    end

    local _, boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'))

    return boss
end

-- RERROLL BIG BLINDS
reroll_big = function(e)
    stop_use()
    G.GAME.round_resets.big_rerolled = true
    G.from_boss_tag = nil -- Por si quieres reutilizar el flag
    G.CONTROLLER.locks.big_reroll = true

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            play_sound('other1')
            G.blind_select_opts.big:set_role({ xy_bond = 'Weak' })
            G.blind_select_opts.big.alignment.offset.y = 20
            return true
        end
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = (function()
            local par = G.blind_select_opts.big.parent
            G.GAME.round_resets.blind_choices.Big = get_new_big()

            G.blind_select_opts.big:remove()
            G.blind_select_opts.big = UIBox {
                T = { par.T.x, 0, 0, 0 },
                definition = {
                    n = G.UIT.ROOT, config = { align = "cm", colour = G.C.CLEAR }, nodes = {
                    UIBox_dyn_container({ create_UIBox_blind_choice('Big') }, false, get_blind_main_colour('Big'), mix_colours(G.C.BLACK, get_blind_main_colour('Big'), 0.8))
                }
                },
                config = {
                    align = "bmi",
                    offset = { x = 0, y = G.ROOM.T.y + 9 },
                    major = par,
                    xy_bond = 'Weak'
                }
            }

            par.config.object = G.blind_select_opts.big
            par.config.object:recalculate()
            G.blind_select_opts.big.parent = par
            G.blind_select_opts.big.alignment.offset.y = 0

            G.E_MANAGER:add_event(Event({
                blocking = false,
                trigger = 'after',
                delay = 0.5,
                func = function()
                    G.CONTROLLER.locks.big_reroll = nil
                    return true
                end
            }))

            save_run()
            for i = 1, #G.GAME.tags do
                if G.GAME.tags[i]:apply_to_run({ type = 'new_blind_choice' }) then break end
            end

            return true
        end)
    }))
end

---Decreases blind size by a percent per member o blind team
---@param percent_per_member number Percent to decrease per player
function apply_team_discount_to_blind(percent_per_member)
    local team = find_player_team(G.GAME.blind.name)
    local count = #team

    if count > 0 then
        G.GAME.blind.chips = G.GAME.blind.chips * (1 - (percent_per_member * count / 100))
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
end

local blind_get_type = Blind.get_type
function Blind:get_type()
    if self.small then
        return 'Small'
    elseif self.big then
        return 'Big'
    else
        return blind_get_type(self)
    end
end

local old_blind_save = Blind.save
function Blind:save()
    local save_table = old_blind_save(self)
    save_table.small = self.small
    save_table.big = self.big
    return save_table
end

local old_blind_load = Blind.load
function Blind:load(blindTable)
    old_blind_load(self, blindTable)
    self.small = blindTable.small
    self.big = blindTable.big
end

-- When object_weights is enabled, SMODS bypasses get_new_boss() and uses
-- SMODS.create_blind_pool() instead. That pool doesn't respect the mod's
-- custom_middle_blinds filter, so we wrap it here.
if SMODS.create_blind_pool then
    local old_create_blind_pool = SMODS.create_blind_pool
    function SMODS.create_blind_pool(blind_type, skip_cull)
        local pool = old_create_blind_pool(blind_type, skip_cull)
        if Pokerleven and Pokerleven.config and Pokerleven.config.custom_middle_blinds == true then
            local filtered = {}
            for _, k in ipairs(pool) do
                local blind = G.P_BLINDS[k]
                if blind and blind.mod and blind.mod.id == 'Pokerleven' then
                    filtered[#filtered + 1] = k
                end
            end
            if #filtered == 0 then
                for k in pairs(G.GAME.bosses_used) do
                    local blind = G.P_BLINDS[k]
                    if blind and blind.mod and blind.mod.id == 'Pokerleven' then
                        G.GAME.bosses_used[k] = 0
                    end
                end
                pool = old_create_blind_pool(blind_type, skip_cull)
                for _, k in ipairs(pool) do
                    local blind = G.P_BLINDS[k]
                    if blind and blind.mod and blind.mod.id == 'Pokerleven' then
                        filtered[#filtered + 1] = k
                    end
                end
                if #filtered == 0 then
                    for _, k in ipairs(pool) do
                        filtered[#filtered + 1] = k
                    end
                end
            end
            return filtered
        end
        return pool
    end
end


