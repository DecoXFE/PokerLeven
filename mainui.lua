---@diagnostic disable: undefined-field
Pokerleven.ui = {}
ina_joker_page = 1

local get_upgrade_cards = function(key, card_area)
  local upgrade_cards = {}
  for i = 1, 6 do
    local added_card = SMODS.create_card({
      key = key,
      no_edition = true,
      area = card_area
    })
    if i > 1 then
      for _ = 0, i - 2 do
        increment_technique(added_card)
      end
    end
    table.insert(upgrade_cards, added_card)
  end
  return upgrade_cards
end

local get_form_cards = function(keys, card_area)
  local form_cards = {}
  for _, key in ipairs(keys) do
    local added_card = SMODS.create_card({
      key = key,
      no_edition = true,
      area = card_area
    })
    table.insert(form_cards, added_card)
  end
  return form_cards
end

local get_shadow_forms = function(key, card_area)
  local form_cards = {}
  local base_shadow = SMODS.create_card({
    key = key,
    no_edition = true,
    area = card_area
  })

  local clone_shadow = SMODS.create_card({
    key = key,
    no_edition = true,
    area = card_area
  })
  clone_shadow.ability.extra.clone = true

  table.insert(form_cards, base_shadow)
  table.insert(form_cards, clone_shadow)

  return form_cards
end

local get_teams_for_bobby = function(key, card_area)
  local form_cards = {}
  for team_name, team_table in pairs(C.CUSTOM.Bobby_Teams) do
    local added_card = SMODS.create_card({
      key = key,
      no_edition = true,
      area = card_area
    })
    added_card.children.center:set_sprite_pos({ x = team_table.x, y = team_table.y })
    added_card.ability.extra.pteam = team_name
    table.insert(form_cards, added_card)
  end
  return form_cards
end

Pokerleven.ui.create_card_area_to_area_table = function(card_number, area_table)
  local area_card_size = card_number < 8 and card_number or 8
  local card_area = CardArea(
    G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
    area_card_size * G.CARD_W,
    0.95 * G.CARD_H,
    { card_limit = area_card_size, type = 'title', highlight_limit = 0, collection = true })
  table.insert(area_table, card_area)
  Pokerleven.aux_tab_card_area = card_area
  return card_area
end

Pokerleven.ui.emplace_collection_in_area = function(cards, card_area)
  for _, card in ipairs(cards) do
    card_area:emplace(card)
  end
end

Pokerleven.ui.create_tab_from_card_area = function(card_area)
  return {
    n = G.UIT.ROOT,
    config = {
      align = "cm",
      padding = 0.05,
      colour = G.C.CLEAR,
    },
    nodes = {
      {
        n = G.UIT.R,
        config = {
          align = "cm",
          r = 0.2,
          padding = 0.5,
          minh = 4.5,
          colour = G.C.BLACK
        },
        nodes = {
          {
            n = G.UIT.O,
            config = {
              object = card_area,
            }
          },
        }
      }
    }
  }
end

Pokerleven.ui.create_tabs_menu = function(tabs, previous_menu)
  G.FUNCS.overlay_menu({
    definition = create_UIBox_generic_options({
      back_colour = G.C.ORANGE,
      back_func = previous_menu or 'exit_overlay_menu',
      contents = {
        {
          n = G.UIT.R,
          nodes = {
            create_tabs({
              snap_to_nav = true,
              colour = G.C.PALE_GREEN,
              tabs = tabs
            }),
          }
        },
      }
    })
  })
end

local function create_upgrade_tab_for_joker(key)
  Pokerleven.upgrades_area = {}
  if G.P_CENTERS[key].special ~= 'Manager' then
    return {
      label = localize("ina_training_upgrades"),
      chosen = true,
      tab_definition_function = function(t)
        local card_area = Pokerleven.ui.create_card_area_to_area_table(6, t.area_table)
        local card_upgrade_list = get_upgrade_cards(key, card_area)
        Pokerleven.ui.emplace_collection_in_area(card_upgrade_list, card_area)
        return Pokerleven.ui.create_tab_from_card_area(card_area)
      end,
      tab_definition_function_args = { area_table = Pokerleven.upgrades_area }
    }
  end
end

