-- ENABLE DYNAMIC WEIGHT FOR BOOSTERS
local function get_weight(v)
    if type(v.weight) == "function" then return v.weight() end
    return v.weight or 1
end

function get_pack(_key, _type)
    if not G.GAME.first_shop_buffoon and not G.GAME.banned_keys['p_buffoon_normal_1'] then
        G.GAME.first_shop_buffoon = true
        return G.P_CENTERS['p_buffoon_normal_' .. (math.random(1, 2))]
    end
    local cume, it, center = 0, 0, nil
    for k, v in ipairs(G.P_CENTER_POOLS['Booster']) do
        if (not _type or _type == v.kind) and not G.GAME.banned_keys[v.key] then
            cume = cume + get_weight(v)
        end
    end
    local poll = pseudorandom(pseudoseed((_key or 'pack_generic') .. G.GAME.round_resets.ante)) * cume
    for k, v in ipairs(G.P_CENTER_POOLS['Booster']) do
        if not G.GAME.banned_keys[v.key] then
            if not _type or _type == v.kind then
                it = it + get_weight(v)
            end
            if it >= poll and it - get_weight(v) <= poll then
                center = v; break
            end
        end
    end
    return center
end

Pokerleven.open_booster_from_tag = function(tag, booster_key, context)
    if context.type == 'new_blind_choice' then
        local lock = tag.ID
        G.CONTROLLER.locks[lock] = true
        tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
            local booster = SMODS.create_card { key = booster_key, area = G.play }
            booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
            booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
            booster.T.w = G.CARD_W * 1.27
            booster.T.h = G.CARD_H * 1.27
            booster.cost = 0
            booster.from_tag = true
            G.FUNCS.use_card({ config = { ref_table = booster } })
            booster:start_materialize()
            G.CONTROLLER.locks[lock] = nil
            return true
        end)
        tag.triggered = true
        return true
    end
end
