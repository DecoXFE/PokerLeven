-- local glass_shader = {
-- 	object_type = "Shader",
-- 	key = "glass",
-- 	path = "glass.fs"
-- }

-- local apply_shader = function ()
--   SMODS.Shader(glass_shader)
-- end

-- local glass_edition = {
-- 	object_type = "Edition",
-- 	key = "glass",
-- 	order = 4,
-- 	shader = "glass",
-- 	in_shop = false,
-- 	disable_base_shader = true,
-- 	disable_shadow = true,
-- 	discovered = true,
-- 	on_apply = function(card)
-- 		card.edition.ina_glass_seed = pseudorandom("e_ina_glass") * 2 - 1
-- 	end,
-- 	sound = {
-- 		sound = "glass1",
-- 		per = 1,
-- 		vol = 0.3,
-- 	},
-- 	weight = 7,
-- 	extra_cost = 3,
-- 	config = { retriggers = 1, shatter_chance = 8, trigger = nil },
-- 	loc_vars = function(self, info_queue, card)
-- 		return {
-- 			vars = {
-- 				(G.GAME.probabilities.normal),
-- 				(card and card.edition and card.edition.shatter_chance or self.config.shatter_chance),
-- 				card.edition.retriggers
-- 			},
-- 		}
-- 	end,
-- 	calculate = function(self, card, context)
-- 		-- Parte 1: RETRIGGER
-- 		if context.other_card == card
-- 			and (
-- 				(context.repetition and context.cardarea == G.play)
-- 				or (context.retrigger_joker_check and not context.retrigger_joker)
-- 			)
-- 		then
-- 			card.ability.extra.triggered = true

-- 			return {
-- 				message = localize("k_again_ex"),
-- 				repetitions = (card and card.edition and card.edition.retriggers or self.config.retriggers),
-- 				card = card,
-- 			}
-- 		end

-- 		if context.cardarea == G.jokers
-- 			and context.post_trigger
-- 			and context.other_card == card then
-- 			local chance = G.GAME.probabilities.normal / self.config.shatter_chance
-- 			if pseudorandom(pseudoseed("glass_break")) < chance then
-- 				card.ability.extra.marked_to_break = true
-- 			end
-- 			return { nil, true }
-- 		end

-- 		if context.destroying_card and card.ability.extra.marked_to_break then
-- 			G.E_MANAGER:add_event(Event({
-- 				func = function()
-- 					play_sound("glass" .. math.random(1, 6), math.random() * 0.2 + 0.9, 0.5)
-- 					card.states.drag.is = true
-- 					G.E_MANAGER:add_event(Event({
-- 						trigger = "after",
-- 						delay = 0.3,
-- 						blockable = false,
-- 						func = function()
-- 							G.jokers:remove_card(card)
-- 							card:remove()
-- 							card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
-- 							card = nil
-- 							return true
-- 						end,
-- 					}))
-- 					return true
-- 				end,
-- 			}))
-- 			return { remove = true }
-- 		end
-- 	end,
-- }

-- === Register the Shader ===
local function register_shaders()
    SMODS.Shader({
        key = 'lethal', path = 'lethal.fs'
    })

    SMODS.Shader({
        key = 'astral', path = 'astral.fs'
    })
end

-- === Register the Edition ===
local lethal = {
    key = "lethal",
    disable_shadow = false,
    disable_base_shader = true,
    shader = "lethal",
    discovered = false,
    unlocked = false,
    in_shop = false,
    weight = 8,
    extra_cost = 6,
    apply_to_float = false,
    config = { e_mult = 1.1, trigger = nil },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.edition and card.edition.e_mult or self.config.e_mult
            }
        }
    end,

    calculate = function(self, card, context)
        local emult = card and card.edition and card.edition.e_mult or self.config.e_mult

        if (context.edition and context.cardarea == G.jokers and card.config.trigger)
            or (context.main_scoring and context.cardarea == G.play) then
            return {
                mult = (mult ^ emult) - mult,
                remove_default_message = true,
                extra = {
                    message = localize {
                        type = "variable",
                        key = "ina_a_powmult",
                        vars = { number_format(emult) }
                    },
                    colour = G.C.UI.TEXT_DARK,
                    text_colour = G.C.MULT
                }
            }
        end

        if context.joker_main then
            card.config.trigger = true
        end

        if context.after then
            card.config.trigger = nil
        end
    end
}


local astral = {
    key = "astral",
    disable_shadow = false,
    disable_base_shader = true,
    shader = "astral",
    discovered = false,
    unlocked = false,
    in_shop = true,
    weight = 7,
    extra_cost = 4,
    apply_to_float = false,
    config = { x_chips = 1.5, trigger = nil },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card and card.edition and card.edition.x_chips or self.config.x_chips
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.edition and context.cardarea == G.jokers and card.config.trigger)
            or (context.main_scoring and context.cardarea == G.play) then
            return {
                x_chips = card and card.edition and card.edition.x_chips or self.config.x_chips,
                remove_default_message = true,
                extra = {
                    message = localize {
                        type = 'variable',
                        key = 'ina_a_xchips',
                        vars = { card and card.edition and card.edition.x_chips or self.config.x_chips }
                    },
                    colour = G.C.CHIPS
                }
            }
        end

        if context.joker_main then
            card.config.trigger = true
        end

        if context.after then
            card.config.trigger = nil
        end
    end
}

return {
	name = "Editions",
	init = register_shaders,
	list = {astral, lethal}
}