local function create_forms_tab_for_joker(key)
  Pokerleven.forms_area = {}
  local card_center = G.P_CENTERS[key]
  local keys_to_add = get_family_keys(card_center.name)

  if #keys_to_add > 1 or key == 'j_ina_Bobby' or key == 'j_ina_Shadow' then
    return {
      label = localize("ina_forms"),
      chosen = false,
      tab_definition_function = function(t)
        -- +4 to have a little more space
        local card_area
        if key == 'j_ina_Bobby' then
          card_area = Pokerleven.ui.create_card_area_to_area_table(C.CUSTOM.Bobby_Teams_Number, t.area_table)
          card_form_list = get_teams_for_bobby(key, card_area)
        elseif key == 'j_ina_Shadow' then
          card_area = Pokerleven.ui.create_card_area_to_area_table(2, t.area_table)
          card_form_list = get_shadow_forms(key, card_area)
        else
          card_area = Pokerleven.ui.create_card_area_to_area_table(#keys_to_add, t.area_table)
          card_form_list = get_form_cards(keys_to_add, card_area)
        end

        Pokerleven.ui.emplace_collection_in_area(card_form_list, card_area)
        return Pokerleven.ui.create_tab_from_card_area(card_area)
      end,
      tab_definition_function_args = { area_table = Pokerleven.forms_area }
    }
  end
end

local get_card_keys_from_team = function(team)
  local team_keys = {}
  for _, card in pairs(G.P_CENTERS) do
    if card.pteam == team then
      table.insert(team_keys, card.key)
    end
  end
  return team_keys
end

local function create_team_tab_for_joker(key)
  local card_center = G.P_CENTERS[key]
  local team_cards_keys = get_card_keys_from_team(card_center.pteam)

  return {
    label = localize('ina_team'),
    chosen = false,
    tab_definition_function = function(f)
      local card_area_nodes = {}
      G.your_collection = {}
      local rows = (#team_cards_keys > 4 and #team_cards_keys < 13) and math.ceil(#team_cards_keys / 4) or 3

      Pokerleven.ui.create_row_collection(rows, team_cards_keys, card_area_nodes)

      local tab_nodes = {}
      if #team_cards_keys <= 12 then
        tab_nodes = {
          { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = card_area_nodes }
        }
      else
        local joker_options = {}
        for i = 1, math.ceil(#team_cards_keys / (4 * #G.your_collection)) do
          table.insert(joker_options,
            localize('k_page') ..
            ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#team_cards_keys / (4 * #G.your_collection))))
        end
        tab_nodes = {
          { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = card_area_nodes },
          {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
              create_option_cycle({
                options = joker_options,
                w = 4.5,
                cycle_shoulders = true,
                opt_callback = 'your_collection_inazuma_team_page',
                current_option = 1,
                keys = team_cards_keys,
                colour = G.C.RED,
                no_pips = true,
                focus_args = { snap_to = true, nav = 'wide' }
              })
            }
          }
        }
      end

      return {
        n = G.UIT.ROOT,
        config = { align = "cm", colour = G.C.CLEAR },
        nodes = tab_nodes
      }
    end,
  }
end

Pokerleven.ui.create_row_collection = function(rows, card_keys, card_area_nodes)
  local marker = 1
  for i = 1, rows do
    G.your_collection[i] = Pokerleven.ui.create_card_area()
    table.insert(card_area_nodes, Pokerleven.ui.create_node_for_card_area(G.your_collection[i]))

    local lastcard = math.min(marker + 3, #card_keys)
    for j = marker, lastcard do
      local key = (type(card_keys[j]) == "table" and card_keys[j].key) or card_keys[j]
      local card = Card(G.your_collection[i].T.x + G.your_collection[i].T.w / 2, G.your_collection[i].T.y, G
        .CARD_W,
        G.CARD_H, nil, G.P_CENTERS[key])
      if type(card_keys[j]) == "table" then
        card.ability.extra.form = card_keys[j].form
        G.P_CENTERS[key]:set_sprites(card)
      end
      G.your_collection[i]:emplace(card)
    end
    marker = marker + 4
  end
end

Pokerleven.ui.create_card_area = function(size)
  size = size or 4
  return CardArea(
    G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
    size * G.CARD_W,
    0.95 * G.CARD_H,
    { card_limit = size, type = 'title', highlight_limit = 0, collection = true })
end

Pokerleven.ui.create_node_for_card_area = function(card_area)
  return {
    n = G.UIT.R,
    config = { align = "cm", padding = 0.07, no_fill = true },
    nodes = {
      { n = G.UIT.O, config = { object = card_area } }
    }
  }
end

G.FUNCS.your_collection_inazuma_team_page = function(args)
  if not args or not args.cycle_config then return end
  for j = 1, #G.your_collection do
    for i = #G.your_collection[j].cards, 1, -1 do
      local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
      c:remove()
      c = nil
    end
  end
  local row_start = 1 + (12 * (args.cycle_config.current_option - 1))
  for i = 1, 3 do
    for j = row_start, row_start + 3 do
      local akeys = args.cycle_config.keys
      local key = (type(akeys[j]) == "table" and akeys[j].key) or akeys[j]
      if not akeys[j] then break end
      local card = Card(G.your_collection[i].T.x + G.your_collection[i].T.w / 2, G.your_collection[i].T.y, G.CARD_W,
        G.CARD_H, nil, G.P_CENTERS[key])
      if type(akeys[j]) == "table" then
        card.ability.extra.form = akeys[j].form
        G.P_CENTERS[key]:set_sprites(card)
      end
      G.your_collection[i]:emplace(card)
    end
    row_start = row_start + 4
  end
  INIT_COLLECTION_CARD_ALERTS()
end

Pokerleven.ui.create_overlay_for_joker_properties = function(key, previous_menu)
  local tabs = {}

  local upgrade_tab = create_upgrade_tab_for_joker(key)
  local forms_tab = create_forms_tab_for_joker(key)
  local team_tab = create_team_tab_for_joker(key)

  table.insert(tabs, upgrade_tab)
  table.insert(tabs, forms_tab)
  table.insert(tabs, team_tab)

  if #tabs > 0 then
    Pokerleven.ui.create_tabs_menu(tabs, previous_menu)
  end
end

G.FUNCS.inadex_back = function()
  G.FUNCS.your_collection_jokers()
  G.FUNCS.SMODS_card_collection_page({ cycle_config = { current_option = ina_joker_page } })
  local page = G.OVERLAY_MENU:get_UIE_by_ID('cycle_shoulders').children[1].children[1]
  page.config.ref_table.current_option = ina_joker_page
  page.config.ref_table.current_option_val = page.config.ref_table.options[ina_joker_page]
end

local initialize_previous_menu = function()
  local menu = G.SETTINGS.paused and 'inadex_back' or nil
  if menu and G.OVERLAY_MENU:get_UIE_by_ID('cycle_shoulders') then
    ina_joker_page = G.OVERLAY_MENU:get_UIE_by_ID(
      'cycle_shoulders').children[1].children[1].config.ref_table.current_option
  end
  return menu
end

local controller_queue_R_cursor_press_ref = Controller.queue_R_cursor_press
function Controller:queue_R_cursor_press(x, y)
  controller_queue_R_cursor_press_ref(self, x, y)
  local clicked = self.hovering.target or self.focused.target
  if clicked and type(clicked) == 'table' and clicked.config and type(clicked.config) == 'table' and clicked.config.center and clicked.facing ~= 'back'
      and clicked.config.center.ptype then
    local menu = initialize_previous_menu()
    LeakScope.snap("close_bench")

    Pokerleven.ui.create_overlay_for_joker_properties(clicked.config.center_key, menu)
  end
end

local ina_capture_focused_input = Controller.capture_focused_input
function Controller:capture_focused_input(button, input_type, dt)
  if self.focused then
    local clicked = self.focused.target
    if input_type == 'press' and button == 'rightstick' then
      if clicked and type(clicked) == 'table' and clicked.config and type(clicked.config) == 'table' and clicked.config.center and clicked.facing ~= 'back' then
        if clicked.config.center.stage then
          local menu = G.SETTINGS.paused and 'inadex_back' or nil
          if menu and G.OVERLAY_MENU:get_UIE_by_ID('cycle_shoulders') then
            ina_joker_page = G.OVERLAY_MENU:get_UIE_by_ID(
              'cycle_shoulders').children[1].children[1].config.ref_table.current_option
          end
          G.SETTINGS.paused = true
          Pokerleven.ui.create_overlay_for_joker_properties(clicked.config.center_key, menu)
          self:update_focus()
        end
      end
    end
  end

  return ina_capture_focused_input(self, button, input_type, dt)
end

--#region Config tab

local restart_toggles_left = {
}

local restart_toggles_right = {
}
local no_restart_toggles = {
  { ref_value = "custom_middle_blinds",    label = "ina_settings_custom_middle_blinds" },
  { ref_value = "middle_blinds_abilities", label = "ina_settings_middle_blinds_abilities" }
}

local create_menu_toggles = function(parent, toggles)
  for k, v in ipairs(toggles) do
    parent.nodes[#parent.nodes + 1] = create_toggle({
      label = localize(v.label),
      ref_table = Pokerleven.config,
      ref_value = v.ref_value,
      callback = function(_set_toggle)
        NFS.write(mod_dir .. "/config.lua", STR_PACK(Pokerleven.config))
      end,
    })
    if v.tooltip then
      parent.nodes[#parent.nodes].config.detailed_tooltip = v.tooltip
    end
  end
end

pokerlevenconfig = function()
  local restart_left_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05, scale = 0.75, colour = G.C.CLEAR, }, nodes = {} }
  create_menu_toggles(restart_left_settings, restart_toggles_left)

  local restart_right_settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05, scale = 0.75, colour = G.C.CLEAR, }, nodes = {} }
  create_menu_toggles(restart_right_settings, restart_toggles_right)

  local no_restart_settings = { n = G.UIT.R, config = { align = "tm", padding = 0.05, scale = 0.75, colour = G.C.CLEAR, }, nodes = {} }
  create_menu_toggles(no_restart_settings, no_restart_toggles)

  local config_nodes =
  {
    {
      n = G.UIT.R,
      config = {
        padding = 0,
        align = "cm"
      },
      nodes = {
        {
          n = G.UIT.T,
          config = {
            text = "No restart required",
            shadow = true,
            scale = 0.75 * 0.8,
            colour = HEX("ED533A")
          }
        }
      },
    },
    no_restart_settings,
    {
      n = G.UIT.R,
      config = {
        padding = 0,
        align = "cm"
      },
      nodes = {
        {
          n = G.UIT.T,
          config = {
            text = "Requires restart",
            shadow = true,
            scale = 0.75 * 0.8,
            colour = HEX("ED533A")
          }
        }
      },
    },
    {
      n = G.UIT.R,
      config = {
        padding = 0,
        align = "tm"
      },
      nodes = { restart_left_settings, restart_right_settings },
    },
  }
  return config_nodes
