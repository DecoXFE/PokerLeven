local generate_planet_text = function()
    return {
        "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
        "{C:attention}#2#",
        "{C:mult}+#3#{} Mult and",
        "{C:chips}+#4#{} chips",
    }
end

return {
    descriptions = {
        Strat = {
            c_ina_tech_book = {
                name = "Technique Book",
                text = { "Applies a random {C:pink}Type{}",
                    "to the leftmost Joker{}" }
            },
            c_ina_tactic_pos = {
                name = "Tactic Position",
                text = { "Applies a random {C:pink}Position{}",
                    "to the leftmost Joker{}" }
            }
        },
        Training = {
            c_ina_upgrade_technique_Forest_GK = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:forest}Forest{} type and {X:gk,C:white}GK{} position" }
            },
            c_ina_upgrade_technique_Forest_DF = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:forest}Forest{} type and {X:df,C:white}DF{} position" }
            },
            c_ina_upgrade_technique_Forest_MF = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:forest}Forest{} type and {X:mf,C:white}MF{} position" }
            },
            c_ina_upgrade_technique_Forest_FW = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:forest}Forest{} type and {X:fw,C:white}FW{} position" }
            },
            c_ina_upgrade_technique_Fire_GK = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:fire}Fire{} type and {X:gk,C:white}GK{} position" }
            },
            c_ina_upgrade_technique_Fire_DF = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:fire}Fire{} type and {X:df,C:white}DF{} position" }
            },
            c_ina_upgrade_technique_Fire_MF = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:fire}Fire{} type and {X:mf,C:white}MF{} position" }
            },
            c_ina_upgrade_technique_Fire_FW = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:fire}Fire{} type and {X:fw,C:white}FW{} position" }
            },
            c_ina_upgrade_technique_Wind_GK = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:wind}Wind{} type and {X:gk,C:white}GK{} position" }
            },
            c_ina_upgrade_technique_Wind_DF = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:wind}Wind{} type and {X:df,C:white}DF{} position" }
            },
            c_ina_upgrade_technique_Wind_MF = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:wind}Wind{} type and {X:mf,C:white}MF{} position" }
            },
            c_ina_upgrade_technique_Wind_FW = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:wind}Wind{} type and {X:fw,C:white}FW{} position" }
            },
            c_ina_upgrade_technique_Mountain_GK = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:mountain}Mountain{} type and {X:gk,C:white}GK{} position" }
            },
            c_ina_upgrade_technique_Mountain_DF = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:mountain}Mountain{} type and {X:df,C:white}DF{} position" }
            },
            c_ina_upgrade_technique_Mountain_MF = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:mountain}Mountain{} type and {X:mf,C:white}MF{} position" }
            },
            c_ina_upgrade_technique_Mountain_FW = {
                name = "Technique Upgrade",
                text = { "Upgrades the technique level of the",
                    "selected player if they are",
                    "{C:mountain}Mountain{} type and {X:fw,C:white}FW{} position" }
            },
        },
        Planet = {
            c_ina_make = {
                name = "Make",
                text = generate_planet_text()
            },
            c_ina_haumer = {
                name = "Haumer",
                text = generate_planet_text()
            },
            c_ina_orcus = {
                name = "Orcus",
                text = generate_planet_text()
            }
        },
        Spectral = {
            c_ina_black_room = {
                name = "Black Room",
                text = { "Raises the {C:training}technique level{}",
                    "of a card regardless of",
                    "its type or position" }
            },
            c_ina_divine_water = {
                name = "Divine Water",
                text = { "Upgrades {C:training}technique level{}",
                    "of one joker {C:dark_edition,E:1}to the max{}",
                    "but sets a {C:dark_edition}perishable{} sticker" }
            },
            c_ina_centella = {
                name = "Centella Center",
                text = { "Raises the {C:training}technique level{}",
                    "of all your {C:attention}starters{}" }
            }
        },
    },
}
