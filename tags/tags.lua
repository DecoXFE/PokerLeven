local wild_tag = {
    object_type = "Tag",
    atlas = "Tags01",
    name = "wild_tag",
    order = 27,
    pos = { x = 0, y = 0 },
    config = { type = "store_joker_create" },
    key = "wild_tag",
    min_ante = 2,
    discovered = false,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end,
    apply = function(self, tag, context)
        if context and context.type == "store_joker_create" then
            local card = nil

            local possible_teams = {}
            if G.jokers and G.jokers.cards then
                for _, v in pairs(G.jokers.cards) do
                    if v.ability and type(v.ability.extra) == "table" and v.ability.extra.pteam then
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

            card = create_random_ina_joker("wildtag", "Uncommon", context.area, selected_team)
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            tag:yep('+', G.C.GREEN, function()
                if pseudorandom('wild_tag', 1, 8) == 1 then
                    card:set_edition('e_negative')
                end
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)

            tag.triggered = true
            return card
        end
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local chain_tag = {
    object_type = "Tag",
    atlas = "Tags01",
    name = "chain_tag",
    order = 27,
    pos = { x = 1, y = 0 },
    config = {},
    key = "chain_tag",
    min_ante = 2,
    discovered = false,
    loc_vars = function(self, info_queue)
        return { vars = {} }
    end,
    apply = function(self, tag, context)
        if G.GAME.round_resets.blind == G.P_BLINDS.bl_small then
            tag:yep('+', G.C.GREEN, function()
                reroll_big()
                return true
            end)
        else
            tag:yep('+', G.C.GREEN, function()
                G.FUNCS.reroll_boss()
                return true
            end)
        end

        tag.triggered = true
        return true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local bench_tag = T({
    object_type = "Tag",
    atlas = "Tags01",
    name = "bench_tag",
    order = 27,
    pos = { x = 3, y = 4 },
    config = {},
    key = "bench_tag",
    min_ante = 1,
    discovered = false,
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_ina_manager_pack
    end,
    apply = function(self, tag, context)
        return Pokerleven.open_booster_from_tag(tag, 'p_ina_manager_pack', context)
    end,
    ina_credits = {
        art = { "Shadorossa" }
    },
    in_pool = function(self, args)
        if #Pokerleven.ina_manager_area.cards >= Pokerleven.ina_manager_area.config.card_limit then
            return false
        end
        return true
    end
})

local technique_tag = {
    object_type = "Tag",
    atlas = "Tags01",
    name = "technique_tag",
    order = 27,
    pos = { x = 4, y = 3 },
    config = {},
    key = "technique_tag",
    min_ante = 6,
    discovered = false,
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_ina_mega_training_pack
    end,
    apply = function(self, tag, context)
        return Pokerleven.open_booster_from_tag(tag, 'p_ina_mega_training_pack', context)
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

return {
    name = "Tags",
    list = { wild_tag, chain_tag, bench_tag, technique_tag }
}