end

SMODS.current_mod.config_tab = function()
  return {
    n = G.UIT.ROOT,
    config = {
      align = "cm",
      padding = 0.05,
      colour = G.C.CLEAR,
    },
    nodes = pokerlevenconfig()
  }
end

local function create_text_node(text, colour)
  local scale = 0.75
  return {
    n = G.UIT.T,
    config = {
      text = text,
      shadow = true,
      scale = scale * 0.8,
      colour = colour
    }
  }
end

local function create_text_row(text1, text2)
  local nodes = {
    create_text_node(text1, G.C.UI.TEXT_LIGHT)
  }

  if text2 and text2 ~= "" then
    table.insert(nodes, create_text_node(text2, G.C.BLUE))
  end

  return {
    n = G.UIT.R,
    config = {
      padding = 0,
      align = "cm"
    },
    nodes = nodes
  }
end

local create_credits_tab = function()
  return {
    n = G.UIT.ROOT,
    config = {
      align = "cm",
      padding = 0.3,
      colour = G.C.BLACK,
      r = 0.3
    },
    nodes = {
      create_text_row(localize('ina_thanks')),
      create_text_row(localize('ina_lead_developer'), C.CREDITS.lead),
      create_text_row(localize('ina_developers'), C.CREDITS.developers),
      create_text_row(localize('ina_graphic_designers'), C.CREDITS.graphic),
    }
  }
end

SMODS.current_mod.extra_tabs = function()
  return {
    label = localize("ina_credits"),
    tab_definition_function = create_credits_tab
  }
end

--#endregion
