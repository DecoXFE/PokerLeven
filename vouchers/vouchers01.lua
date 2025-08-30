local ex_law = V({
    key = "ex_law",
    atlas = "vouchers01",
    order = 33,
    set = "Voucher",
    pos = { x = 0, y = 0 },
    config = { extra = { percent = 5 } },
    discovered = false,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = { self.config.extra.percent } }
    end,
    ina_credits = {
        art = { 'Shadorossa' },
        idea = { 'Shadorossa' }
    },
    calculate = function(self, card, context)
        if context.setting_blind then
            apply_team_discount_to_blind(self.config.extra.percent)
        end
    end
})

local ex_law_2 = V({
    key = "ex_law_2",
    atlas = "vouchers01",
    order = 33,
    set = "Voucher",
    pos = { x = 0, y = 1 },
    config = { extra = { percent = 5 } },
    discovered = false,
    unlocked = false,
    available = true,
    requires = { "v_ina_ex_law_2" },
    cost = 10,
    loc_vars = function(self, info_queue)
        return { vars = { self.config.extra.percent } }
    end,
    ina_credits = {
        art = { 'Shadorossa' },
        idea = { 'Shadorossa' }
    },
    check_for_unlock = function(self, args)
        if args.type == "ex_law" then
            unlock_card(self)
        end
    end
})

local training = V({
    key = "training",
    atlas = "vouchers01",
    order = 33,
    set = "Voucher",
    pos = { x = 1, y = 0 },
    discovered = false,
    unlocked = true,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return {}
    end,
    ina_credits = {
        art = { 'Shadorossa' },
        idea = { 'Shadorossa' }
    },
    redeem = function(self, card)
        G.GAME.max_tech_level = G.GAME.max_tech_level + 1
    end
})

local training_2 = V({
    key = "training_2",
    atlas = "vouchers01",
    order = 33,
    set = "Voucher",
    pos = { x = 1, y = 1 },
    discovered = false,
    unlocked = false,
    available = true,
    requires = { "v_ina_training" },
    cost = 10,
    loc_vars = function(self, info_queue)
        return {}
    end,
    ina_credits = {
        art = { 'Shadorossa' },
        idea = { 'Shadorossa' }
    },
    redeem = function(self, card)
        G.GAME.max_tech_level = G.GAME.max_tech_level + 1
    end,
    check_for_unlock = function(self, args)
        if args.type == "n4_upgraded" then
            unlock_card(self)
        end
    end
})

local managers_1 = V({
    key = "managers_1",
    atlas = "vouchers01",
    order = 33,
    set = "Voucher",
    pos = { x = 2, y = 0 },
    discovered = false,
    unlocked = false,
    available = true,
    cost = 10,
    loc_vars = function(self, info_queue)
        return {}
    end,
    redeem = function(self, card)
        Pokerleven.ina_manager_area.config.card_limit = Pokerleven.ina_manager_area.config.card_limit + 1
    end
})

local managers_2 = V({
    key = "managers_2",
    atlas = "vouchers01",
    order = 33,
    set = "Voucher",
    pos = { x = 2, y = 1 },
    discovered = false,
    unlocked = false,
    available = true,
    requires = { "v_ina_managers_1" },
    cost = 10,
    loc_vars = function(self, info_queue)
        return {}
    end,
    redeem = function(self, card)
        Pokerleven.ina_manager_area.config.card_limit = Pokerleven.ina_manager_area.config.card_limit + 1
    end
})

return {
    name = "Vouchers01",
    list = { ex_law, ex_law_2, training, training_2, managers_1, managers_2 }
}
