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
        Back = {},
        Blind = {
            -- Blinds pequeños
            bl_ina_benchers = {
                name = "ChupaBanquillos",
                text = { "Sam, al banquillo",
                    "(No hace nada)" }
            },
            bl_ina_baseball_all_stars = {
                name = "Grandes Bateadores",
                text = { "Gana con 4 manos" }
            },
            bl_ina_strange_guys = {
                name = "Sospechosos",
                text = { "La primera carta jugada",
                    "de la primera mano se",
                    "convierte en otra aleatoria" }
            },
            bl_ina_inazuma08 = {
                name = "Inazuma 08",
                text = { "Gana 8$!!" }
            },
            bl_ina_inazuma_town = {
                name = "Ciudad Inazuma",
                text = { "Si has jugado más",
                    "de #1# tipos de mano",
                    "-#2# descarte" }
            },
            bl_ina_glasses = {
                name = "Gafitas",
                text = { "Reactiva las primeras dos cartas",
                    "de cristal que puntuen" }
            },
            -- Blinds grandes
            bl_ina_ff_regional_a = {
                name = "Selección FF A",
                text = { "Malardos A" }
            },
            bl_ina_ff_regional_b = {
                name = "Selección FF B",
                text = { "Malardos B" }
            },
            bl_ina_ff_national_a = {
                name = "Selección Nacional A",
                text = { "No tan Malardos A" }
            },
            bl_ina_ff_national_b = {
                name = "Selección Nacional B",
                text = { "No tan Malardos B" }
            },
            bl_ina_umbrella = {
                name = "Umbrella",
                text = { "Gana 1 descarte y pierde 1 mano" }
            },
            bl_ina_inazuma_kids = {
                name = "Inazuma Kids",
                text = {}
            },
            bl_ina_sallys = {
                name = "Sallys",
                text = {}
            },
            bl_ina_occult = {
                name = "Occult",
                text = { "Los 6 puntuan dos veces" }
            },
            bl_ina_raimonOB = {
                name = "Raimon OB",
                text = { "Cada corazon otorga 20 chips extra!" }
            },
            bl_ina_shun = {
                name = "Shun",
                text = { "Si pierdes en esta ciega",
                    "revives con 0 de oro" }
            },
            bl_ina_empress = {
                name = "Empress",
                text = { "Gana una carta emperador",
                    "al derrotar la ciega" }
            },
            -- Blinds jefes
            bl_ina_goalkeeper = {
                name = "GK",
                text = { "Los jugadores {X:gk,C:white}GK{}", "están debilitados" }
            },
            bl_ina_forward = {
                name = "FW",
                text = { "Los jugadores {X:fw,C:white}FW{}", "están debilitados" }
            },
            bl_ina_defense = {
                name = "DF",
                text = { "Los jugadores {X:df,C:white}DF{}", "están debilitados" }
            },
            bl_ina_midfielder = {
                name = "MF",
                text = { "Los jugadores {X:mf,C:white}MF{}", "están debilitados" }
            },
            bl_ina_fire = {
                name = "Jefe de Fuego",
                text = { "Los jugadores de {X:fire,C:white}Fuego{}", "están debilitados" }
            },
            bl_ina_forest = {
                name = "Jefe de Bosque",
                text = { "Los jugadores de tipo {X:forest,C:white}Bosque{}", "están debilitados" }
            },
            bl_ina_mountain = {
                name = "Jefe de Montaña",
                text = { "Los jugadores de tipo {X:Mountain,C:white}Montaña{}", "están debilitados" }
            },
            bl_ina_wind = {
                name = "Jefe de Viento",
                text = { "Los jugadores de tipo {X:Wind,C:white}Viento{}", "están debilitados" }
            },
            bl_ina_inazuma_og = {
                name = "Inazuma Eleven",
                text = { "Tienes que jugar 5 cartas" }
            },
            bl_ina_royal_blind = {
                name = "Royal Academy",
                text = { "Juega una sola mano" }
            },
            bl_ina_wild = {
                name = "Wild",
                text = { "Debilita las cartas", "versátiles" }
            },
            bl_ina_brain = {
                name = "Brain",
                text = { "Las cartas se roban",
                    "boca abajo tras", "cada mano jugada" }
            },
            bl_ina_otaku = {
                name = "Otaku",
                text = { "Las figuras se debilitan" }
            },
            bl_ina_shuriken = {
                name = "Shuriken",
                text = { "Cada carta jugada",
                    "resta 1 moneda" }
            },
            bl_ina_farm = {
                name = "Farm",
                text = { "Ciega MUY grande" }
            },
            bl_ina_kirkwood = {
                name = "Kirkwood",
                text = { "1 de 7 cartas esta volteada" }
            },
            bl_ina_zeus = {
                name = "Zeus",
                text = { "Pone el nivel de la",
                    "mano de póker jugada a 1" }
            },

            -- Final Boss Blinds
            bl_ina_zeus_caido = {
                name = "Ultra Zeus",
                text = { "Cada mano robada aumenta", "las fichas necesarias en un #1#%" }
            }
        },
        Strat = {
            c_ina_tech_book = {
                name = "Libro Técnico",
                text = { "Aplica un {C:pink}Tipo{} aleatorio",
                    "al Joker más a la izquierda{}" }
            },
            c_ina_tactic_pos = {
                name = "Posición Táctica",
                text = { "Aplica una {C:pink}Posición{} aleatoria",
                    "al Joker más a la izquierda{}" }
            }
        },
        Training = {
            c_ina_upgrade_technique_Forest_GK = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:forest}Bosque{} y su posición es {X:gk,C:white}GK{}" }
            },
            c_ina_upgrade_technique_Forest_DF = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:forest}Bosque{} y su posición es {X:df,C:white}DF{}" }
            },
            c_ina_upgrade_technique_Forest_MF = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:forest}Bosque{} y su posición es {X:mf,C:white}MF{}" }
            },
            c_ina_upgrade_technique_Forest_FW = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:forest}Bosque{} y su posición es {X:fw,C:white}FW{}" }
            },
            c_ina_upgrade_technique_Fire_GK = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:fire}Fuego{} y su posición es {X:gk,C:white}GK{}" }
            },
            c_ina_upgrade_technique_Fire_DF = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:fire}Fuego{} y su posición es {X:df,C:white}DF{}" }
            },
            c_ina_upgrade_technique_Fire_MF = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:fire}Fuego{} y su posición es {X:mf,C:white}MF{}" }
            },
            c_ina_upgrade_technique_Fire_FW = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:fire}Fuego{} y su posición es {X:fw,C:white}FW{}" }
            },
            c_ina_upgrade_technique_Wind_GK = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:wind}Viento{} y su posición es {X:gk,C:white}GK{}" }
            },
            c_ina_upgrade_technique_Wind_DF = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:wind}Viento{} y su posición es {X:df,C:white}DF{}" }
            },
            c_ina_upgrade_technique_Wind_MF = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:wind}Viento{} y su posición es {X:mf,C:white}MF{}" }
            },
            c_ina_upgrade_technique_Wind_FW = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:wind}Viento{} y su posición es {X:fw,C:white}FW{}" }
            },
            c_ina_upgrade_technique_Mountain_GK = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:mountain}Montaña{} y su posición es {X:gk,C:white}GK{}" }
            },
            c_ina_upgrade_technique_Mountain_DF = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:mountain}Montaña{} y su posición es {X:df,C:white}DF{}" }
            },
            c_ina_upgrade_technique_Mountain_MF = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:mountain}Montaña{} y su posición es {X:mf,C:white}MF{}" }
            },
            c_ina_upgrade_technique_Mountain_FW = {
                name = "Mejora de técnica",
                text = { "Mejora el nivel de técnica del",
                    "jugador seleccionado si este es del",
                    "tipo {C:mountain}Montaña{} y su posición es {X:fw,C:white}FW{}" }
            },
        },
        Edition = {},
        Enhanced = {},
        Joker = {
            j_ina_Kevin = {
                name = "Kevin",
                text = { "{C:forest}Tornado Dragón{}", "Vuelve a activar el comodín {X:fw,C:white}FW{}",
                    "que está a su derecha{}" }
            },
            j_ina_Mark = {
                name = "Mark",
                text = { "{C:mountain}Mano Mágica{}",
                    "{C:attention}+#1#{} Al tamaño de mano jugada",
                    "{C:attention}+#1#{} A la cantidad de cartas descartadas" }
            },
            j_ina_Nathan = {
                name = "Nathan",
                text = { "{C:wind}Entrada Huracán{}",
                    "Cada jugador de {X:raimon,C:white}Raimon{} otorga {X:mult,C:white}X#2#{}" }
            },
            j_ina_Jack = {
                name = "Jack",
                text = { "{C:mountain}El Muro{}", "Por cada comodín {X:df,C:white}DF{}",
                    "{C:attention}Las Piedras{} ganan",
                    "{C:chips}+#1#{} fichas permanentemente" }
            },
            j_ina_Axel = {
                name = "Axel",
                text = { "{C:fire}Tornado de Fuego", "{X:mult,C:white}X#1#{} si la mano jugada",
                    "contiene {C:attention}5 cartas{} de {C:red}corazones{}" }
            },
            j_ina_Shadow = {
                name = "Shadow",
                text = { "{C:forest}Tornado Oscuro{}", "{C:mult}+#1#{} Mult",
                    "Gana {C:mult}+#2#{} Mult por cada mano jugada sin", "activar ningún otro comodín" }
            },
            j_ina_Willy = {
                name = "Willy",
                text = { "{C:forest}Remate gafas{}",
                    "Probabilidad de {C:green}#1# entre #2#{} de convertir",
                    "la mano jugada en cartas {C:attention}policromáticas{},",
                    "de {C:attention}cristal{} y con {C:attention}sello rojo{}" }
            },
            j_ina_Max = {
                name = "Max",
                text = { "{C:wind}Remate Espiral{}", "{C:chips}+#2#{} fichas",
                    "{C:chips}+#1#{} fichas por cada comodín de {X:wind,C:white}Viento{}" }
            },
            j_ina_Peabody = {
                name = "Peabody",
                text = { "{C:mountain}Mano Celestial{}", "{C:mult}+#1#{} Mult en tu última mano",
                    "Aumenta en {C:mult}+#2#{} por cada última mano jugada" }
            },
            j_ina_Jude_Raimon = {
                name = "Jude",
                text = { "{C:wind}Espejismo de Balón{}", "{X:mult,C:white}X#1#{}",
                    "Gana {X:mult,C:white}X#2#{} cada vez que el comodín",
                    "a su {C:attention}izquierda{} se activa" }
            },
            j_ina_Bobby = {
                name = "Bobby",
                text = { { "{C:wind}El Traidor{}",
                    "Al seleccionar la ciega cambia",
                    "al equipo del que tengas más jugadores", },
                    { "Los jugadores del equipo",
                        "de {C:attention}Bobby{} otorgan {C:chips}+#1# Chips{}", } }
            },
            j_ina_Steve = {
                name = "Steve",
                text = { "{C:wind}Disparo Rodante{}", "Cada jugador del {X:raimon,C:white}Raimon{}",
                    "otorga {C:chips}+#1#{} fichas y {C:mult}+#2#{} mult",
                    "Obtiene {C:money}+#3#${} al terminar la ronda",
                    "{C:inactive}Actualmente{} {C:chips}+#4#{}{C:inactive} {C:inactive}y{} {C:mult}+#5#{}" }
            },
            -- Occult
            j_ina_Talisman = {
                name = "Talisman",
                text = { "{C:forest}Rapto Divino{}", "Vuelve a activar",
                    " el comodín {X:occult,C:white}Occult{} que", "está a su derecha{} {C:attention}2 veces{}" }
            },
            j_ina_Wolfy = {
                name = "Wolfy",
                text = { "{C:fire}Luna creciente{}", "{X:mult,C:white}X#1#{}", "Gana {X:mult,C:white}X#2#{} por cada",
                    "carta {C:tarot}La Luna{} usada" }
            },
            j_ina_Blood = {
                name = "Blood",
                text = { "{C:mountain}Niebla Venenosa{}",
                    "{C:attention}Drena{} {C:money}#1#${} de los comodines adyacentes",
                    "{C:chips}+#2#{} fichas por cada {C:money}1${}", "en su valor de venta",
                    "{C:inactive}Actualmente{} {C:chips}+#3#{}" }
            },
            j_ina_Grave = {
                name = "Grave",
                text = { "{C:fire}Maldición{}", "{C:green}#1# de #2#{} de probabilidad",
                    "de crear una carta {C:tarot}Muerte{}", "por cada {C:attention}6{} anotado" }
            },
            j_ina_Mask = {
                name = "Mask",
                text = { "{C:wind}Cuchilla Asesina{}", "Sacrifica el comodín a la derecha",
                    "y gana {C:money}#1#${} de valor de venta", "cuando se selecciona una ciega" }
            },
            j_ina_Styx = {
                name = "Styx",
                text = { "{C:forest}Tiro Fantasma{}", "{C:chips}+#1#{} fichas",
                    "{C:chips}+#2#{} fichas por cada carta {C:tarot}Tarot{} usada" }
            },
            j_ina_Franky = {
                name = "Franky",
                text = { "{C:mountain}Mega Terremoto{}", "{C:attention}Carta alta{} otorga {C:mult}+#1#{} Mult" }
            },
            j_ina_Mummy = {
                name = "Mummy",
                text = { "{C:forest}Gravedad{}", "Cada {C:clubs}#3#{} otorga {C:mult}+#1#{} Mult y {C:chips}+#2#{} Chips" }
            },
            j_ina_King = {
                name = "King",
                text = { "{C:fire}Escudo de Fuerza{}", "Si la mano jugada contiene",
                    "un {C:attention}Trío{} de {C:attention}Reyes{}:",
                    "Crea una copia del rey más a la {C:attention}derecha{}" }
            },
            j_ina_Bloom = {
                name = "Bloom",
                text = { "{C:fire}Chut de los 100 toques{}", "{C:mult}+#1#{} Mult",
                    "Gana {C:mult}+#2#{} Mult si la mano jugada", "contiene una {C:attention}escalera{}" }
            },
            j_ina_Drent = {
                name = "Drent",
                text = { "{C:mountain}Terremoto{}", "{C:green}#1# en #2#{} de probabilidad",
                    "de crear una carta {C:tarot}La Torre{}", "después de cada {C:attention}mano{} jugada.",
                    "La probabilidad mejora en 1", "por cada comodín {X:mountain,C:white}Montaña{}" }
            },
            j_ina_Jude = {
                name = "Jude",
                text = { "{C:wind}Espejismo de Balón{}", "{X:mult,C:white}X#1#{}",
                    "Gana {X:mult,C:white}X#2#{} cada vez que el comodín",
                    "a su {C:attention}izquierda{} se activa", "en la mano con puntuación" }
            },
            j_ina_Martin = {
                name = "Martin",
                text = { "{C:forest}Barrido Defensivo{}", "Los comodines {C:blue}Comunes{} otorgan {C:mult}+#1#{} Mult",
                    "Los comodines {C:green}Poco Comunes{} otorgan {C:mult}+#2#{} Mult",
                    "Los comodines {C:red}Raros{} otorgan {X:mult,C:white}X#3#{} Mult",
                    "Los comodines {C:purple}Legendarios{} otorgan {X:dark_edition,C:white}^#4#{} Mult" }
            },
            j_ina_Master = {
                name = "Master",
                text = { "{C:wind}Coz{}", "{C:mult}+#1#{} Mult por cada",
                    "comodín de la {X:royal academy,C:white}Acad. Royal{}",
                    "si es el {C:attention}primer{} comodín a la izquierda" }
            },
            j_ina_Samford = {
                name = "Samford",
                text = { "{C:forest}Pingüino Emperador N.º 2{}", "{X:mult,C:white}X#1#{} si tienes al menos",
                    "{C:attention}1{} {X:mf,C:white}MF{} y {C:attention}2{} {X:fw,C:white}FW{} comodines" }
            },
            j_ina_Swing = {
                name = "Swing",
                text = { "{C:wind}Regate Multiple{}", "{C:chips}+#1#{} Fichas por cada",
                    "comodín de la {X:royal academy,C:white}Acad. Royal{} si la",
                    "mano contiene un {C:attention}Trío{}" }
            },
            j_ina_Chicken = {
                name = "Chicken",
                text = { "{C:fire}Huevo Dorado{}", "Las cartas {C:attention}Versatiles{} tienen",
                    "{C:green}#1# de #2#{} de probabilidad", "de ganar {C:money}#3#${} al puntuar" }
            },
            j_ina_Boar = {
                name = "Boar",
                text = { "{C:fire}Garra Salvaje{}", "Si juegas una {C:attention}pareja de doses{}",
                    "destrúyela y genera", "una {C:attention}Etiqueta Wild{}" }
            },
            j_ina_Chamaleon = {
                name = "Chamaleon",
                text = { "{C:wind}Espejismo{}",
                    "Puedes jugar {C:attention}Color{} con 4 cartas",
                    "Si juegas una 5ta carta", "y es de otro palo,",
                    "la transforma en una {C:tarot}Carta Versatil{}" }
            },
            j_ina_Eagle = {
                name = "Eagle",
                text = { "{C:wind}Ataque de Cóndor{}", "Gana {C:mult}+#1#{} Mult por cada",
                    "{C:tarot}Carta Versatil{} que puntúe en una mano", "que contenga una {C:attention}escalera{}",
                    "{C:inactive}Actualmente{} {C:mult}+#2#{}" }
            },
            j_ina_Monkey = {
                name = "Monkey",
                text = { "{C:wind}Giro del Mono{}",
                    "Obtén {X:mult,C:white}XMult{} igual al",
                    "número de {C:tarot}Cartas Versatiles{}",
                    "en el mazo multiplicado por", "los jugadores {X:wild,C:white}Wild{} del equipo / 10",
                    "Actualmente {X:mult,C:white}X#1#{}" }
            },
            j_ina_Gorilla = {
                name = "Gorilla",
                text = { "{C:mountain}Remate Tarzán{}", "Crea una {C:attention}Etiqueta Wild{}",
                    "al derrotar a la Ciega Jefe" }
            },
            j_ina_Cheetah = {
                name = "Cheetah",
                text = { "{C:wind}Superaceleración{}", "Si juegas {C:attention}5 cartas versatiles que puntúan{}",
                    "vuelve a activarlas una vez", "por cada jugador del elemento {X:select_element,C:white}#1#{}",
                    "El elemento cambia cada ronda" }
            },
            j_ina_Feldt = {
                name = "Feldt",
                text = { {
                    "{C:forest}Campo de Fuerza Defensivo{}",
                    "Genera {C:attention}#1#{} {X:mountain,C:white}Barrera{}",
                    "si juegas al menos {C:attention}3{} {C:spades}Picas{}"
                },
                    {
                        "En la {C:attention}última mano{},",
                        "consume todas las {X:mountain,C:white}Barreras{}",
                        "para dar {X:mult,C:white}X#2#{} por",
                        "cada jugador de {X:forest,C:white}Bosque{}",
                        "{C:inactive}Actualmente{} {X:mult,C:white}X#3#"
                    }
                }
            },

            j_ina_Marvel = {
                name = "Marvel",
                text = { "{C:mountain}Escaner Defensa", "Si el valor en {C:chips}chips{}",
                    "de la carta que puntua",
                    "tiene {C:attention}exactamente 3 bits en 1{}",
                    "{C:mult}+#1#{} mult{}" }
            },

            j_ina_Tell = {
                name = "Tell",
                text = { "{C:forest}Adivino{}", "{X:chips,C:white}XPI{} si tienes",
                    "{C:attention}3 1 4{} en la mano trasera al puntuar" }
            },

            j_ina_Seller = {
                name = "Seller",
                text = { "{C:wind}Psicorremate{}", "Tras cada ronda jugada",
                    "gana {C:money}+#2#$ de potencial de venta{}.", "Cuando se venda Seller, aumenta",
                    "el {C:money}valor de venta{} de otros jokers", "por su potencial de venta",
                    "{C:inactive}Actualmente{} {C:money}#1#${}" }
            },

            j_ina_Kind = {
                name = "Kind",
                text = { "{C:forest}Escaner ataque{}", "Si la mano de puntuación es un {C:attention}palíndromo{},",
                    "reactiva la primera y la última carta." }
            },

            j_ina_Turner = {
                name = "Turner",
                text = { "{C:fire}Tornado de fuego{}", "Crea una copia de la {C:attention}primera carta{}",
                    "puntuada en la {C:attention}primera mano{} jugada",
                    "por cada jugador {X:brain,C:white}Brain{} en tu equipo",
                    "si la mano jugada contiene un {C:attention}póker{}" }
            },

            j_ina_Under = {
                name = "Under",
                text = { "{C:forest}Calculo Dificil", "Obtiene {C:chips}#1# / log2(#2# + 1){} chips",
                    "por cada {X:gk,C:white}GK{}{}" }
            },

            -- Otaku
            j_ina_Idol = {
                name = "Idol",
                text = { "{C:mountain}Deslizamiento de Portería{}",
                    "Reactiva {C:attention}4s{}",
                    "{C:green}#1# de cada #2#{} veces" }
            },

            j_ina_Hero = {
                name = "Hero",
                text = { "{C:fire}Bola falsa{}", "Transforma cada carta puntuada",
                    "{C:attention}figura{} en un {C:attention}4{}" }
            },

            j_ina_Custom = {
                name = "Custom",
                text = { "{C:wind}Ciclón{}", "Los jokers de {X:wind,C:white}Viento{}", "pueden aparecer múltiples veces" }
            },

            j_ina_Robot = {
                name = "Robot",
                text = { "{C:wind}Confusión{}", "Vuelve a activar las {C:attention}Lucky Cards{}",
                    "puntuadas en una {C:attention}escalera{}",
                    "que estén en la misma posición",
                    "que cada uno de tus jokers",
                    "{X:mf,C:white}MF{} empezando por la izquierda" }
            },

            j_ina_Gamer = {
                name = "Gamer",
                text = { "{C:fire}Bateo Total{}", "Ganas {C:chips}fichas{} iguales a tus {C:attention}FPS / 2{}",
                    "El bono pasa a ser {C:attention}FPS{} si", "tienes al menos 2 jugadores {X:otaku,C:white}Otaku{}",
                    "El valor máximo es {C:attention}144 FPS{}", "{C:inactive}Actualmente{} {C:chips}+#1#{}" }
            },

            j_ina_Artist = {
                name = "Artista",
                text = { "{C:wind}Ludopatía Máxima{}", "Si la mano jugada contiene",
                    "un {C:attention}Rey{} y una {C:attention}Reina{} que puntúen",
                    "convierte todas las cartas puntuadas",
                    "en {C:attention}Cartas de la Suerte{}" }
            },

            j_ina_Arcade = {
                name = "Arcade",
                text = { "{C:forest}Tiro del Cometa{}", "La probabilidad de activar",
                    "el dinero extra en las {C:attention}Lucky Card{}",
                    "es ahora {C:green}#1# en 15{}, Ahora cada",
                    "{C:attention}Lucky Card{}", "cuesta {C:money}#2#${} para jugarse" }
            },

            -- Inazuma Eleven
            j_ina_Hillman = {
                name = "Hillman",
                text = { "{C:mountain}Restaurante Ray Ray{}",
                    "Gana {X:chips,C:white}X#1#{} fichas por",
                    "{C:pink}Strat{} usada esta partida",
                    "{C:inactive}Actualmente{} {X:chips,C:white}X#2#{}" }
            },

            j_ina_Island = {
                name = "Island",
                text = { "{C:forest}Zig zag chispeante{}",
                    "Gana {C:chips}+#1#{} fichas si la mano jugada",
                    "contiene {C:attention}doble pareja{}",
                    "{C:inactive}Actualmente{} {C:chips}+#2#{}" }
            },

            j_ina_Sweet = {
                name = "Sweet",
                text = { "{C:mountain}Reclutamiento{}",
                    "Crea un comodín del {X:raimon,C:white}Raimon{} o {X:inazuma_eleven,C:white}I.Eleven",
                    "cuando se selecciona la ciega{}",
                    "Puede ser {C:chips}Común{} o {C:green}Poco Común{}",
                    "{C:inactive}Tienes que tener espacio{}" }
            },

            j_ina_Butler = {
                name = "Butler",
                text = { "{C:forest}Rentista{}",
                    "La deuda ahora puede",
                    "llegar hasta {C:money}-#1#${}",
                    "por cada {C:money}-#2#${}, cada",
                    "carta que puntue gana",
                    "{C:chips}+#3#{} fichas para el",
                    "resto de la partida" }
            },

            j_ina_Barista = {
                name = "Barista",
                text = { "{C:wind}Master{}",
                    "La última carta jugada da",
                    "{X:chips,C:white}X2{} {C:attention}sus{} chips a mayores" }
            },

            j_ina_Builder = {
                name = "Builder",
                text = { "{C:fire}A Construir{}",
                    "Si la mano jugada contiene",
                    " {C:attention}Full{} transforma una carta",
                    "al azar en {C:attention}Acero{}",
                    "y {C:mult}destruye{} otra carta" }
            },

            -- Shuriken
            j_ina_Hood = {
                name = "Hood",
                text = {
                    "{C:forest}Jutsu de Protección{}",
                    "Gana {X:mult,C:white}X#1#{} por",
                    "cada Joker {X:gk,C:white}GK{}{}",
                    "{C:inactive}Actualmente{} {X:mult,C:white}X#2#{}"
                }
            },

            j_ina_Hillfort = {
                name = "Hillfort",
                text = { "{C:wind}Ataque de las Sombras{}", "Gana {C:chips}+X{} fichas donde {C:chips}X{} es",
                    "{C:attention}la media del valor de venta{}",
                    "de los comodines de {X:wind,C:white}viento{}",
                    "{C:inactive}Actualmente{} {C:chips}+#1#{}" }
            },

            j_ina_Code = {
                name = "Code",
                text = { "{C:mountain}Telaraña{}",
                    "Reactiva las cartas {C:attention}doradas{}",
                    "en la mano al final de la ronda",
                    "tantas veces como",
                    "jugadores del {X:shuriken,C:white}Shuriken{}" }
            },

            j_ina_Star = {
                name = "Star",
                text = { "{C:wind}Regate Múltiple{}", "Por cada carta de {C:red}diamantes{}",
                    "gana {C:money}+#1#${} y {C:mult}+#2#{} Mult", }
            },

            j_ina_Cleats = {
                name = "Cleats",
                text = { "{C:wind}Luna creciente{}",
                    "Al seleccionar la ciega",
                    "{C:green}transforma{} el jugador de",
                    "la derecha en otro",
                    "de la misma {C:green}rareza{}" }
            },

            j_ina_Hattori = {
                name = "Hattori",
                text = { "{C:forest}Remate Múltiple{}",
                    "Al seleccionar la ciega crea",
                    "{C:attention}#1#{} copias básicas",
                    "{C:dark_edition}negativas{} de si mismo.",
                    "Se destruyen al finalizar la ronda" }
            },

            j_ina_Cloack = {
                name = "Cloack",
                text = { "{C:fire}Espejismo{}", "{C:attention}Frontal{}",
                    "Al seleccionar la ciega",
                    "gasta {C:mountain}#1# Barreras{} para clonar",
                    "un joker al azar {C:dark_edition}negativo{}",
                    "perecedero con {C:attention}#2#{} rondas restantes" }
            },
            j_ina_Cloack_inf = {
                name = "Cloack",
                text = { "{C:fire}Espejismo{}", "{C:attention}Frontal{}",
                    "Al seleccionar la ciega",
                    "gasta {C:mountain}#1# Barreras{} para clonar",
                    "un joker al azar {C:dark_edition}negativo{}" }
            },

            -- Farm
            j_ina_Greeny = {
                name = "Greeny",
                text = {
                    {
                        "{C:fire}Muralla infinita{}",
                        "Genera {C:attention}#1#{} {X:mountain,C:white}barrera{} si al ",
                        "entrar en la ciega tienes {C:attention}#2#{} {X:df,C:white}DF{}"
                    },
                    {
                        "{C:attention}Diestro{}",
                        "Consume {C:attention}#3#{} {X:mountain,C:white}barreras{} para crear",
                        "una carta de {C:training}entrenamiento{} que sea",
                        "apta para un comodín cualquiera"
                    }
                }
            },

            j_ina_Hayseed = {
                name = "Hayseed",
                text = {
                    "{C:mountain}Siembra{}",
                    "Gana {C:mult}+#1#{} de multiplicador",
                    "por cada {C:attention}Trío exacto{} jugado",
                    "{C:inactive}Actualmente{} {C:mult}+#2#{} Mult"
                }
            },

            j_ina_Sherman = {
                name = "Sherman",
                text = { "{C:fire}Trama Trama{}",
                    "Gana {C:chips}+#1# Fichas{}", "cuando se activa un",
                    "jugador del {X:farm,C:white}Farm{}",
                    "{C:inactive}Actualmente{} {C:chips}+#2# Chips{}" }
            },

            j_ina_Spray = {
                name = "Spray",
                text = { "{C:fire}Superbalón rodante{}",
                    "Cuando se selecciona una {C:attention}ciega{} y",
                    "se tiene menos de {C:money}#1#${} gana {X:mult,C:white}X#2#{}",
                    "{C:inactive}Actualmente{}: {X:mult,C:white}X#3#{}" }
            },

            j_ina_Dawson = {
                name = "Dawson",
                text = { "{C:wind}Regate topo{}",
                    "Si se tiene menos de {C:money}#1#${} y",
                    "la mano jugada es {C:attention}carta alta{}",
                    "se {C:attention}duplica{} esa carta" }
            },

            j_ina_Muffs = {
                name = "Muffs",
                text = { "{C:forest}Tiro Cegador{}",
                    "Tras jugar una mano {C:attention}Siembra{}.",
                    "{C:attention}Cosechador:{} Gana {C:mult}+#1# Mult{}",
                    "{C:inactive}Actualmente{} {C:mult}+#2# Mult{}" }
            },

            j_ina_Hillvalley = {
                name = "Hillvalley",
                text = { "{C:mountain}Muralla infinita{}",
                    "Gana {C:chips}+X{} fichas permanentemente ",
                    "al anotar un {C:attention}8{}, {C:attention}9{} o {C:attention}10{} siendo {C:chips}X{} el",
                    "{C:attention}valor más alto{} entre esas cartas",
                    "{C:inactive}Actualmente{}: {C:chips}+#1#{}" }
            },

            -- Kirkwood
            j_ina_Neville = {
                name = "Neville",
                text = { "{C:fire}Bloque Dureza{}",
                    "Las cartas de {C:attention}Cristal{}",
                    "ahora se rompen {C:green}#1# de #2#{} veces" }
            },

            j_ina_Night = {
                name = "Night",
                text = { "{C:fire}Corte Giratorio{}",
                    "Al seleccionar una",
                    "ciega, genera un jugador",
                    "del {X:kirkwood,C:white}Kirkwood{}, {C:chips}Común{}, o {C:green}Poco Común{}",
                    "{C:attention}Puede generar repetidos{}",
                    "{C:inactive}Requiere espacio{}" }
            },

            j_ina_Marvin = {
                name = "Marvin",
                text = { "{C:fire}Tornado Inverso{}",
                    "{X:attention,C:white}Trillizos{}",
                    "Las cartas {C:attention}impares{}",
                    "otorgan {C:mult}+#1# Mult{}" }
            },

            j_ina_Thomas = {
                name = "Thomas",
                text = { "{C:wind}Tornado Inverso{}",
                    "{X:attention,C:white}Trillizos{}",
                    "Las cartas {C:attention}impares{}",
                    "otorgan {C:chips}+#1# Chips{}" }
            },

            j_ina_Tyler = {
                name = "Tyler",
                text = {
                    "{C:mountain}Tornado Inverso{}",
                    "{X:attention,C:white}Trillizos{}",
                    "Las cartas {C:attention}impares{}",
                    "generan un {C:tarot}tarot{} {C:green}#1# de #2# veces{}" }
            },

            j_ina_Damian = {
                name = "Damian",
                text = {
                    "{C:wind}Viento Ardiente{}",
                    "Al salir de la tienda, gana",
                    "{C:chips}+#1# Fichas{} por cada",
                    "jugador del tipo {X:fire,C:white}Fuego{} en juego",
                    "{C:inactive}Actualmente{}: {C:chips}+#2#{}" }
            },

            j_ina_Nashmith = {
                name = "Nashmith",
                text = {
                    "{C:forest}Flecha Huracán{}",
                    "Cada {C:spades}Pica{} jugada otorga",
                    "{C:chips}+#1# Fichas{} por cada",
                    "jugador de {X:forest,C:white}Bosque{}",
                }
            },

            j_ina_Z_Triangle = {
                name = "Triángulo Z",
                text = { "{C:forest}Placeholder{}", "Placeholder effect line 1", "Placeholder effect line 2" }
            },

            -- Zeus

            j_ina_Poseidon = {
                name = "Poseidon",
                text = { { "{C:mountain}Muralla Tsunami{}",
                    "Genera {C:attention}#1#{} {X:mountain,C:white}barrera{} al jugar",
                    "una mano de {C:attention}figuras{} con mínimo {C:attention}#2#{}" },
                    { "{C:attention}Frontal{}",
                        "{C:chips}+#3# Chips{} por cada {X:mountain,C:white}barrera{}",
                        "{C:mult}Gasta{} todas las {X:mountain,C:white}barreras{}",
                        "{C:inactive}Actualmente:{} {C:chips}+#4# Chips{}" } }
            },

            j_ina_Hephestus = {
                name = "Hephestus",
                text = {
                    "{C:fire}Forja Llameante{}",
                    "Al ganar la ciega convierte",
                    "una {C:attention}carta aleatoria{}",
                    "en una carta de {C:attention}Acero{}",
                    "por cada jugador de",
                    "tipo {X:fire,C:white}Fuego{} y posicion {X:df,C:white}DF{}"
                }
            },

            j_ina_Apollo = {
                name = "Apollo",
                text = {
                    "{C:forest}Resplandor Solar{}",
                    "Si juegas una mano con {C:attention}doble pareja{}",
                    "Gana {C:chips}+#1# fichas{} {C:inactive}entre las 14 y las 19 pm{}",
                    "Gana {C:chips}+#2# fichas{} {C:inactive}en caso contrario{}",
                    "{C:inactive}Actualmente{}: {C:chips}+#3#{}"
                }
            },

            j_ina_Artemis = {
                name = "Artemis",
                text = { "{C:wind}Esfera luminosa{}",
                    "Tras jugar una figura {C:attention}Siémbrala{}.",
                    "{C:attention}Cosechador:{} Gana {C:chips}+#1# Chips{}",
                    "{C:inactive}Actualmente{} {C:chips}+#2# Chips{}" }
            },

            j_ina_Hermes = {
                name = "Hermes",
                text = { "{C:forest}Oro divino",
                    "Si la primera mano",
                    "jugada es {C:attention}pareja{}",
                    "convierte la pareja",
                    "en {C:attention}cartas doradas{}" }
            },

            j_ina_Demeter = {
                name = "Demeter",
                text = {
                    "{C:fire}Gracia Ardiente{}",
                    "Otorga {C:mult}+#1# Mult{} y {C:chips}+#2# Fichas{}",
                    "por cada descarte restante",
                    "{C:inactive}Actualmente{}: {C:mult}+#3#{} {C:chips}+#4#{}"
                }
            },

            j_ina_Aphrodite = {
                name = "Aphrodite",
                text = { { "{C:forest}Sabiduría Divina{}",
                    "Al acabar una ronda",
                    "cambia al azar entre {X:fw,C:white}FW{} y {X:mf,C:white}MF{}" },
                    { "Si es {X:fw,C:white}FW{} {X:mult,C:white}X#1#{} por cada",
                        "{X:fw,C:white}FW{}, {X:zeus,C:white}Zeus{} y multiplicado por {C:mult}descartes",
                        "Si es {X:mf,C:white}MF{} {X:mult,C:white}X#2#{} por cada",
                        "{X:mf,C:white}MF{}, {X:zeus,C:white}Zeus{} y multiplicado por {C:chips}manos",
                        "{C:inactive}Actualmente{} {X:mult,C:white}X#3#{}" } },
                unlock = {
                    "Llega al ante {C:attention}9",
                },
            },

            j_ina_Athena = {
                name = "Athena",
                text = { "{C:wind}Entrada Huracán{}",
                    "Probabilidad de {C:green}#1# entre #2#{} de",
                    "convertir un joker en {C:attention}laminado{}",
                    "al finalizar la ciega{}" }
            },

            j_ina_Blazer = {
                name = "Blazer",
                text = { {
                    "{C:fire}Infierno{}",
                    "Todos los {C:attention}Jokers{}",
                    "son de {X:fire,C:white}Fuego{}",
                },
                    {
                        "Si no está en el area de juego ",
                        "devuelve todos los jugadores",
                        "a su tipo original"
                    }
                }
            },

            j_ina_Nelly = {
                name = "Nelly",
                text = { "Por cada ronda se otorga entre {C:money}#1#${} a {C:money}#2#${},",
                    "si se {C:attention}pierde la partida{}, en vez de eso,",
                    "se {C:mult}destruyen{} todos los jokers",
                    "fuera del banquillo y esta carta." }
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
            }

        },

        Other = {
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
                name = "Trillizos",
                text = { "Si tienes a {C:attention}Thomas{}",
                    "{C:attention}Tyler{} y {C:attention}Marvin{} reactiva",
                    "las cartas {C:attention}impares{}" }
            },
            Right_Footed = {
                name = "Diestro",
                text = { "Se activa si es el",
                    "joker de más a la {C:attention}Derecha{}" }
            },
            p_ina_team_pack_raimon = {
                name = "Pack Raimon",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} jugadores {X:raimon,C:white}Raimon{}" }
            },
            p_ina_team_pack_occult = {
                name = "Pack Occult",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} jugadores {X:occult,C:white}Occult{}" }
            },
            p_ina_team_pack_royal = {
                name = "Pack Royal",
                text = { "Elige {C:attention}#1#{} entre",
                    "{C:attention}#2#{} jugadores {X:royal academy,C:white}R. Academy{}" }
            },
            p_ina_team_pack_wild = {
                name = "Pack Wild",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} jugadores {X:wild,C:white}Wild{}" }
            },
            p_ina_team_pack_brain = {
                name = "Pack Brain",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} {X:brain,C:white}Brain{} jugadores" }
            },
            p_ina_team_pack_inazuma = {
                name = "Pack Inazuma",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} {X:inazuma,C:white}Inazuma{} jugadores" }
            },
            p_ina_team_pack_shuriken = {
                name = "Pack Shuriken",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} {X:shuriken,C:white}Shuriken{} jugadores" }
            },
            p_ina_team_pack_farm = {
                name = "Pack Farm",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} {X:farm,C:white}Farm{} jugadores" }
            },
            p_ina_team_pack_kirkwood = {
                name = "Pack Kirkwood",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} {X:kirkwood,C:white}Kirwood{} jugadores" }
            },
            p_ina_team_pack_zeus = {
                name = "Pack Zeus",
                text = { "Elige {C:attention}#1#{} entre", "{C:attention}#2#{} {X:zeus,C:white}Zeus{} jugadores" }
            },
            p_ina_item_pack_ina = {
                name = "Ina Pack",
                text = { "Elige {C:attention}#1#{} de {C:attention}#2#{} Cartas del {C:tarot}Tarot{}",
                    "#3# {C:strat}Strats{} o #4# {C:training}Entrenamientos{}",
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
            }
        },
        Spectral = {},
        Stake = {},
        Tag = {
            tag_ina_wild_tag = {
                name = "Etiqueta Wild",
                text = { "La tienda tiene un {C:attention}jugador gratuito{}",
                    "{C:uncommon}Poco Común{} de uno de tus equipos" }
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
                text = { "Otorga gratis un {C:training}Training Pack{}" }
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
            },
            v_ina_training = {
                name = "Entrenamiento",
                text = {
                    "{C:attention}+1{} al nivel máximo de técnica"
                },
            },
            v_ina_training_2 = {
                name = "Súper Entrenamiento",
                text = {
                    "{C:attention}+1{} al nivel máximo de técnica"
                },
            },
        }
    },
    misc = {
        achievement_descriptions = {},
        achievement_names = {},
        blind_states = {},
        challenge_names = {},
        collabs = {},
        dictionary = {
            ina_evolve_level = "¡Nivel subido!",
            ina_evolve_success = "¡Intercambio!",
            ina_val_down = "¡Drenado!",
            ina_training = "¡Cambio!",
            ina_next_match = "Siguiente",
            k_team_pack = "Pack de Equipo",
            k_item_pack = "Pack de Objetos",
            k_manager_pack = "Pack de Managers",
            ina_convert = "¡Convertido!",
            ina_potential_increased = "¡Potencial aumentado!",
            ina_sell_increased = "¡Jokers mejorados!",
            ina_divine = "¡Poder Divino!",
            ina_settings_custom_middle_blinds = "Ciegas personalizadas",
            ina_settings_middle_blinds_abilities = "Ciegas Pequeñas y Grandes con habilidades",
            ina_destroy = "¡Destruido!",
            ina_dribbling = "¡Regate!",
            ina_harvest = "Cosecha!",
            ina_seed = "Siembra!",
            ina_special_technique = "Super Técnicas",
            ina_technique_upgrade = "Técnica mejorada",
            ina_special_manager = "Gerentes",
            ina_manager_info = "Gerente",
            ina_Fire = "Fuego",
            ina_Forest = "Bosque",
            ina_Wind = "Viento",
            ina_Mountain = "Montaña",
            ina_FW = "Delantero",
            ina_MF = "Mediocentro",
            ina_DF = "Defensa",
            ina_GK = "Portero",
            ina_Technique = "Fusión",
            ina_bench = "Banquillo",
            ina_unbench = "Titular",
            ina_generate_barriers = "Barrera!",
            ina_onfire = "On fire!",
            ina_gafas = "GAFITAAAS",
            ina_saved = "Fuiste salvado",
            ina_technique_card = "¡Técnica!",
            ina_gol = "¡Gol!",



            -- Resources
            ina_resource_barriers = "Barreras",
            ina_training_upgrades = "Entrenamiento",
            ina_forms = "Formas",
            ina_team = "Equipo",

            -- Credits menu
            ina_credits = "Créditos",
            ina_thanks = "Gracias a",
            ina_lead_developer = "Desarrollador principal: ",
            ina_graphic_designers = "Diseñadores: ",
            ina_developers = "Desarrolladores: "
        },
        high_scores = {},
        labels = {
            ina_harvest_sticker = "Cosechable",
            ina_tech_plus1_sticker = "Técnica mejorada",
            ina_tech_plus2_sticker = "Técnica mejorada",
            ina_tech_plus3_sticker = "Técnica mejorada",
            ina_tech_plus4_sticker = "Técnica mejorada",
            ina_tech_number2_sticker = "Técnica mejorada",
            ina_tech_number3_sticker = "Técnica mejorada",
            ina_tech_number4_sticker = "Técnica mejorada",
            ina_tech_numbera_sticker = "Técnica mejorada",
            ina_tech_numbers_sticker = "Técnica mejorada",
            ina_tech_numberz_sticker = "Técnica mejorada",
            ina_tech_numberinf_sticker = "Técnica mejorada",
            ina_tech_grade2_sticker = "Técnica mejorada",
            ina_tech_grade3_sticker = "Técnica mejorada",
            ina_tech_grade4_sticker = "Técnica mejorada",
            ina_tech_grade5_sticker = "Técnica mejorada",
            ina_tech_grade0_sticker = "Técnica mejorada",
            ina_tech_j_sticker = "Técnica mejorada",
            ina_tech_q_sticker = "Técnica mejorada",
            ina_tech_k_sticker = "Técnica mejorada",
            ina_tech_a_sticker = "Técnica mejorada",
            ina_tech_joker_sticker = "Técnica mejorada",
        },
        poker_hand_descriptions = {
            ["ina_FullMansion"] = {
                "2 Tríos distintos",
            },
            ["ina_GodHand"] = {
                "6 cartas del mismo rango"
            }
        },
        poker_hands = {
            ["ina_FullMansion"] = "Full Mansion",
            ["ina_GodHand"] = "Mano Celestial",
        },
        quips = {},
        ranks = {},
        suits_plural = {},
        suits_singular = {},
        tutorial = {},
        v_dictionary = {
            a_powmult = { "^#1# Mult" },
            ina_idea = { "Idea: #1#" },
            ina_art = { "Arte: #1#" }
        },
        v_text = {}
    }
}
