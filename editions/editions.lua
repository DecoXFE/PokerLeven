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
SMODS.Shader({
    key = 'lethal', path = 'lethal.fs'
})

-- === Register the Edition ===
SMODS.Edition({
    key = "lethal",
    loc_txt = {
        name = "Letal",
        label = "Letal",
        text = { "{X:dark_edition,C:white}^1.1{} Multi",
        "{C:inactive}no se pueden aplicar tarots o espectrales",
        "{C:inactive}no pueden ser destrozadas o duplicadas{} ." }
    },
    disable_shadow = false,
    disable_base_shader = true,
    shader = "lethal",
    discovered = false,
    unlocked = false,
    in_shop = false,
    weight = 8,
    extra_cost = 6,
    apply_to_float = true,
    config = {},
    loc_vars = function(self)
        return { vars = {} }
    end
})

return{
	name = "Editions",
--	init = apply_shader(),
	list = {lethal}
}
