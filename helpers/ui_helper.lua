---@diagnostic disable: cast-local-type
ina_set_badges = function(self, card, badges)
    local pteam = get_team(card)
    local text_colour = G.C.WHITE
    if pteam then
        local lower_pteam = string.lower(pteam)
        local display_text = pteam
        if string.find(pteam, "^ina_team_") then
            display_text = localize(pteam)
        end
        badges[#badges + 1] = create_badge(display_text, G.ARGS.LOC_COLOURS[lower_pteam], text_colour, 1.2)
    end
end

type_tooltip = function(self, info_queue, center)
    local percent
    if center.ability.extra and type(center.ability.extra) == "table" and center.ability.extra.ptype then
        info_queue[#info_queue + 1] = { set = 'Other', key = center.ability.extra.ptype }
    end
    if center.ability.extra and type(center.ability.extra) == "table" and center.ability.extra.pposition then
        info_queue[#info_queue + 1] = { set = 'Other', key = center.ability.extra.pposition }
    end
end

apply_property_sticker = function(card, sticker_type, property)
    local inateam_list = { "Forest", "Fire", "Wind", "Mountain" }
    local inaposition_list = { "FW", "DF", "MF", "GK" }
    local apply_type = nil

    if sticker_type then
        apply_type = sticker_type
        card.ability[string.lower(apply_type) .. "_sticker"] = true
    else
        if property == "type" then
            options = {}
            for _, t in ipairs(inateam_list) do
                if t ~= card.ability.extra.ptype then
                    table.insert(options, t)
                end
            end
            apply_type = pseudorandom_element(options, pseudoseed("type"))
        elseif property == "position" then
            options = {}
            for _, p in ipairs(inaposition_list) do
                if p ~= card.ability.extra.pposition then
                    table.insert(options, p)
                end
            end
            apply_type = pseudorandom_element(options, pseudoseed("position"))
        end
        card.ability[string.lower(apply_type) .. "_sticker"] = true
    end

    if property == "type" then
        for _, v in pairs(inateam_list) do
            if string.lower(v) ~= string.lower(apply_type) then
                card.ability[string.lower(v) .. "_sticker"] = false
            end
        end
    end

    if property == "position" then
        for l, v in pairs(inaposition_list) do
            if string.lower(v) ~= string.lower(apply_type) then
                card.ability[string.lower(v) .. "_sticker"] = false
            end
        end
    end

    if property == "type" then
        if card.ability and card.ability.extra and type(card.ability.extra) == "table" and card.ability.extra.ptype then
            card.ability.extra.ptype = apply_type
        end
    end

    if property == "position" then
        if card.ability and card.ability.extra and type(card.ability.extra) == "table" and card.ability.extra.pposition then
            card.ability.extra.pposition = apply_type
        end
    end
end

-- CREDITS
local base_create_badges = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
    base_create_badges(obj, badges)

    if obj and obj.ina_credits then
        local function calc_scale_fac(text)
            local size = 0.9
            local font = G.LANG.font
            local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
            local calced_text_width = 0
            for _, c in utf8.chars(text) do
                ---@diagnostic disable-next-line: undefined-field
                local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
                    ---@diagnostic disable-next-line: undefined-field
                    + 2.7 * 1 * G.TILESCALE * font.FONTSCALE
                calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
            end
            return calced_text_width > max_text_width and max_text_width / calced_text_width or 1
        end

        local strings = { "Pokerleven" }

        if obj.ina_credits.idea then
            for i = 1, #obj.ina_credits.idea do
                localized = localize({ type = "variable", key = "ina_idea", vars = { obj.ina_credits.idea[i] } })[1]
                strings[#strings + 1] = localized
            end
        end

        if obj.ina_credits.art then
            for i = 1, #obj.ina_credits.art do
                localized = localize({ type = "variable", key = "ina_art", vars = { obj.ina_credits.art[i] } })[1]
                strings[#strings + 1] = localized
            end
        end

        if obj.ina_credits.code then
            for i = 1, #obj.ina_credits.code do
                localized = localize({ type = "variable", key = "ina_code", vars = { obj.ina_credits.code[i] } })[1]
                strings[#strings + 1] = localized
            end
        end

        local scale_fac = {}
        local min_scale_fac = 1
        for i = 1, #strings do
            scale_fac[i] = calc_scale_fac(strings[i])
            min_scale_fac = math.min(min_scale_fac, scale_fac[i])
        end

        local ct = {}
        for i = 1, #strings do
            ct[i] = { string = strings[i] }
        end

        local badge = {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        colour = G.C.RED,
                        r = 0.1,
                        minw = 2 / min_scale_fac,
                        minh = 0.36,
                        emboss = 0.05,
                        padding = 0.03 * 0.9,
                    },
                    nodes = {
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = ct,
                                    colours = { obj.ina_credits.text_colour or G.C.WHITE },
                                    silent = true,
                                    float = true,
                                    shadow = true,
                                    offset_y = -0.03,
                                    spacing = 1,
                                    scale = 0.33 * 0.9,
                                }),
                            },
                        },
                        { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                    },
                },
            },
        }

        badges[#badges] = badge
    end
end

--- Only Mod Blinds
local original_collection_pool = SMODS.collection_pool
SMODS.collection_pool = function(_base_pool)
    local result = original_collection_pool(_base_pool)

    local is_blinds_pool = (_base_pool == G.P_BLINDS)

    if is_blinds_pool then
        local filtered_result = {}
        for _, v in ipairs(result) do
            local is_mod = (type(v.mod) == "string" and (v.mod == "Pokerleven" or v.mod == "Multiplayer"))
                or (type(v.mod) == "table" and (v.mod.id == "Pokerleven" or v.mod.id == "Multiplayer"))
            if is_mod then
                filtered_result[#filtered_result + 1] = v
            end
        end
        return filtered_result
    else
        return result
    end
end

---Creates the UI for jokers in collection
---@return UINode node UI for jokers in collection
create_UIBox_your_collection_jokers = function()
    local filtered_jokers = {}
    for _, joker in ipairs(G.P_CENTER_POOLS.Joker) do
        if not joker.special and joker.ptype then
            table.insert(filtered_jokers, joker)
        end
    end
    return SMODS.card_collection_UIBox(filtered_jokers, { 5, 5, 5 }, {
        no_materialize = true,
        modify_card = function(card, center) card.sticker = get_joker_win_sticker(center) end,
        h_mod = 0.95,
    })
end

--#region Technique UI

---Creates the UI for additions in collection
---@param requirement string special requierment to filter on cards
---@return UINode node UI for additions in collection
create_UIBox_your_collection_addition = function(requirement)
    local filtered_jokers = {}
    for _, joker in ipairs(G.P_CENTER_POOLS.Joker) do
        if joker.special and joker.special == requirement then
            table.insert(filtered_jokers, joker)
        end
    end
    return SMODS.card_collection_UIBox(filtered_jokers, { 5, 5, 5 }, {
        no_materialize = true,
        modify_card = function(card, center) card.sticker = get_joker_win_sticker(center) end,
        h_mod = 0.95,
    })
end

G.FUNCS.your_collection_techniques = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
        definition = create_UIBox_your_collection_addition("Technique"),
    }
end

G.FUNCS.your_collection_managers = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu {
        definition = create_UIBox_your_collection_addition("Manager"),
    }
end

local old_modsCollectionTally = modsCollectionTally
modsCollectionTally = function(pool, ...)
    -- Si el pool es el de Jokers, filtramos antes
    if pool == G.P_CENTER_POOLS.Joker then
        local filtered_pool = {}
        for _, card in ipairs(pool) do
            if not (card.ability or card.special) then
                table.insert(filtered_pool, card)
            end
        end
        return old_modsCollectionTally(filtered_pool, ...)
    end

    -- Para el resto, comportamiento original
    return old_modsCollectionTally(pool, ...)
end

Pokerleven.Extra_Additions = { "Manager" }
local original_buildAdditionsTab = buildAdditionsTab
function buildAdditionsTab(mod)
    local tab = original_buildAdditionsTab(mod)
    if not tab then return nil end

    local insert_index = 2
    for _, addition in ipairs(Pokerleven.Extra_Additions) do
        local pool = {}
        for _, joker in ipairs(G.P_CENTER_POOLS.Joker) do
            if joker.special and joker.special == addition then
                table.insert(pool, joker)
            end
        end

        if #pool > 0 then
            local tally = modsCollectionTally(pool)
            if tally.of > 0 then
                local button_id = "your_collection_" .. string.lower(addition) .. "s"
                local label_key = "ina_special_" .. string.lower(addition)

                local addition_node = UIBox_button({
                    button = button_id,
                    label = { localize(label_key) },
                    count = tally,
                    minw = 5,
                    minh = 1.2,
                    scale = 0.6,
                    id = button_id
                })

                local tab_nodes = tab.tab_definition_function().nodes
                if tab_nodes and tab_nodes[1] and tab_nodes[1].nodes and tab_nodes[1].nodes[1] and tab_nodes[1].nodes[1].nodes then
                    table.insert(tab_nodes[1].nodes[1].nodes, insert_index, addition_node)
                    insert_index = insert_index + 1
                end
            end
        end
    end

    return tab
end

--#endregion

local can_select_card_ref = G.FUNCS.can_select_card
G.FUNCS.can_select_card = function(e)
    local card = e.config.ref_table
    if card.ability.set ~= 'Joker' then
        can_select_card_ref(e)
    elseif Pokerleven.is_manager(card) then
        if (card.edition and card.edition.negative) or
            #Pokerleven.ina_manager_area.cards < Pokerleven.ina_manager_area.config.card_limit then
            e.config.colour = G.C.GREEN
            e.config.button = 'use_card'
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    else
        can_select_card_ref(e)
    end
end

---Creates button ui for custom cards
---@param card Card Card you want to create buttons on
---@param args table Table of configs for creating custom buttons
---@return table
Pokerleven.create_custom_buttons = function(card, args)
    local args = args or {}
    local sell = nil
    local use = nil
    local bench = nil

    if args.sell then
        sell = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { ref_table = card, align = "cr", padding = 0.1, r = 0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card', handy_insta_action = "sell" },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "tm" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('b_sell'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm" },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = localize('$'), colour = G.C.WHITE, scale = 0.4, shadow = true } },
                                        { n = G.UIT.T, config = { ref_table = card, ref_value = 'sell_cost_label', colour = G.C.WHITE, scale = 0.55, shadow = true } }
                                    }
                                }
                            }
                        }
                    }
                },
            }
        }
    end
    if args.bench or args.unbench then
        bench = {
            n = G.UIT.C,
            config = { align = "cr" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {
                        ref_table = card,
                        align = "cr",
                        padding = 0.1,
                        r = 0.08,
                        minw = 1.25,
                        hover = true,
                        shadow = true,
                        colour = G.C.UI.BACKGROUND_INACTIVE,
                        one_press = true,
                        button = args.bench and 'bench_card' or 'unbench_card',
                        func = args.bench and 'can_bench_card' or 'can_unbench_card',
                        handy_insta_action = "use"
                    },
                    nodes = {
                        { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                        {
                            n = G.UIT.C,
                            config = { align = "cr" },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = { align = "cm", maxw = 1.25 },
                                    nodes = {
                                        { n = G.UIT.T, config = { text = args.bench and localize('ina_bench') or localize('ina_unbench'), colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true } }
                                    }
                                }
                            }
                        }
                    }
                },
            }
        }
    end

    return {
        n = G.UIT.ROOT,
        config = {
            align = "cr",
            padding = 0,
            colour = G.C.CLEAR
        },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = 0.15, align = 'cl' },
                nodes = {
                    sell and {
                        n = G.UIT.R,
                        config = { align = 'cl' },
                        nodes = { sell }
                    } or nil,
                    bench and {
                        n = G.UIT.R,
                        config = { align = 'cl' },
                        nodes = { bench }
                    } or nil
                }
            }
        }
    }
