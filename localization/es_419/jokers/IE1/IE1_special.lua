return {
    descriptions = {
        Joker = {
            j_ina_Nelly = {
                name = "Nelly",
                text = { { "Por cada ronda se otorga entre {C:money}#1#${} a {C:money}#2#${},",
                    "si se {C:attention}pierde la partida{}, en vez de eso,",
                    "se {C:mult}destruyen{} todos los jokers",
                    "fuera del banquillo y esta carta." },
                    { "Si es más de ante {C:attention}#3#{}",
                        "al morir pone el dinero a {C:money}#4#${}" } }
            },

            j_ina_Celia = {
                name = "Celia",
                text = { {
                    "Si tienes un {C:attention}Jude{},",
                    "lo transforma a su forma del {X:raimon,C:white}Raimon{}",
                    "al comienzo de la próxima tienda"
                },
                    { "Genera un {C:attention}Scout{} en el {C:bench}Banquillo{}",
                        "al seleccionar una ciega",
                        "{C:inactive}Debe haber espacio{}" } }
            },

            j_ina_Koudera = {
                name = "Koudera",
                text = {
                    "{C:tarot}+#1#{} espacio de {C:tarot}consumibles{}"
                }
            },

            j_ina_Aurelia = {
                name = "Aurelia",
                text = {
                    "{C:green}+#1#{} {C:attention}reroll{} gratis por tienda"
                }
            },

            j_ina_Silvia = {
                name = "Silvia",
                text = {
                    "{C:green}+#1#{} {C:attention}booster pack{} slot"
                }
            },

            j_ina_Akihiro = {
                name = "Akihiro Hino",
                text = {
                    "{C:dark_edition,E:1}Por favor espere un poco más{}"
                }
            },
        },

        Other = {
            ina_training_seal = {
                name = "Sello de entrenamiento",
                text = {
                    "Crea una carta de {C:training}Entrenamiento{}",
                    "si puntúa en la {C:attention}última mano{}",
                    "{C:inactive}(Debe haber espacio){}",
                },
            },
            card_emult = {
                text = {
                    "{C:dark_edition}^#1#{} Mult"
                }
            },
            card_extra_emult = {
                text = {
                    "{C:dark_edition}^#1#{} Mult"
                }
            },
            Mountain = {
                name = "Tipo",
                text = { "{X:mountain,C:white}Montaña{}" }
            },
            Fire = {
                name = "Tipo",
                text = { "{X:fire,C:white}Fuego{}" }
            },
            GK = {
                name = "Posición",
                text = { "{X:gk,C:white}GK{}" }
            },
            FW = {
                name = "Posición",
                text = { "{X:fw,C:white}FW{}" }
            },
            Forest = {
                name = "Tipo",
                text = { "{X:forest,C:white}Bosque{}" }
            },
            Wind = {
                name = "Tipo",
                text = { "{X:wind,C:white}Viento{}" }
            },
            DF = {
                name = "Posición",
                text = { "{X:df,C:white}DF{}" }
            },
            MF = {
                name = "Posición",
                text = { "{X:mf,C:white}MF{}" }
            },
            Harvester = {
                name = "Cosechador",
                text = { "Se activa al descartar",
                    "una carta {C:attention}Cosechable{}" }
            },
            Frontal = {
                name = "Frontal",
                text = { "Se activa si es el",
                    "joker de más a la {C:attention}Izquierda{}" }
            },
            Trillizos = {
                name = "Triángulo Z",
                text = { "Si tienes a {C:attention}Thomas{}",
                    "{C:attention}Tyler{} y {C:attention}Marvin{} reactiva",
                    "las cartas {C:attention}impares{}" }
            },
            Right_Footed = {
                name = "Diestro",
                text = { "Se activa si es el",
                    "joker de más a la {C:attention}Derecha{}" }
            },
            p_ina_growing_pack = {
                name = "Pack Creciente",
                text = { "Elige {C:attention}#1#{} entre {C:attention}#2#{}", "{C:attention}Jokers{} de tus equipos" }
            },
            p_ina_advanced_pack = {
                name = "Pack Avanzado",
                text = { "Elige {C:attention}#1#{} entre {C:attention}#2#{}", "{C:attention}Jokers{} de tus equipos" }
            },
            p_ina_item_pack_ina = {
                name = "Ina Pack",
                text = { "Elige {C:attention}#1#{} de {C:attention}#2#{} Cartas del {C:tarot}Tarot{}",
                    "#3# {C:strat}Strats{} o #4# {C:training}Entrenamientos{}",
                    "compatible con uno de tus jugadores",
                    "para usar de inmediato" }
            },
            p_ina_manager_pack = {
                name = "Manager Pack",
                text = { "Elige {C:attention}#1#{} de {C:attention}#2#{} {C:pink}Managers{}" }
            },
            p_ina_training_pack = {
                name = "Training Pack",
                text = { "Elige {C:attention}#1#{} de {C:attention}#2#{} {C:training}Entrenamientos{}",
                    "para usar de inmediato" }
            },
            p_ina_jumbo_training_pack = {
                name = "Jumbo Training Pack",
                text = { "Elige {C:attention}#1#{} de {C:attention}#2#{} {C:training}Entrenamientos{}",
                    "para usar de inmediato", "Al menos uno será compatible",
                    "con tus {C:attention}Jokers{}" }
            },
            p_ina_mega_training_pack = {
                name = "Mega Training Pack",
                text = { "Elige {C:attention}#1#{} de {C:attention}#2#{} {C:training}Entrenamientos{}",
                    "para usar de inmediato", "Al menos dos serán compatibles",
                    "con tus {C:attention}Jokers{}" }
            },
            ina_harvest_sticker = {
                name = "Cosechable",
                text = {
                    "Esta carta puede ser",
                    "cosechada por jokers"
                },
            },
            ina_tech_plus1_sticker = {
                name = "Técnica +1",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_plus2_sticker = {
                name = "Técnica +2",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_plus3_sticker = {
                name = "Técnica +3",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_plus4_sticker = {
                name = "Técnica +4",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_plus5_sticker = {
                name = "Técnica +5",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_number2_sticker = {
                name = "Técnica número 2",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_number3_sticker = {
                name = "Técnica número 3",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_number4_sticker = {
                name = "Técnica número 4",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_numbera_sticker = {
                name = "Técnica A",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_numbers_sticker = {
                name = "Técnica S",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_numberz_sticker = {
                name = "Técnica Z",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_numberinf_sticker = {
                name = "Técnica infinito",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_grade2_sticker = {
                name = "Técnica grado 2",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_grade3_sticker = {
                name = "Técnica grado 3",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_grade4_sticker = {
                name = "Técnica grado 4",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_grade5_sticker = {
                name = "Técnica grado 5",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_grade0_sticker = {
                name = "Técnica grado 0",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_j_sticker = {
                name = "Técnica J",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_q_sticker = {
                name = "Técnica Q",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_k_sticker = {
                name = "Técnica K",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_a_sticker = {
                name = "Técnica A",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
            },
            ina_tech_joker_sticker = {
                name = "Técnica Joker",
                text = {
                    "Este comodín tiene las",
                    "estadísticas aumentadas"
                },
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
                text = { "Sube el {C:training}nivel de técnica{}",
                    "de una carta sin importar",
                    "su tipo o posición" }
            },
            c_ina_divine_water = {
                name = "Néctar de los Dioses",
                text = { "Sube el {C:training}nivel de técnica{}",
                    "de una carta {C:dark_edition,E:1}al máximo{}",
                    "pero lo vuelve {C:dark_edition}perecedero{}" }
            },
            c_ina_wait = {
                name = "Espere un poco más",
                text = { "Crea un manager {C:dark_edition}Legendario{}" }
            },
            c_ina_centella = {
                name = "Centro centella",
                text = { "Sube el {C:training}nivel de técnica{}",
                    "de todos tus {C:attention}titulares{}" }
            }
        },
        Stake = {},
        Tag = {
            tag_ina_wild_tag = {
                name = "Etiqueta Wild",
                text = { { "La tienda tiene un {C:attention}jugador gratuito{}",
                    "{C:uncommon}Poco Común{} de uno de tus equipos",
                },
                    { "Probabilidad aumentada de que",
                        "el comodín sea {C:dark_edition}negativo{}" } }
            },
            tag_ina_chain_tag = {
                name = "Etiqueta Cadena",
                text = { "Cambia la {C:attention}Ciega grande{}, Si estas en",
                    "una ciega grande, cambia la {C:attention}Ciega Jefe{}" }
            },
            tag_ina_bench_tag = {
                name = "Etiqueta Banquillo",
                text = { "Otorga gratis un {C:pink}Manager Pack{}" }
            },
            tag_ina_technique_tag = {
                name = "Etiqueta Técnica",
                text = { "Otorga gratis un {C:training}Mega Training Pack{}" }
            }
        },
        Tarot = {},
        Voucher = {
            v_ina_ex_law = {
                name = "Ley del Ex",
                text = {
                    "Por cada jugador que",
                    "lleves del equipo al",
                    "que te enfrentas, reduce",
                    "en un {C:attention}#1#%{} las {C:chips}fichas{} necesarias"
                },
            },
            v_ina_ex_law_2 = {
                name = "Ley del Ex",
                text = {
                    "Por cada jugador que",
                    "lleves del equipo al",
                    "que te enfrentas, reduce",
                    "en un {C:attention}#1#%{} las {C:chips}fichas{} necesarias"
                },
                unlock = {
                    "{C:mult}Derrota{} a un equipo",
                    "con {C:attention}al menos{} un jugador",
                    "que pertenezca a dicho equipo"
                }
            },
            v_ina_training = {
                name = "Entrenamiento",
                text = {
                    "{C:attention}+1{} al {C:gold}nivel máximo{} de técnica"
                },
            },
            v_ina_training_2 = {
                name = "Súper Entrenamiento",
                text = {
                    "{C:attention}+1{} al {C:maxlvl}nivel máximo{} de técnica"
                },
                unlock = {
                    "Sube a {C:training}ASZ/+4/A/G5{}",
                    "la técnica de un jugador"
                }
            },
            v_ina_managers_1 = {
                name = "Nueva incorporación",
                text = {
                    "{C:attention}+1{} espacio de {C:enhanced}Mánager{}"
                },
            },
            v_ina_managers_2 = {
                name = "Nueva incorporación",
                text = {
                    "{C:attention}+1{} espacio de {C:enhanced}Mánager{}"
                },
                unlock = {
                    "Consigue espacio para {C:attention}3{} {C:pink}Managers{}"
                }
            },
        }
        },
    },
}
