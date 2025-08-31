local glasses_team = {
    object_type = "Challenge",
    key = "glasses_team",
    rules = {
        modifiers = {
            { id = 'joker_slots', value = 5 },
        }
    },
    jokers = {
        { id = "j_ina_Willy", eternal = true },
        { id = "j_ina_Willy", eternal = true },
        { id = "j_ina_Willy", eternal = true },
        { id = "j_ina_Willy", eternal = true },
    },
    restrictions = {
        banned_cards = {
            { id = "j_ina_Cleats" }
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
        type = 'Challenge Deck',
    },
}

local love_pair = {
    object_type = "Challenge",
    key = "love_pair",
    rules = {
        modifiers = {
            { id = 'joker_slots', value = 5 },
        }
    },
    jokers = {
        { id = "j_ina_Damian", eternal = true },
        { id = "j_ina_Blazer", eternal = true },
    },
    restrictions = {
        banned_cards = {
            { id = "j_ina_Cleats" }
        },
        banned_tags = {
        },
        banned_other = {
            { id = "bl_ina_fire", type = "blind" },
        },
    },
    deck = {
        type = 'Challenge Deck',
    },
}

local elementals = {
    object_type = "Challenge",
    key = "elementals",
    rules = {
        custom = {
            { id = 'ina_elementals' },
        },
        modifiers = {
            { id = 'joker_slots', value = 10 },
        }
    },
    jokers = {
        { id = "j_ina_Weathervane", eternal = true },
        { id = "j_ina_Blazer",      eternal = true },
        { id = "j_ina_Noggin",      eternal = true },
        { id = "j_ina_Montayne",    eternal = true },
    },
    restrictions = {
        banned_cards = {
            { id = "j_ina_Cleats" },
            { id = "v_directors_cut" }
        },
        banned_tags = {
            { id = "tag_ina_chain_tag" }
        },
        banned_other = {
        },
    },
    deck = {
        type = 'Challenge Deck',
    },
}

local futbol_frontier = {
    object_type = "Challenge",
    key = "futbol_frontier",
    rules = {
        custom = {
            { id = 'ina_futbol_frontier' },
        },
        modifiers = {
        }
    },
    jokers = {
    },
    restrictions = {
        banned_cards = {
            { id = "v_directors_cut" }
        },
        banned_tags = {
            { id = "tag_ina_chain_tag" }
        },
        banned_other = {
        },
    },
    deck = {
        type = 'Challenge Deck',
    },
}

local more_or_less = {
    object_type = "Challenge",
    key = "more_or_less",
    rules = {
        modifiers = {
            { id = 'joker_slots', value = 5 },
        }
    },
    jokers = {
        { id = "j_ina_Marvin", eternal = true },
        { id = "j_ina_Thomas", eternal = true },
        { id = "j_ina_Tyler",  eternal = true },
    },
    restrictions = {
        banned_cards = {
            { id = "j_ina_Cleats" }
        },
        banned_tags = {
        },
        banned_other = {
        },
    },
    deck = {
        type = 'Challenge Deck',
    },
}

local mark_challenge = Ch({
    object_type = "Challenge",
    key = "mark_challenge",
    rules = {
        custom = {
            { id = 'ina_win_ante16' },
        },
        modifiers = {
            { id = 'joker_slots', value = 5 },
        }
    },
    jokers = {
        { id = "j_ina_Mark", eternal = true },
    },
    restrictions = {
        banned_cards = {
            { id = "j_ina_Cleats" }
        },
        banned_tags = {},
        banned_other = {},
    },
    deck = {
        type = 'Challenge Deck',
    },
    apply = function(self)
        G.GAME.win_ante = 16
    end
})

local recruiter = {
    object_type = "Challenge",
    key = "recruiter",
    rules = {
        custom = {
            { id = 'no_shop_jokers' },
        },
        modifiers = {
            { id = 'joker_slots', value = 5 },
        }
    },
    jokers = {
        { id = "j_ina_Celia", eternal = true },
    },
    restrictions = {
        banned_cards = {
            { id = "j_ina_Cleats" }
        },
        banned_tags = {},
        banned_other = {},
    },
    deck = {
        type = 'Challenge Deck',
    },
}


local ff_bosses = { "bl_ina_wild", "bl_ina_brain", "bl_ina_otaku",
    "bl_ina_royal_blind", "bl_ina_shuriken",
    "bl_ina_farm", "bl_ina_kirkwood", "bl_ina_zeus" }

local elemental_bosses = { "bl_ina_fire", "bl_ina_forest", "bl_ina_mountain", "bl_ina_wind" }

local old_get_new_boss = get_new_boss

local get_next_boss_futbol_frontier = function()
    local boss = ff_bosses[G.GAME.boss_index]

    G.GAME.boss_index = G.GAME.boss_index + 1
    if G.GAME.boss_index > #ff_bosses then
        old_get_new_boss()
    end
    return boss
end

local reset_next_boss_index = function()
    if not G.GAME.boss_index then
        G.GAME.boss_index = 1
    end
end

local get_next_elemental_boss = function()
    return pseudorandom_element(elemental_bosses, 'Elemental_challenge')
end

function get_new_boss()
    if G.GAME.modifiers.ina_elementals then
        return get_next_elemental_boss()
    end

    if G.GAME.modifiers.ina_futbol_frontier then
        reset_next_boss_index()

        local boss = get_next_boss_futbol_frontier()

        return boss
    else
        return old_get_new_boss()
    end
end

return {
    name = "Challenge",
    list = { glasses_team, love_pair, futbol_frontier, elementals, more_or_less, mark_challenge, recruiter }
}
