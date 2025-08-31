local Consts = {
	max_quantity_small = 4,
	max_quantity_jumbo = 5,
	max_quantity_mega = 5,
	choose_small = 1,
	choose_jumbo = 1,
	choose_mega = 2,
	strats = 1,
	trainings = 1
}

local Growing_Pack = {
	name = "Growing Pack",
	key = "growing_pack",
	kind = "Team",
	atlas = "Boosters01",
	pos = { x = 0, y = 0 },
	config = { extra = Consts.max_quantity_small - 2, choose = Consts.choose_small, c_keys = {} },
	cost = 4,
	order = 1,
	weight = 0.35,
	draw_hand = false,
	unlocked = true,
	discovered = false,
	create_card = function(self, card, i)
		local selected_team = tostring(Pokerleven.get_random_team_from_actuals())

		return create_card(selected_team, G.pack_cards, nil, nil, true, true, nil, nil)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.choose, card.ability.extra } }
	end,
	group_key = "k_team_pack",
}

local Advanced_Pack = {
	name = "AdvancedPack",
	key = "advanced_pack",
	kind = "Team",
	atlas = "Boosters01",
	pos = { x = 1, y = 0 },
	config = { extra = Consts.max_quantity_jumbo - 1, choose = Consts.choose_jumbo, c_keys = {} },
	cost = 6,
	order = 1,
	weight = 0.15,
	draw_hand = false,
	unlocked = true,
	discovered = false,
	create_card = function(self, card, i)
		local selected_team = Pokerleven.get_random_team_from_actuals()

		return create_card(selected_team, G.pack_cards, nil, nil, true, true, nil, nil)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.choose, card.ability.extra } }
	end,
	group_key = "k_team_pack",
	in_pool = function(self, args)
		if G.GAME.round_resets.ante >= 3 then
			return true
		end
		return false
	end
}

local CARD_ORDER = {
	default = "Tarot",
	[Consts.max_quantity_small - 1] = C.STRAT,
	[Consts.max_quantity_small] = C.TRAINING,
}

local create_card_by_order = function(position_index)
	local card_type = CARD_ORDER[position_index] or CARD_ORDER.default
	if card_type == C.TRAINING then
		local selected_combination = Pokerleven.get_random_type_pos_held()

		return create_card(C.TRAINING, G.pack_cards, nil, nil, true, true,
			selected_combination, nil)
	end
	return create_card(card_type, G.pack_cards, nil, nil, true, true, nil, nil)
end

local Ina_Pack = {
	name = "Ina Pack",
	key = "item_pack_ina",
	kind = "Item",
	atlas = "Boosters01",
	pos = { x = 0, y = 3 },
	config = { extra = Consts.max_quantity_small, choose = Consts.choose_small },
	cost = 4,
	order = 1,
	weight = 1,
	draw_hand = true,
	unlocked = true,
	discovered = false,
	create_card = function(self, card, i)
		return create_card_by_order(i)
	end,
	loc_vars = function(self, info_queue, card)
		local tarots = Consts.max_quantity_small - Consts.strats - Consts.trainings
		return { vars = { card.ability.choose, tarots, Consts.strats, Consts.trainings } }
	end,
	group_key = "k_item_pack",
}

local Training_Pack = {
	name = "Training Pack",
	key = "training_pack",
	kind = "Item",
	atlas = "Boosters01",
	pos = { x = 0, y = 2 },
	config = { extra = Consts.max_quantity_small, choose = Consts.choose_small },
	cost = 4,
	order = 1,
	weight = 0.15,
	draw_hand = false,
	unlocked = true,
	discovered = false,
	create_card = function(self, card, i)
		return create_card(C.TRAINING, G.pack_cards, nil, nil, true, true, nil, nil)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.choose, Consts.max_quantity_small } }
	end,
	group_key = "k_item_pack",
}

local Jumbo_Training_Pack = {
	name = "Jumbo Training Pack",
	key = "jumbo_training_pack",
	kind = "Item",
	atlas = "Boosters01",
	pos = { x = 1, y = 2 },
	config = { extra = Consts.max_quantity_jumbo, choose = Consts.choose_jumbo },
	cost = 6,
	order = 1,
	weight = 0.07,
	draw_hand = false,
	unlocked = true,
	discovered = false,
	create_card = function(self, card, i)
		local selected_combination
		if i == 1 then
			selected_combination = Pokerleven.get_random_type_pos_held()
		end

		return create_card(C.TRAINING, G.pack_cards, nil, nil, true, true, selected_combination or nil, nil)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.choose, Consts.max_quantity_mega } }
	end,
	group_key = "k_item_pack",
}

local Mega_Training_Pack = {
	name = "Mega Training Pack",
	key = "mega_training_pack",
	kind = "Item",
	atlas = "Boosters01",
	pos = { x = 2, y = 2 },
	config = { extra = Consts.max_quantity_mega, choose = Consts.choose_mega },
	cost = 10,
	order = 1,
	weight = 0.01,
	draw_hand = false,
	unlocked = true,
	discovered = false,
	create_card = function(self, card, i)
		local selected_combination
		if i == 1 or i == 2 then
			selected_combination = Pokerleven.get_random_type_pos_held()
		end

		return create_card(C.TRAINING, G.pack_cards, nil, nil, true, true, selected_combination or nil, nil)
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.choose, Consts.max_quantity_mega } }
	end,
	group_key = "k_item_pack",
}

local excluded_keys = {}

local Manager_Pack = {
	name = "Manager Pack",
	key = "manager_pack",
	kind = "Manager",
	atlas = "Boosters01",
	pos = { x = 0, y = 1 },
	config = { extra = 2, choose = 1 },
	cost = 4,
	order = 1,
	weight = 0,
	draw_hand = false,
	unlocked = true,
	discovered = false,
	create_card = function(self, card, i)
		if i == 1 then
			excluded_keys = {}
			excluded_keys['j_ina_Akihiro'] = true
		end

		local selected_card = create_random_ina_joker('Manager_Pack', nil, Pokerleven.ina_manager_area, nil, false,
			"Manager",
			excluded_keys)
		excluded_keys[selected_card.config.center_key] = true
		return selected_card
	end,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.choose, card.ability.extra } }
	end,
	group_key = "k_manager_pack",
}

return {
	name = "Boosters01",
	list = { Growing_Pack, Advanced_Pack, Ina_Pack, Training_Pack, Jumbo_Training_Pack, Mega_Training_Pack, Manager_Pack }
}
