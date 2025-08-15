local debuff_position = function(pposition)
    if G.GAME.blind.prepped then
        for _, y in pairs(G.jokers.cards) do
            y:set_debuff(false)
        end
        for _, v in pairs(G.jokers.cards) do
            if v.ability.extra.pposition == pposition then
                v:set_debuff(true)
                v:juice_up()
                G.GAME.blind:wiggle()
            end
        end
    end
end

local debuff_type = function(ptype)
    if G.GAME.blind.prepped then
        for _, y in pairs(G.jokers.cards) do
            y:set_debuff(false)
        end

        local blazer_index
        for i, v in pairs(G.jokers.cards) do
            if v.config.center_key == 'j_ina_Blazer' then
                blazer_index = i
            elseif v.ability.extra.ptype == ptype then
                v:set_debuff(true)
                v:juice_up()
                G.GAME.blind:wiggle()
            end
        end
        if blazer_index then
            G.jokers.cards[blazer_index]:set_debuff(true)
            G.jokers.cards[blazer_index]:juice_up()
            G.GAME.blind:wiggle()
        end
    end
end


local goalkeeper = {
    object_type = "Blind",
    name = "ina-goalkeeper",
    key = "goalkeeper",
    pos = { x = 0, y = 3 },
    boss = {
        min = 4,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("ffa726"),
    press_play = function(self)
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end,
    drawn_to_hand = function(self)
        debuff_position("GK")
    end,
    disable = function(self)
        self.config.disabled = true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local forward = {
    object_type = "Blind",
    name = "ina-forward",
    key = "forward",
    pos = { x = 0, y = 0 },
    boss = {
        min = 4,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("4fc3f7"),
    press_play = function(self)
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end,
    drawn_to_hand = function(self)
        debuff_position("FW")
    end,
    disable = function(self)
        self.config.disabled = true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local defense = {
    object_type = "Blind",
    name = "ina-defense",
    key = "defense",
    pos = { x = 0, y = 2 },
    boss = {
        min = 4,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("ef5350"),
    press_play = function(self)
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end,
    drawn_to_hand = function(self)
        debuff_position("DF")
    end,
    disable = function(self)
        self.config.disabled = true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local midfielder = {
    object_type = "Blind",
    name = "ina-midfielder",
    key = "midfielder",
    pos = { x = 0, y = 1 },
    boss = {
        min = 4,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("66bb6a"),
    press_play = function(self)
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end,
    drawn_to_hand = function(self)
        debuff_position("MF")
    end,
    disable = function(self)
        self.config.disabled = true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local fire = {
    object_type = "Blind",
    name = "ina-fire",
    key = "fire",
    pos = { x = 0, y = 4 },
    boss = {
        min = 4,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("d32f2f"),
    press_play = function(self)
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end,
    drawn_to_hand = function(self)
        debuff_type("Fire")
    end,
    disable = function(self)
        self.config.disabled = true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local mountain = {
    object_type = "Blind",
    name = "ina-mountain",
    key = "mountain",
    pos = { x = 0, y = 7 },
    boss = {
        min = 4,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("f57c00"),
    press_play = function(self)
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end,
    drawn_to_hand = function(self)
        debuff_type("Mountain")
    end,
    disable = function(self)
        self.config.disabled = true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local wind = {
    object_type = "Blind",
    name = "ina-wind",
    key = "wind",
    pos = { x = 0, y = 5 },
    boss = {
        min = 4,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("81d4fa"),
    press_play = function(self)
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end,
    drawn_to_hand = function(self)
        debuff_type("Wind")
    end,
    disable = function(self)
        self.config.disabled = true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local forest = {
    object_type = "Blind",
    name = "ina-forest",
    key = "forest",
    pos = { x = 0, y = 6 },
    boss = {
        min = 4,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("2e7d32"),
    press_play = function(self)
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end,
    drawn_to_hand = function(self)
        debuff_type("Forest")
    end,
    disable = function(self)
        self.config.disabled = true
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
}

local inazuma_og = {
    object_type = "Blind",
    name = "Inazuma Eleven",
    key = "inazuma_og",
    pos = { x = 0, y = 8 },
    boss = {
        min = 0,
    },
    discovered = false,
    mult = 1,
    atlas = "bossBlinds",
    order = 1,
    debuff = { h_size_ge = 5 },
    boss_colour = HEX("ffa726"),
}

local royal_blind = {
    object_type = "Blind",
    name = "Royal Academy",
    key = "royal_blind",
    pos = { x = 0, y = 9 },
    boss = {
        min = 1,
    },
    discovered = false,
    mult = 1.25,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("2e7d32"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
                ease_hands_played(-G.GAME.blind.hands_sub)
            end
        end
    end,
    disable = function(self)
        ease_hands_played(G.GAME.blind.hands_sub)
    end
}

local wild = B({
    object_type = "Blind",
    name = "Wild",
    key = "wild",
    pos = { x = 0, y = 10 },
    boss = {
        min = 2,
    },
    discovered = false,
    mult = 1,
    atlas = "bossBlinds",
    order = 1,
    recalc_debuff = function(self, card, from_blind)
        if SMODS.has_enhancement(card, "m_wild") then
            return true
        end
    end,
    boss_colour = HEX("797B49"),
})

local brain = {
    object_type = "Blind",
    name = "Brain",
    key = "brain",
    pos = { x = 0, y = 11 },
    boss = {
        min = 1,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("888888"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                blind.prepped = true
            end
            if context.stay_flipped and context.to_area == G.hand and blind.prepped then
                return {
                    stay_flipped = true
                }
            end
        end
        if context.setting_blind or context.hand_drawn then
            blind.prepped = nil
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end
}

local otaku = {
    object_type = "Blind",
    name = "Otaku",
    key = "otaku",
    pos = { x = 0, y = 12 },
    boss = {
        min = 2,
    },
    discovered = false,
    debuff = { is_face = 'face' },
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("A754C4"),
}

local shuriken = {
    object_type = "Blind",
    name = "Shuriken",
    key = "shuriken",
    pos = { x = 0, y = 13 },
    boss = {
        min = 2,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("4B0082"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.press_play then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        for i = 1, #G.play.cards do
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.play.cards[i]:juice_up()
                                    return true
                                end,
                            }))
                            ease_dollars(-1)
                            delay(0.23)
                        end
                        return true
                    end
                }))
                blind.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = (function()
                        SMODS.juice_up_blind()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound('tarot2', 0.76, 0.4)
                                return true
                            end
                        }))
                        play_sound('tarot2', 1, 0.4)
                        return true
                    end)
                }))
                delay(0.4)
            end
        end
    end
}

local farm = {
    object_type = "Blind",
    name = "Farm",
    key = "farm",
    pos = { x = 0, y = 14 },
    boss = {
        min = 2,
    },
    discovered = false,
    mult = 4,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("7AC943"),
}

local kirkwood = {
    object_type = "Blind",
    name = "Kirkwood",
    key = "kirkwood",
    pos = { x = 0, y = 15 },
    boss = {
        min = 2,
    },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("7A5E3C"),
    loc_vars = function(self)
        local numerator, denominator = SMODS.get_probability_vars(self, 1, 7, 'vremade_wheel')
        return { vars = { numerator, denominator } }
    end,
    collection_loc_vars = function(self)
        return { vars = { '1' } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                SMODS.pseudorandom_probability(blind, 'vremade_wheel', 1, 7) then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end
}

local zeus = B({
    object_type = "Blind",
    name = "Zeus",
    key = "zeus",
    pos = { x = 0, y = 0 },
    boss = { showdown = true },
    discovered = false,
    mult = 2,
    atlas = "finalBossBlinds",
    order = 1,
    boss_colour = HEX("ffa726"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_hand then
                blind.triggered = false
                if G.GAME.hands[context.scoring_name].level > to_big(1) then
                    blind.triggered = true
                    if not context.check then
                        local level_down = -G.GAME.hands[context.scoring_name].level + 1
                        return {
                            level_up = lenient_bignum(level_down)
                        }
                    end
                end
            end
        end
    end
})

return {
    name = "Boss Blinds",
    list = { goalkeeper, forward, defense,
        midfielder, fire, mountain, wind,
        forest, inazuma_og, royal_blind, wild,
        brain, otaku, shuriken, farm,
        kirkwood, zeus }
}
