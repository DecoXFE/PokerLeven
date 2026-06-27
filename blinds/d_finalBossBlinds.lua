local zeus_caido = B({
    object_type = "Blind",
    name = "ina-zeus_caido",
    key = "zeus_caido",
    pos = { x = 0, y = 1 },
    boss = {
        showdown = true,
    },
    config = { extra_percent = 0.15 },
    discovered = false,
    mult = 2,
    atlas = "finalBossBlinds",
    order = 1,
    boss_colour = HEX("ffa726"),
    collection_loc_vars = function(self)
        return {
            vars = {
                self.config.extra_percent * 100
            },
            key = self.key
        }
    end,
    loc_vars = function(self)
        return {
            vars = {
                self.config.extra_percent * 100
            },
            key = self.key
        }
    end,
    ina_credits = {
        art = { "Shadorossa" }
    },
    drawn_to_hand = function(self)
        G.GAME.blind.chips = G.GAME.blind.chips + G.GAME.blind.chips * self.config.extra_percent
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        play_sound('gong', 0.76, 1.2)
    end,
    in_pool = function(self)
        if G.GAME.round_resets.ante >= 16 then
            return true
        end
        return false
    end
})

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
                if G.GAME.hands[context.scoring_name].level > 1 then
                    blind.triggered = true
                    if not context.check then
                        local level_down = -G.GAME.hands[context.scoring_name].level + 1
                        return {
                            level_up = level_down
                        }
                    end
                end
            end
        end
    end
})

local genesis = B({
    object_type = "Blind",
    name = "Genesis",
    key = "Genesis",
    pos = { x = 0, y = 20 },
    boss = { showdown = true },
    discovered = false,
    mult = 2,
    atlas = "bossBlinds",
    order = 1,
    boss_colour = HEX("6B3FA0"),
    calculate = function(self, blind, context)
        if context.debuff_hand and not blind.disabled then
            for _, card in ipairs(context.full_hand) do
                if not card:is_face() then
                    blind.triggered = true
                    if not context.check then
                        return { debuff = true, debuff_text = "Only face cards!" }
                    end
                    return { debuff = true }
                end
            end
            blind.triggered = false
        end
    end,
    ina_credits = {
        art = { "Shadorossa" }
    }
})

return {
    name = "Boss Blinds",
    list = { zeus, zeus_caido, genesis }
}