end

---Creates UI for type information
---@param card Card
---@return table
Pokerleven.get_type_ui = function(card)
    if Pokerleven.is_manager(card) then
        return {
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = { localize("ina_manager_info") },
                        colours = { G.ARGS.LOC_COLOURS["pink"] },
                        bump = true,
                        silent = true,
                        pop_in = 0,
                        pop_in_rate = 4,
                        maxw = 5,
                        shadow = true,
                        y_offset = 0,
                        spacing = math.max(0, 0.32 * (17 - #localize("ina_manager_info"))),
                        scale = (0.4 - 0.004 * #localize("ina_manager_info"))
                    })
                }
            }
        }
    end

    local type_text = localize("ina_" .. (card.ability.extra.ptype or "Fire"))
    local position_text = localize("ina_" .. (card.ability.extra.pposition or "FW"))
    local special_text = card.ability.extra.special and localize("ina_" .. card.ability.extra.special) or nil
    local full_text = type_text ..
        " / " .. position_text .. " / " .. (special_text or "")

    local type = {
        n = G.UIT.O,
        config = {
            object = DynaText({
                string = { type_text },
                colours = { G.ARGS.LOC_COLOURS[string.lower(card.ability.extra.ptype) or "fire"] },
                bump = true,
                silent = true,
                pop_in = 0,
                pop_in_rate = 4,
                maxw = 5,
                shadow = true,
                y_offset = 0,
                spacing = math.max(0, 0.32 * (17 - #full_text)),
                scale = (0.4 - 0.004 * #full_text)
            })
        }
    }

    local position = {
        n = G.UIT.O,
        config = {
            object = DynaText({
                string = { position_text },
                colours = { G.ARGS.LOC_COLOURS[string.lower(card.ability.extra.pposition) or "fw"] },
                bump = true,
                silent = true,
                pop_in = 0,
                pop_in_rate = 4,
                maxw = 5,
                shadow = true,
                y_offset = 0,
                spacing = math.max(0, 0.32 * (17 - #full_text)),
                scale = (0.4 - 0.004 * #full_text)
            })
        }
    }

    local special
    if special_text then
        special = {
            n = G.UIT.O,
            config = {
                object = DynaText({
                    string = { special_text },
                    colours = { G.ARGS.LOC_COLOURS["pink"] },
                    bump = true,
                    silent = true,
                    pop_in = 0,
                    pop_in_rate = 4,
                    maxw = 5,
                    shadow = true,
                    y_offset = 0,
                    spacing = math.max(0, 0.32 * (17 - #full_text)),
                    scale = (0.4 - 0.004 * #full_text)
                })
            }
        }
    end

    local separator = {
        n = G.UIT.T,
        config = {
            text = " / ",
            colour = G.C.UI.TEXT_LIGHT,
            scale = (0.4 - 0.004 * #full_text)
        }
    }
    return {
        type,
        separator,
        position,
        special and separator or nil,
        special,
    }
end


---Generates Joker's description UI. This is done to add:
---* Type information under names
---* Some tooltips to info_queue automatically
---@param self table
---@param info_queue table
---@param card Card
---@param desc_nodes table
---@param specific_vars table
---@param full_UI_table table
Pokerleven.generate_info_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

    if desc_nodes == full_UI_table.main then
        -- Add type information under names
        full_UI_table.name = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = full_UI_table.name
                    },
                    {
                        n = G.UIT.R,
                        config = { align = "cm" },
                        nodes = Pokerleven.get_type_ui(card)
                    },
                }
            }
        }
    end
end

-- Main menu (Stolen from Cryptid)
local game_main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
    local ret = game_main_menu_ref(self, change_context)

    G.SPLASH_BACK:define_draw_steps({
        {
            shader = "splash",
            send = {
                { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", val = 0.4 },
                { name = "colour_1",   val = HEX("5A00FF"),  ref_value = "EFFECT" },
                { name = "colour_2",   ref_table = G.C,      ref_value = "BLACK" },
            },
        },
    })

    return ret
end
