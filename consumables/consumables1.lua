local tech_book = {
  name = "tech_book",
  key = "tech_book",
  set = "Strat",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 0, y = 0 },
  atlas = "Consumables",
  cost = 5,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return #G.jokers.cards > 0
  end,
  use = function(self, card, area, copier)
    local choice = nil
    if (G.jokers.highlighted and #G.jokers.highlighted == 1) or
        (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1) then
      choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]
    elseif G.jokers.cards and #G.jokers.cards > 0 then
      choice = G.jokers.cards[1]
    else
      return
    end
    apply_property_sticker(choice, nil, "type")
    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_training"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local tactic_pos = {
  name = "tactic_pos",
  key = "tactic_pos",
  set = "Strat",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 1, y = 0 },
  atlas = "Consumables",
  cost = 5,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return #G.jokers.cards > 0
  end,
  use = function(self, card, area, copier)
    local choice = nil
    if (G.jokers.highlighted and #G.jokers.highlighted == 1) or
        (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1) then
      choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]
    elseif G.jokers.cards and #G.jokers.cards > 0 then
      choice = G.jokers.cards[1]
    else
      return
    end
    apply_property_sticker(choice, nil, "position")
    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_training"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local divine_water = {
  name = "Divine Water",
  key = "divine_water",
  set = "Spectral",
  pos = { x = 2, y = 0 },
  atlas = "Consumables",
  cost = 10,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
          (G.jokers.highlighted and #G.jokers.highlighted == 1) or
          (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
        ) and can_upgrade_tech_level(G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1])
        and
        ((G.jokers.highlighted[1] and not G.jokers.highlighted[1].ability.eternal)
          or (Pokerleven.ina_bench_area.highlighted[1] and not Pokerleven.ina_bench_area.highlighted[1].ability.eternal))
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    for _ = choice.ability.extra.tech_level or 0, 4 do
      increment_technique(choice)
    end

    choice.ability.perishable = true
    choice.ability.perish_tally = 5

    check_for_unlock({ type = "ray_dark" })
    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end
}

local black_room = {
  name = "Black Room",
  key = "black_room",
  set = "Spectral",
  pos = { x = 6, y = 1 },
  atlas = "upgrade_techniques",
  cost = 10,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1])
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)
    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end
}

local centella = {
  name = "Centro Centella",
  key = "centella",
  set = "Spectral",
  pos = { x = 1, y = 2 },
  atlas = "upgrade_techniques",
  cost = 10,
  unlocked = true,
  hidden = true,
  soul_set = "Training",
  soul_rate = .01,
  discovered = false,
  can_use = function(self, card)
    return #G.jokers.cards > 0
  end,
  use = function(self, card, area, copier)
    for _, player in ipairs(G.jokers.cards) do
      increment_technique(player)
    end

    card_eval_status_text(card, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end
}

local upgrade_technique_Wind_FW = {
  name = "upgrade_technique_Wind_FW",
  key = "upgrade_technique_Wind_FW",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 0, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Wind",
      "FW"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Fire_FW = {
  name = "upgrade_technique_Fire_FW",
  key = "upgrade_technique_Fire_FW",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 1, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Fire",
      "FW"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Forest_FW = {
  name = "upgrade_technique_Forest_FW",
  key = "upgrade_technique_Forest_FW",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 2, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Forest",
      "FW"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Mountain_FW = {
  name = "upgrade_technique_Mountain_FW",
  key = "upgrade_technique_Mountain_FW",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 3, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Mountain",
      "FW"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Wind_MF = {
  name = "upgrade_technique_Wind_MF",
  key = "upgrade_technique_Wind_MF",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 4, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Wind",
      "MF"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Fire_MF = {
  name = "upgrade_technique_Fire_MF",
  key = "upgrade_technique_Fire_MF",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 5, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Fire",
      "MF"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Forest_MF = {
  name = "upgrade_technique_Forest_MF",
  key = "upgrade_technique_Forest_MF",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 6, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Forest",
      "MF"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Mountain_MF = {
  name = "upgrade_technique_Mountain_MF",
  key = "upgrade_technique_Mountain_MF",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 7, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Mountain",
      "MF"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Wind_DF = {
  name = "upgrade_technique_Wind_DF",
  key = "upgrade_technique_Wind_DF",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 8, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Wind",
      "DF"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Fire_DF = {
  name = "upgrade_technique_Fire_DF",
  key = "upgrade_technique_Fire_DF",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 9, y = 0 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Fire",
      "DF"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Forest_DF = {
  name = "upgrade_technique_Forest_DF",
  key = "upgrade_technique_Forest_DF",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 0, y = 1 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Forest",
      "DF"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Mountain_DF = {
  name = "upgrade_technique_Mountain_DF",
  key = "upgrade_technique_Mountain_DF",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 1, y = 1 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Mountain",
      "DF"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Wind_GK = {
  name = "upgrade_technique_Wind_GK",
  key = "upgrade_technique_Wind_GK",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 2, y = 1 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Wind",
      "GK"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Fire_GK = {
  name = "upgrade_technique_Fire_GK",
  key = "upgrade_technique_Fire_GK",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 3, y = 1 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Fire",
      "GK"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Forest_GK = {
  name = "upgrade_technique_Forest_GK",
  key = "upgrade_technique_Forest_GK",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 4, y = 1 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Forest",
      "GK"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

local upgrade_technique_Mountain_GK = {
  name = "upgrade_technique_Mountain_GK",
  key = "upgrade_technique_Mountain_GK",
  set = "Training",
  loc_vars = function(self, info_queue, center)
  end,
  pos = { x = 5, y = 1 },
  atlas = "upgrade_techniques",
  pools = { ["Training"] = true },
  cost = 3,
  unlocked = true,
  discovered = false,
  can_use = function(self, card)
    return (
      (G.jokers.highlighted and #G.jokers.highlighted == 1) or
      (Pokerleven.ina_bench_area.highlighted and #Pokerleven.ina_bench_area.highlighted == 1)
    ) and can_upgrade_tech_level(
      G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1],
      "Mountain",
      "GK"
    )
  end,
  use = function(self, card, area, copier)
    local choice = G.jokers.highlighted[1] or Pokerleven.ina_bench_area.highlighted[1]

    increment_technique(choice)

    card_eval_status_text(choice, 'extra', nil, nil, nil,
      { message = localize("ina_technique_upgrade"), colour = G.C.SECONDARY_SET.Spectral })
  end,
  in_pool = function(self)
    return true
  end
}

return {
  name = "Trainings",
  list = { tech_book, tactic_pos, divine_water, black_room, centella,
    upgrade_technique_Forest_GK, upgrade_technique_Forest_DF, upgrade_technique_Forest_MF, upgrade_technique_Forest_FW,
    upgrade_technique_Fire_GK, upgrade_technique_Fire_DF, upgrade_technique_Fire_MF, upgrade_technique_Fire_FW,
    upgrade_technique_Wind_GK, upgrade_technique_Wind_DF, upgrade_technique_Wind_MF, upgrade_technique_Wind_FW,
    upgrade_technique_Mountain_GK, upgrade_technique_Mountain_DF, upgrade_technique_Mountain_MF,
    upgrade_technique_Mountain_FW, }
}
