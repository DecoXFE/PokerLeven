SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 16,
    py = 16
})

SMODS.Atlas({
    key = "custom_icons",
    path = "custom_icons.png",
    px = 18,
    py = 18
})

SMODS.Atlas({
    key = "Jokers01",
    path = "Jokers01.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Jokers02",
    path = "Jokers02.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Jokers10",
    path = "Jokers10.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "JokersBobby",
    path = "JokersBobby.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "top",
    path = "top.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "legendary01",
    path = "legendary01.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "tournaments",
    path = "tournaments.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "ina_logo",
    path = "ina_logo.png",
    px = 389,
    py = 216
}):register()

SMODS.Atlas({
    key = "ina_resources",
    path = "resources.png",
    px = 18,
    py = 18
}):register()

SMODS.Atlas({
    key = "stickers",
    path = "stickers.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "stickers02",
    path = "stickers02.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Consumables",
    path = "consumables.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Managers01",
    path = "managers01.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "Boosters01",
    path = "Boosters01.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "decks",
    path = "decks.png",
    px = 71,
    py = 95,
}):register()

SMODS.Atlas({
    key = "Tags01",
    path = "tags01.png",
    px = 34,
    py = 34
}):register()

SMODS.Atlas({
    key = "bossBlinds",
    atlas_table = "ANIMATION_ATLAS",
    path = "bossBlinds01.png",
    px = 34,
    py = 34,
    frames = 21,
}):register()

SMODS.Atlas({
    key = "finalBossBlinds",
    atlas_table = "ANIMATION_ATLAS",
    path = "finalBossBlinds.png",
    px = 34,
    py = 34,
    frames = 34,
}):register()

SMODS.Atlas({
    key = "smallBlinds01",
    atlas_table = "ANIMATION_ATLAS",
    path = "smallBlinds01.png",
    px = 34,
    py = 34,
    frames = 21,
}):register()

SMODS.Atlas({
    key = "bigBlinds01",
    atlas_table = "ANIMATION_ATLAS",
    path = "bigBlinds01.png",
    px = 34,
    py = 34,
    frames = 21,
}):register()

SMODS.Atlas({
    key = "upgrade_techniques",
    path = "upgrade_techniques.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "vouchers01",
    path = "vouchers01.png",
    px = 71,
    py = 95
}):register()

SMODS.Sound({
    key = "music_titlescreen",
    path = "titlescreen.ogg",
    volume = 0.2,
    sync = {
        ina_music_mainline = true
    },
    pitch = 1,
    select_music_track = function()
        return G.STAGE == G.STAGES.MAIN_MENU
    end,
})

SMODS.Sound({
    key = "music_zeus",
    path = "ie1_k_zeusblind.ogg",
    volume = 0.15,
    sync = {
        ina_music_mainline = true
    },
    pitch = 1,
    select_music_track = function()
        if G.GAME and G.GAME.blind and G.GAME.blind.name == "Zeus" then
            return true
        end
    end,
})

SMODS.Sound({
    key = "music_royal",
    path = "ie1_k_royalccademy.ogg",
    volume = 0.15,
    sync = {
        ina_music_mainline = true
    },
    pitch = 1,
    select_music_track = function()
        if G.GAME and G.GAME.blind and G.GAME.blind.name == "Royal Academy" then
            return true
        end
    end,
})

SMODS.Sound({
    key = "music_ultrazeus",
    path = "ie1_k_ultrazeusblind.ogg",
    volume = 0.15,
    sync = {
        ina_music_mainline = true
    },
    pitch = 1,
    select_music_track = function()
        if G.GAME and G.GAME.blind and G.GAME.blind.name == "ina-zeus_caido" then
            return true
        end
    end,
})

local custom_colours = loc_colour
local top_rarity = SMODS.Gradient({
    key = 'topplayer2',
    colours = {
        HEX('e7b400'),
        HEX('df7500'),
    },
    cycle = 5,
    interpolation = 'trig'
})
local maxlvl = SMODS.Gradient({
    key = 'maxlvl',
    colours = {
        HEX('b30c00'),
        HEX('ffb200'),
    },
    cycle = 5,
    interpolation = 'trig'
})
local suits = SMODS.Gradient({
    key = 'suits',
    colours = {
        HEX('f03464'),
        HEX('235955'),
        HEX('f06b3f'),
        HEX('3c4368'),
    },
    cycle = 5,
    interpolation = 'trig'
})
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        custom_colours()
    end
    G.ARGS.LOC_COLOURS["mountain"] = HEX("f57c00")
    G.ARGS.LOC_COLOURS["gk"] = HEX("ffa726")
    G.ARGS.LOC_COLOURS["fire"] = HEX("d32f2f")
    G.ARGS.LOC_COLOURS["fw"] = HEX("ef5350")
    G.ARGS.LOC_COLOURS["forest"] = HEX("2e7d32")
    G.ARGS.LOC_COLOURS["df"] = HEX("66bb6a")
    G.ARGS.LOC_COLOURS["wind"] = HEX("81d4fa")
    G.ARGS.LOC_COLOURS["mf"] = HEX("4fc3f7")
    G.ARGS.LOC_COLOURS["raimon"] = HEX("ffa726")
    G.ARGS.LOC_COLOURS["occult"] = HEX("4B0082")
    G.ARGS.LOC_COLOURS["royal academy"] = HEX("2C5E4F")
    G.ARGS.LOC_COLOURS["wild"] = HEX("797B49")
    G.ARGS.LOC_COLOURS["brain"] = HEX("888888")
    G.ARGS.LOC_COLOURS["otaku"] = HEX("A754C4")
    G.ARGS.LOC_COLOURS["shuriken"] = HEX("4B0082")
    G.ARGS.LOC_COLOURS["farm"] = HEX("7AC943")
    G.ARGS.LOC_COLOURS["inazuma"] = HEX("ffa726")
    G.ARGS.LOC_COLOURS["kirkwood"] = HEX("7A5E3C")
    G.ARGS.LOC_COLOURS["zeus"] = HEX("D4AF37")
    G.ARGS.LOC_COLOURS["pink"] = HEX("FF7ABF")
    G.ARGS.LOC_COLOURS["inazuma_eleven"] = HEX("fb8c00")
    G.ARGS.LOC_COLOURS["bench"] = HEX("4ca0a5")
    G.ARGS.LOC_COLOURS["training"] = HEX("5A00FF")
    G.ARGS.LOC_COLOURS["strat"] = HEX("9AA4B7")
    G.ARGS.LOC_COLOURS["top"] = top_rarity
    G.ARGS.LOC_COLOURS["maxlvl"] = maxlvl
    G.ARGS.LOC_COLOURS["suits"] = suits


    return custom_colours(_c, _default)
end
