---@diagnostic disable: assign-type-mismatch
-- Multipliers for  technique upgrades
technique_values = {
    money = .6,
    mult_mod = .2,
    mult_mod_low = 1,
    chip_mod = .2,
    chips_mod = .2,
    Xmult_mod = .2,
    Xchip_mod = .2,
    Xchips_mod = .2,
    sell_mod = .6,       -- es de Seller
    sell_potential = .6, -- es de Seller
    current_Xmult = .2,
    current_xmult = .2,
    current_chips = .2,
    current_mult = .2,
    new_glass_denom = .2,
    xmult_mod = .2,
    xmult = .2,
    drain = .2,
    odds = -.05,
    sell_value = .2,
    common_mult = .2,    -- es de Martin
    uncommon_mult = .2,  -- es de Martin
    rare_xmult = .1,     -- es de Martin
    legendary_exp = .05, -- es de Martin
    copies_number = .25, -- es de Hattori
    alt_chips_mod = .2,
    byron_mult_fw = .2,
    byron_mult_mf = .2,
    perish_tally = 1,    -- Cloak
    extra_back_size = 1, -- Mark Evans
    cooldown_base = -0.2,
    current_cooldown = -0.2,
    evolving_retriggers = 1,
    card_count1 = 1,
    odds4 = -0.1499,
    odds2 = -0.1
}

local roundable_fields = {
    money = true,
    mult_mod = true,
    mult_mod_low = true,
    chip_mod = true,
    copies_number = true,
    cooldown_base = true,
    current_cooldown = true,
}


-- List of stickers depending of technique type
plus_stickers = { "ina_tech_plus1_sticker", "ina_tech_plus2_sticker", "ina_tech_plus3_sticker", "ina_tech_plus4_sticker",
    "ina_tech_plus5_sticker" }

number_stickers = { "ina_tech_number2_sticker", "ina_tech_number3_sticker", "ina_tech_number4_sticker" }

grade_stickers = { "ina_tech_grade2_sticker", "ina_tech_grade3_sticker", "ina_tech_grade4_sticker",
    "ina_tech_grade5_sticker",
    "ina_tech_grade0_sticker" }

new_stickers = { "ina_tech_j_sticker", "ina_tech_q_sticker", "ina_tech_k_sticker", "ina_tech_a_sticker",
    "ina_tech_joker_sticker" }


local function get_technique_sticker_list(card)
    if not card or not card.ability or type(card.ability) ~= "table" or not card.ability.extra then
        return new_stickers -- fallback seguro
    end

    local this_card_number_stickers = Pokerleven.clone_table(number_stickers)
    table.insert(this_card_number_stickers, card.ability.extra.numberTechType or C.UPGRADES.NumberType.A)
    table.insert(this_card_number_stickers, "ina_tech_numberinf_sticker")

    local sticker_map = {
        plus = plus_stickers,
        number = this_card_number_stickers,
        grade = grade_stickers
    }

    return sticker_map[card.ability.extra.techtype] or new_stickers
end

function set_sticker(card)
    local tech_level = card.ability.extra and card.ability.extra.tech_level or 0
    local sticker_list = get_technique_sticker_list(card)

    if tech_level > 1 then
        local old_sticker_key = sticker_list[tech_level - 1]
        if old_sticker_key and card.ability then
            card.ability[old_sticker_key] = false
        end
    end
    if tech_level >= 1 then
        local new_sticker_key = sticker_list[tech_level]
        if new_sticker_key and card.ability then
            card.ability[new_sticker_key] = true
        end
    end
end

function clear_stickers(card)
    local technique_sticker_list = get_technique_sticker_list(card)
    if not card or not card.ability or type(card.ability) ~= "table" then
        return
    end
    for _, sticker_key in ipairs(technique_sticker_list) do
        if card.ability[sticker_key] then
            card.ability[sticker_key] = false
        end
    end

    for _, sticker_key in ipairs(C.STICKERS.types) do
        if card.ability[sticker_key] then
            card.ability[sticker_key] = false
        end
    end

    for _, sticker_key in ipairs(C.STICKERS.positions) do
        if card.ability[sticker_key] then
            card.ability[sticker_key] = false
        end
    end
end

-- Increments technique level of a joker and applies stat changes based on technique values
increment_technique = function(card)
    if card.ability.extra and type(card.ability.extra) == "table" then
        if card.ability.extra.tech_level then
            card.ability.extra.tech_level = card.ability.extra.tech_level + 1
        else
            card.ability.extra.tech_level = 1
        end
    end
    modify_values(card)
    set_sticker(card)

    if card.ability.extra.tech_level == 4
        and G.STAGE == G.STAGES.RUN and
        not (Pokerleven.aux_tab_card_area and Pokerleven.aux_tab_card_area.cards) then
        check_for_unlock({ type = 'n4_upgraded' })
    end

    if card.ability.extra.extra_back_size and G.STAGE == G.STAGES.RUN
        and not (Pokerleven.aux_tab_card_area and Pokerleven.aux_tab_card_area.cards) then
        G.hand.config.card_limit = G.hand.config.card_limit + 1
    end
end

-- Applies value updates to a joker based on its center config and technique multipliers
modify_values = function(card)
    for name, _ in pairs(technique_values) do
        local data = card.ability.extra[name]
        if type(data) == "number" then
            local addition = technique_values[name]

            card.ability.extra[name] = data + (card.config.center.config.extra[name] * addition)

            updated_mod = card.ability.extra[name]
            rounded, frac = round_value(card.ability.extra[name], name)
            card.ability.extra[name] = rounded

            if frac then
                set_frac(card, frac, name)
            end
            frac = nil
        end
    end
end


-- Rounds a stat value based adn returns the integer part and fractional part (if applicable)
round_value = function(value, field)
    local frac
    local rounded

    if roundable_fields[field] then
        rounded, frac = math.modf(value)
    else
        rounded = value
    end

    return rounded, frac
end


-- Stores and manages fractional values for a joker's stat field
-- Converts to full stat point when fraction reaches 1.0+
set_frac = function(card, frac, field)
    local frac_name = field .. "_frac"
    if card.ability[frac_name] then
        card.ability[frac_name] = card.ability[frac_name] + frac
    else
        card.ability[frac_name] = frac
    end
    if card.ability[frac_name] >= 1 then
        local int_part, remaining_frac = math.modf(card.ability[frac_name])
        card.ability.extra[field] = card.ability.extra[field] + int_part
        card.ability[frac_name] = remaining_frac
    end
end

-- Returns true if the card matches the type and position and its technique level is below the max
can_upgrade_tech_level = function(card, type, position)
    if type and position then
        return is_type(card, type) and is_position(card, position) and
            (card.ability.extra.tech_level or 0) < G.GAME.max_tech_level
    else
        return (card.ability.extra.tech_level or 0) < G.GAME.max_tech_level
    end
end
