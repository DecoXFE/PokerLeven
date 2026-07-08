return {
    Joker = {
        j_ina_Kevin = {
            name = "Kevin",
            text = { "{C:forest}Tornado Dragón{}",
                "Reactiva el {C:attention}Joker{} {X:fw,C:white}FW{}",
                "derecho cada {C:attention}#1# manos",
                "{C:inactive}#2# restantes" }
        },
        j_ina_Kevin_inf = {
            name = "Kevin",
            text = { "{C:forest}Tornado Dragón{}", "Vuelve a activar el comodín {X:fw,C:white}FW{}",
                "que está a su derecha{}" }
        },
        j_ina_Mark = {
            name = "Mark",
            text = { "{C:mountain}Mano Mágica{}",
                "{C:attention}+#1#{} al tamaño de mano jugada y de {C:red}descarte{}",
                "{C:chips}+#2#{} al tamaño de {C:chips}mano{}" }
        },
        j_ina_Nathan = {
            name = "Nathan",
            text = { "{C:wind}Entrada Huracán{}",
                "Cada {C:attention}Joker{} del {X:raimon,C:white}Raimon{}",
                "otorga {X:mult,C:white}X#2#{}" }
        },
        j_ina_Jack = {
            name = "Jack",
            text = { "{C:mountain}El Muro{}",
                "{C:attention}Las Piedras{} ganan {C:chips}+#1#{} fichas",
                "permanentemente por cada {C:attention}Joker{} {X:df,C:white}DF{}"
            }
        },
        j_ina_Axel = {
            name = "Axel",
            text = { "{C:fire}Tornado de Fuego",
                "La mano jugada obtiene {X:mult,C:white}X#1#{}",
                "si contiene {C:attention}Color{} de {C:hearts}Corazones{}" }
        },
        j_ina_Shadow = {
            name = "Shadow",
            text = { "{C:forest}Tornado Oscuro{}",
                "Si al seleccionar la ciega es",
                "el único {C:attention}Joker{}, crea una copia",
                "{C:dark_edition}negativa{} propia sin habilidades"
            }
        },
        j_ina_Shadow_clone = {
            name = "Shadow",
            text = { "Solo una {C:dark_edition}Sombra{}" }
        },
        j_ina_Willy = {
            name = "Willy",
            text = { "{C:forest}Remate gafas{}",
                "{C:green}#1# entre #2#{} de convertir la mano",
                "jugada en cartas {C:attention}policromáticas{},",
                "de {C:attention}cristal{} y con {C:attention}sello rojo{}" }
        },
        j_ina_Max = {
            name = "Max",
            text = { "{C:wind}Remate Espiral{}",
                "{C:chips}+#1#{} fichas por cada comodín de {X:wind,C:white}Viento{}",
                "{C:inactive}(Actual:{} {C:chips}+#2#{} {C:inactive}){}" }
        },
        j_ina_Peabody = {
            name = "Peabody",
            text = { "{C:mountain}Mano Celestial{}",
                "Aumenta en {C:mult}+#2#{} por cada {C:attention}carta puntuada{}",
                "en la última mano jugada",
                "{C:inactive}(Actual:{} {C:mult}+#1#{} {C:inactive}multi en tu última mano){}"
            }
        },
        j_ina_Jude_Raimon = {
            name = "Jude",
            text = { "{C:wind}Espejismo de Balón{}",
                "Gana {X:mult,C:white}X#2#{} cada vez que el {C:attention}Joker",
                "a su {C:attention}izquierda{} se activa",
                "{C:inactive}(Actual:{} {X:mult,C:white}X#1#{}{C:inactive}){}"
            }
        },
        j_ina_Bobby = {
            name = "Bobby",
            text = { { "{C:forest}El Traidor{}",
                "Al seleccionar la ciega, cambia",
                "a tu equipo más numeroso", },
                { "Los jugadores del equipo",
                    "de {C:attention}Bobby{} otorgan {C:chips}+#1# Chips{}", } }
        },
        j_ina_Erik = {
            name = "Erik",
            text = { "{C:forest}Tri-Pegaso{}",
                "{C:tarot}El Mago{} cambia su efecto y",
                "pasa a otorgar {C:attention}2 sellos{} al azar", }
        },
        j_ina_Steve = {
            name = "Steve",
            text = { "{C:wind}Disparo Rodante{}",
                "Cada {C:attention}Joker{} del {X:raimon,C:white}Raimon{} otorga {C:chips}+#1#{} y {C:mult}+#2#{}",
                "Obtiene {C:money}+#3#${} al terminar la ronda",
                "{C:inactive}(Actual: {C:chips}+#4#{} {C:inactive}y{} {C:mult}+#5#{}{C:inactive}){}",
            }
        },
        j_ina_Jim = {
            name = "Jim",
            text = { "{C:wind}Giro bobina{}",
                "Gana {C:chips}+#1#{} fichas",
            }
        },
        j_ina_Tod = {
            name = "Tod",
            text = {
                "{C:wind}Equilibrismo{}",
                "Gana {C:chips}+#1#{} fichas por",
                "cada {C:enhanced}Acero{}",
                "en {C:attention}mano{} o {C:attention}jugada{}"
            }
        },
        -- Occult
        j_ina_Talisman = {
            name = "Talisman",
            text = { "{C:forest}Rapto Divino{}",
                "Reactiva el {C:attention}Joker{} {X:occult,C:white}Occult{}",
                "a su derecha {C:attention}#1# veces{}",
            }
        },
        j_ina_Wolfy = {
            name = "Wolfy",
            text = { "{C:fire}Luna creciente{}",
                "Gana {X:mult,C:white}X#2#{} por cada",
                "{C:tarot}La Luna{} usada",
                "{C:inactive}(Actual {X:mult,C:white}X#1#{}{C:inactive}){}",
            }
        },
        j_ina_Blood = {
            name = "Blood",
            text = { "{C:mountain}Niebla Venenosa{}",
                "{C:attention}Drena{} {C:money}#1#${} de los {C:attention}Jokers{} adyacentes,",
                "Cada {C:money}1${} en su valor de venta obtiene {C:chips}+#2#{} fichas",
                "{C:inactive}(Actual{} {C:chips}+#3#{}{C:inactive}){}" }
        },
        j_ina_Grave = {
            name = "Grave",
            text = { "{C:fire}Maldición{}", "{C:green}#1# en #2#{} de crear una carta",
                "{C:tarot}Muerte{} por cada {C:attention}6{} anotado" }
        },
        j_ina_Mask = {
            name = "Mask",
            text = { "{C:wind}Cuchilla Asesina{}",
                "Al seleccionar la ciega se",
                "sacrifica el {C:attention}Joker{} de su derecha",
                "y gana {C:money}+#1#${} de valor de venta", }
        },
        j_ina_Styx = {
            name = "Styx",
            text = { "{C:forest}Tiro Fantasma{}",
                "{C:chips}+#2#{} fichas por cada carta {C:tarot}Tarot{} usada",
                "{C:inactive}(Actual:{} {C:chips}+#1#{}{C:inactive}){}",
            }
        },
        j_ina_Franky = {
            name = "Franky",
            text = { "{C:mountain}Mega Terremoto{}", "{C:attention}Carta alta{} otorga", "{C:mult}+#1#{} de multi" }
        },
        j_ina_Mummy = {
            name = "Mummy",
            text = { "{C:forest}Gravedad{}", "Cada {C:clubs}#3#{} otorga", "{C:mult}+#1#{} Mult y {C:chips}+#2#{} Chips" }
        },
        j_ina_King = {
            name = "King",
            text = { "{C:fire}Escudo de Fuerza{}",
                "Copia el rey {C:attention}derecho{} al",
                "jugar una mano que contenga",
                "un {C:attention}Trío{} de {C:attention}Reyes{}", }
        },
        j_ina_Bloom = {
            name = "Bloom",
            text = { "{C:fire}Chut de los 100 toques{}",
                "{X:mult,C:white}X#1#{} si juegas {C:attention}Escalera{} tras",
                "haber jugado {C:attention}100{} cartas",
                "{C:inactive}(Actual:{} {C:mult}#2#{} {C:inactive}jugadas){}" }
        },
        j_ina_Drent = {
            name = "Drent",
            text = { "{C:mountain}Terremoto{}",
                "{C:green}#1# en #2#{} de crear {C:tarot}La Torre{}",
                "después de cada {C:attention}mano{} jugada.",
                "Cada {C:attention}Joker{} {X:mountain,C:white}Montaña{} lo mejora en {C:green}1{}" }
        },
        j_ina_Jude = {
            name = "Jude",
            text = { "{C:wind}Espejismo de Balón{}",
                "Gana {X:mult,C:white}X#2#{} cada vez que el {C:attention}Joker",
                "a su {C:attention}izquierda{} se activa",
                "{C:inactive}(Actual:{} {X:mult,C:white}X#1#{}{C:inactive}){}"
            }
        },
        j_ina_Martin = {
            name = "Martin",
            text = { "{C:forest}Barrido Defensivo{}", "Los comodines {C:blue}Comunes{} otorgan {C:mult}+#1#{} Mult",
                "Los comodines {C:green}Inusuales{} otorgan {C:mult}+#2#{} Mult",
                "Los comodines {C:red}Raros{} o {C:top}Destacados{} otorgan {X:mult,C:white}X#3#{} Mult",
                "Los comodines {C:purple}Legendarios{} otorgan {X:dark_edition,C:white}^#4#{} Mult" }
        },
        j_ina_Master = {
            name = "Master",
            text = { "{C:wind}Coz{}",
                "Si es el primer {C:attention}Joker{} a la izquierda,",
                "gana {C:mult}+#1#{} de multi por cada {X:royal academy,C:white}Acad. Royal{}", }
        },
        j_ina_Samford = {
            name = "Samford",
            text = { "{C:forest}Pingüino Emperador N.º 2{}", "{X:mult,C:white}X#1#{} multi si hay",
                "{C:attention}1{} {X:mf,C:white}MF{} y {C:attention}2{} {X:fw,C:white}FW{}" }
        },
        j_ina_Swing = {
            name = "Swing",
            text = { "{C:wind}Regate Multiple{}",
                "Al jugar {C:attention}Trío{} gana {C:chips}+#1#{} fichas",
                "por cada {C:attention}Joker{} de la {X:royal academy,C:white}Acad. Royal{}", }
        },
        j_ina_Chicken = {
            name = "Chicken",
            text = { "{C:fire}Huevo Dorado{}", "Las cartas {C:enhanced}Versátiles{} tienen",
                "{C:green}#1# de #2#{} de ganar {C:money}#3#${} al puntuar" }
        },
        j_ina_Boar = {
            name = "Boar",
            text = { "{C:fire}Garra Salvaje{}", "Al jugar una {C:attention}pareja de 2s{} se",
                "destruyen y genera una {C:attention}Etiqueta Wild{}" }
        },
        j_ina_Chamaleon = {
            name = "Chamaleon",
            text = { "{C:wind}Espejismo{}",
                "Permite jugar {C:attention}Color{} con 4 cartas",
                "Al jugarse otra, se transforma en {C:enhanced}Versátil", }
        },
        j_ina_Eagle = {
            name = "Eagle",
            text = { "{C:wind}Ataque de Cóndor{}",
                "Adquiere {C:mult}+#1#{} de multi por cada carta",
                "{C:enhanced}versátil{} puntuada en un {C:attention}Color",
                "{C:inactive}(Actual:{} {C:mult}+#2#{}{C:inactive}){}" }
        },
        j_ina_Monkey = {
            name = "Monkey",
            text = { "{C:wind}Giro del Mono{}",
                "Obtén {X:mult,C:white}XMult{} por {C:enhanced}cartas versátiles{}",
                "en el mazo, multiplicado por {X:wild,C:white}Wild{} / 10",
                "{C:inactive}(Actual: {X:mult,C:white}X#1#{}{C:inactive}){}" }
        },
        j_ina_Gorilla = {
            name = "Gorilla",
            text = { "{C:mountain}Remate Tarzán{}", "Crea una {C:attention}Etiqueta Wild{}",
                "al derrotar a la {C:attention}Ciega Jefe{}" }
        },
        j_ina_Cheetah = {
            name = "Cheetah",
            text = { "{C:wind}Superaceleración{}",
                "Al puntuar 5 cartas {C:enhanced}versátiles{} se",
                "reactivan por cada {C:attention}Joker{} de {X:select_element,C:white}#1#{}",
                "{C:inactive}El elemento cambia cada ronda{}" }
        },
        j_ina_Feldt = {
            name = "Feldt",
            text = { {
                "{C:forest}Campo de Fuerza Defensivo{}",
                "Genera {C:attention}#1#{} {X:mountain,C:white}Barrera{}",
                "si la mano contiene {C:attention}3{} {C:spades}Picas{}"
            },
                {
                    "En la {C:attention}última mano{} consume",
                    "todas las {X:mountain,C:white}Barreras{} para",
                    "dar {X:mult,C:white}X#2#{} por {C:attention}Joker de {X:forest,C:white}Bosque{}",
                    "{C:inactive}(Actual:{} {X:mult,C:white}X#3# {C:inactive}){}"
                }
            }
        },
        j_ina_Feldt_n3 = {
            name = "Feldt",
            text = { {
                "{C:forest}Campo de Fuerza Defensivo{}",
                "Genera {C:attention}#1#{} {X:mountain,C:white}Barrera{}",
                "si juegas al menos {C:attention}3{} {C:spades}Picas{}"
            },
                {
                    "En la {C:attention}última mano{} consume",
                    "{C:attention}#4# {X:mountain,C:white}Barreras{} para dar {X:mult,C:white}X#2#{}",
                    "por cada {C:attention}Joker{} de {X:forest,C:white}Bosque{}",
                    "{C:inactive}Actualmente{} {X:mult,C:white}X#3#"
                }
            }
        },

        j_ina_Marvel = {
            name = "Marvel",
            text = { "{C:mountain}Escaner Defensa", "Si el valor en {C:chips}fichas{}",
                "de la carta que puntua",
                "tiene {C:attention}exactamente 3 bits en 1{}",
                "{C:mult}+#1#{} de multi" }
        },

        j_ina_Tell = {
            name = "Tell",
            text = { "{C:forest}Adivino{}", "{X:chips,C:white}XPI{} si tienes {C:attention}3 1 4{} en",
                "la mano trasera al puntuar" }
        },

        j_ina_Seller = {
            name = "Seller",
            text = { "{C:wind}Psicorremate{}", "Tras cada ronda jugada",
                "gana {C:money}+#2#$ de potencial de venta{}.", "Cuando se venda Seller, aumenta",
                "el {C:money}valor de venta{} de otros jokers", "por su potencial de venta",
                "{C:inactive}(Actual:{} {C:money}#1#${}{C:inactive}){}" }
        },

        j_ina_Kind = {
            name = "Kind",
            text = { "{C:forest}Escaner ataque{}", "Si la mano jugada es un {C:attention}palíndromo{},",
                "reactiva la primera y la última carta." }
        },

        j_ina_Turner = {
            name = "Turner",
            text = { "{C:fire}Tornado de fuego{}",
                "Si la mano contiene un {C:attention}póker{}, se crea una copia",
                "de la primera carta puntuada por cada {X:brain,C:white}Brain{}" }

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
                "{C:green}#1# de #2#{} veces" }
        },

        j_ina_Hero = {
            name = "Hero",
            text = { "{C:fire}Bola falsa{}", "Transforma cada carta",
                "{C:attention}figura{} puntuada en un {C:attention}4{}" }
        },

        j_ina_Custom = {
            name = "Custom",
            text = { "{C:wind}Ciclón{}", "Los {C:attention}Jokers{} de {X:wind,C:white}Viento{} pueden", "aparecer múltiples veces" }
        },

        j_ina_Robot = {
            name = "Robot",
            text = { "{C:wind}Confusión{}",
                "Reactiva las {C:gold}Cartas de la Suerte{} en",
                "{C:attention}Escalera{} que coincidan en posición con ",
                "cada {X:mf,C:white}MF{} empezando por la izquierda" }
        },

        j_ina_Gamer = {
            name = "Gamer",
            text = { "{C:fire}Bateo Total{}",
                "Ganas {C:chips}fichas{} por tus {C:attention}FPS / 2{}",
                "Pasa a ser {C:attention}FPS{} con 2 Jokers del ",
                "{X:otaku,C:white}Otaku{} y valor máximo de {C:attention}144 FPS{}",
                "{C:inactive}(Actual:{} {C:chips}+#1#{}{C:inactive}){}" }
        },

        j_ina_Artist = {
            name = "Artista",
            text = { "{C:wind}Ludopatía Máxima{}", "Si la mano jugada puntúa un {C:attention}Rey{}",
                " y {C:attention}Reina{} convierte toda la mano",
                " puntuada en {C:gold}Cartas de la Suerte{}" }
        },

        j_ina_Arcade = {
            name = "Arcade",
            text = { "{C:forest}Tiro del Cometa{}",
                "{C:green}#1# en 15{} de ganar {C:money}$20{}",
                "en una {C:gold}Carta de la Suerte{}",
                "{C:inactive}Jugarlas cuesta{} {C:money}#2#${}", }
        },

        j_ina_Vox = {
            name = "Vox",
            text = {
                "{C:wind}Segundón Resonante{}",
                "{C:attention}Diestro{}",
                "Gana {C:chips}+#1#{} fichas por",
                "cada {C:attention}Joker{} a su izquierda"
            }
        },

        -- Inazuma Eleven
        j_ina_Hillman = {
            name = "Hillman",
            text = { "{C:mountain}Restaurante Ray Ray{}",
                "Gana {X:chips,C:white}X#1#{} fichas por",
                "{C:pink}Strat{} usada esta partida",
                "{C:inactive}(Actual:{} {X:chips,C:white}X#2#{}{C:inactive}){}" }
        },
        -- Tormenta de Géminis
        j_ina_Janus = {
            name = "Janus",
            text = { "{C:forest}Astro Remate{}", 
                "Empieza con {X:mult,C:white}X1{} Multi",
                "Gana {X:mult,C:white}X#2#{} Multi por cada",
                "{C:planet}Planeta{} usado esta partida",
                "{C:inactive}(Actual:{} {X:mult,C:white}X#1#{}{C:inactive}){}" 
            },
            unlock = { "Usa {C:attention}25 cartas de Planeta{}", "{C:inactive}(#1#/#2#){}" }
        },
        j_ina_Galileo = {
            name = "Galileo",
            text = { "{C:forest}Agujero Negro{}", 
                "Gana {C:mult}+#1#{} Multi por cada",
                "carta {C:attention}destruida{}",
                "{C:inactive}(Actual:{} {C:mult}+#2#{}{C:inactive}){}" 
            },
            unlock = { "Destruye {C:attention}100 cartas{} en total", "{C:inactive}(#1#/#2#){}" }
        },
        j_ina_Pandora = {
            name = "Pandora",
            text = { "{C:wind}Disparo Fantasma{}", 
                "Al destruir una carta jugada, {C:green}#3# en #2#{} de",
                "crear un {C:planet}Planeta{}. La probabilidad",
                "aumenta por cada Joker de {C:wind}Viento{}.",
                "Si es {C:attention}100% o más{}, crea un {C:dark_edition}Planeta Negativo{}"
            },
            unlock = { "Usa {C:attention}4 cartas de Planeta{} en una sola ronda" }
        },
        j_ina_Diam = {
            name = "Diam",
            text = { "{C:forest}Remate de Fotones{}", 
                "Al puntuar, destruye {C:attention}1 carta{} de tu mano",
                "por cada Joker del {C:tormenta de géminis}Tormenta de Géminis{}.",
                "Gana {C:chips}+#1#{} Fichas por carta destruida {C:attention}esta mano{}."
            }
        },
        j_ina_Rihm = {
            name = "Rihm",
            text = { "{C:forest}Remate de Seguridad{}", 
                "{C:green}#1# en #2#{} de destruir las cartas",
                "puntuadas de la {C:attention}Mano Ganadora{}"
            },
            unlock = { "Destruye {C:attention}5 o más cartas{}", "en una sola mano" }
        },
        j_ina_Grengo = {
            name = "Grengo",
            text = { "{C:mountain}Explosión Universal{}", 
                "Gana {C:chips}+#1#{} Fichas por cada carta",
                "que falte en tu mazo (menos de 52)",
                "{C:inactive}(Actual:{} {C:chips}+#2#{}{C:inactive}){}"
            },
            unlock = { "Gana una partida con {C:attention}20 cartas o menos{}", "en tu mazo" }
        },
        j_ina_Io = {
            name = "Io",
            text = { "{C:fire}Orbe de Fuego{}", 
                "Gana {C:chips}+#1#{} Fichas por cada",
                "Joker de {C:fire}Fuego{} que tengas",
                "{C:inactive}(Actual:{} {C:chips}+#2#{}{C:inactive}){}"
            },
            unlock = { "Ten {C:attention}3 Comodines de Fuego{} simultáneamente" }
        },
        j_ina_Charon = {
            name = "Charon",
            text = { "{C:fire}Fotón Flash{}", 
                "Al jugar {C:attention}Color{}, destruye la carta",
                "más a la derecha de la mano y otorga {C:mult}+#1#{} Multi"
            },
            unlock = { "Juega un {C:attention}Color{} con", "3 o más {C:hearts}Corazones{}" }
        },
        j_ina_Gigs = {
            name = "Gigs",
            text = { "{C:fire}Robo Ígneo{}", 
                "Si tienes otro Joker de {C:fire}Fuego{},",
                "reactiva la primera carta jugada {C:attention}#1#{} vez/veces"
            },
        },
        j_ina_Ganymede = {
            name = "Ganymede",
            text = { "{C:mountain}Gravitación{}",
                "Si tienes otro Joker de {C:mountain}Montaña{},",
                "previene la muerte una vez ({C:red}se destruye{})"
            },
            unlock = { "Gana una ronda con {C:attention}0 cartas{} en tu mano" }
        },
        j_ina_Ganymede_1 = {
            name = "Ganymede",
            text = { "{C:mountain}Gravitación{}",
                "Si tienes otro Joker de {C:mountain}Montaña{},",
                "previene la muerte una vez ({C:red}se destruye{}).",
                "Da {C:money}$#1#{}{} al morir"
            },
        },
        j_ina_Coral = {
            name = "Coral",
            text = { "{C:wind}Defensa Coral{}", 
                "{C:mult}+#1#{} Multi si la mano jugada tiene",
                "{C:attention}3 cartas o menos{}.",
                "Se duplica si tienes otro Joker {X:df,C:white}DF{}"
            },
            unlock = { "Gana una ronda jugando sólo manos", "de {C:attention}3 cartas o menos{}" }
        },

        j_ina_Island = {
            name = "Island",
            text = { "{C:forest}Zig zag chispeante{}",
                "Gana {C:chips}+#1#{} fichas si la mano",
                "jugada contiene {C:attention}doble pareja{}",
                "{C:inactive}(Actual:{} {C:chips}+#2#{}{C:inactive}){}" }
        },

        j_ina_Sweet = {
            name = "Sweet",
            text = { "{C:mountain}Reclutamiento{}",
                "Al seleccionar la ciega crea un {C:attention}Joker{}",
                "{C:chips}Común{} o {C:green}Inusual{} del {X:raimon,C:white}Raimon{} o {X:inazuma_eleven,C:white}I.Eleven{}",
                "{C:inactive}Debe haber espacio{}" }
        },

        j_ina_Butler = {
            name = "Butler",
            text = { "{C:forest}Rentista{}",
                "Adquiere hasta {C:money}-#1#${} de deuda",
                "Cada carta que puntúe gana {C:chips}+#3#{} fichas",
                "por cada {C:money}-#2#${} para el resto de partida", }
        },

        j_ina_Barista = {
            name = "Barista",
            text = { "{C:wind}Pase Cruzado{}",
                "La última carta jugada da",
                "{X:chips,C:white}X#1#{} chips a mayores" }
        },

        j_ina_Builder = {
            name = "Builder",
            text = { "{C:fire}Pájaro de Fuego{}",
                "Si la mano contiene {C:attention}Full{},",
                "transforma una carta al azar",
                "en {C:enhanced}Acero{} y {C:red}destruye{} otra", }
        },

        -- Shuriken
        j_ina_Hood = {
            name = "Hood",
            text = {
                "{C:forest}Torbellino{}",
                "Gana {X:mult,C:white}X#1#{} por",
                "cada Joker {X:gk,C:white}GK{}{}",
                "{C:inactive}(Actual:{} {X:mult,C:white}X#2#{}{C:inactive}){}"
            }
        },

        j_ina_Hillfort = {
            name = "Hillfort",
            text = { "{C:wind}Ataque de las Sombras{}",
                "Al seleccionar la ciega gana",
                "{C:chips}+#1#{} fichas por cada {C:money}#2#${} de valor de",
                "venta de los {C:attention}Jokers{} de {X:wind,C:white}Viento{}",
                "{C:inactive}(Actual:{} {C:chips}+#3#{}{C:inactive}){}" }
        },

        j_ina_Code = {
            name = "Code",
            text = { "{C:mountain}Telaraña{}",
                "Reactiva las cartas {C:attention}doradas{} al final de",
                "la ronda por cada {C:attention}Joker{} del {X:shuriken,C:white}Shuriken{}", }
        },

        j_ina_Star = {
            name = "Star",
            text = { "{C:wind}Regate Múltiple{}", "Por cada carta de {C:red}diamantes{}",
                "gana {C:money}+#1#${} y {C:mult}+#2#{} de multi", }
        },

        j_ina_Cleats = {
            name = "Cleats",
            text = { "{C:wind}Luna creciente{}",
                "Al seleccionar la ciega",
                "{C:green}transforma{} el {C:attention}Joker derecho{}",
                "en otro de la misma {C:green}rareza"
            }
        },

        j_ina_Hattori = {
            name = "Hattori",
            text = { "{C:forest}Remate Múltiple{}",
                "Al seleccionar la ciega crea",
                "{C:attention}#1#{} copias {C:dark_edition}negativas{} propias.",
                "Se destruyen al finalizar la ronda" }
        },

        j_ina_Cloack = {
            name = "Cloack",
            text = { "{C:fire}Espejismo{}", "{C:attention}Frontal{}",
                "Al seleccionar la ciega clona",
                "un joker {C:dark_edition}negativo{} perecedero",
                "({C:attention}#2#{} rondas) gastando {C:mountain}#1# Barreras{}" },
        },
        j_ina_Cloack_inf = {
            name = "Cloack",
            text = { "{C:fire}Espejismo{}", "{C:attention}Frontal{}",
                "Al seleccionar la ciega",
                "clona un joker {C:dark_edition}negativo{}",
                "gastando {C:mountain}#1# Barreras{}" },
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
                    "Crea una carta de {C:training}entrenamiento{} apta",
                    "a un {C:attention}Joker{} consumiendo {C:attention}#3#{} {X:mountain,C:white}barreras{}",
                }
            }
        },

        j_ina_Hayseed = {
            name = "Hayseed",
            text = {
                "{C:mountain}Siembra{}",
                "Gana {C:mult}+#1#{} de multi por",
                "cada {C:attention}Trío exacto{} jugado",
                "{C:inactive}(Actual:{} {C:mult}+#2#{}{C:inactive}){}"
            }
        },

        j_ina_Sherman = {
            name = "Sherman",
            text = { "{C:fire}Trama Trama{}",
                "Gana {C:chips}+#1#{} fichas", "cuando se activa un",
                "{C:attention}Joker{} del {X:farm,C:white}Farm{}",
                "{C:inactive}(Actual:{} {C:chips}+#2#{}{C:inactive}){}" }
        },

        j_ina_Spray = {
            name = "Spray",
            text = { "{C:fire}Superbalón rodante{}",
                "Al seleccionar una {C:attention}ciega{}",
                "con {C:money}<#1#${} gana {X:mult,C:white}X#2#{}",
                "{C:inactive}(Actual:{} {X:mult,C:white}X#3#{}{C:inactive}){}" }
        },

        j_ina_Dawson = {
            name = "Dawson",
            text = { "{C:wind}Regate topo{}",
                "Al jugar {C:attention}carta alta{} con {C:money}<#1#${}",
                "se duplica dicha carta" }
        },

        j_ina_Muffs = {
            name = "Muffs",
            text = { "{C:forest}Tiro Cegador{}",
                "Tras jugar una mano {C:attention}Siembra{}.",
                "{C:attention}Cosechador:{} Gana {C:mult}+#1#{} de multi",
                "{C:inactive}(Actual:{} {C:mult}+#2#{}{C:inactive}){}" }
        },

        j_ina_Hillvalley = {
            name = "Hillvalley",
            text = { "{C:mountain}Muralla infinita{}",
                "Gana {C:chips}+X{} fichas permanentemente ",
                "al anotar un {C:attention}8{}, {C:attention}9{} o {C:attention}10{} siendo {C:chips}X{} el",
                "{C:attention}valor{} de esas cartas",
                "{C:inactive}(Actual:{} {C:chips}+#1#{}{C:inactive}){}" }
        },

        -- Kirkwood
        j_ina_Neville = {
            name = "Neville",
            text = { "{C:fire}Bloque Dureza{}",
                "Las cartas de {C:attention}Cristal{}",
                "se rompen {C:green}#1# de #2#{} veces" }
        },

        j_ina_Night = {
            name = "Night",
            text = { "{C:fire}Corte Giratorio{}",
                "Al elegir una ciega, genera un",
                "{C:attention}Joker{} del {X:kirkwood,C:white}Kirkwood{}: {C:chips}Común{} o {C:green}Inusual{}",
                "{C:attention}Puede generar repetidos{}",
                "{C:inactive}Requiere espacio{}" }
        },

        j_ina_Marvin = {
            name = "Marvin",
            text = { "{C:fire}Tornado Inverso{}",
                "{X:attention,C:white}Trillizos{}",
                "Las cartas {C:attention}impares{}",
                "otorgan {C:mult}+#1#{} de multi" }
        },

        j_ina_Thomas = {
            name = "Thomas",
            text = { "{C:wind}Tornado Inverso{}",
                "{X:attention,C:white}Trillizos{}",
                "Las cartas {C:attention}impares{}",
                "otorgan {C:chips}+#1#{} fichas" }
        },

        j_ina_Tyler = {
            name = "Tyler",
            text = {
                "{C:mountain}Tornado Inverso{}",
                "{X:attention,C:white}Trillizos{}",
                "Las cartas {C:attention}impares{} generan",
                "un {C:tarot}tarot{} {C:green}#1# de #2# veces{}" }
        },

        j_ina_Damian = {
            name = "Damian",
            text = {
                "{C:wind}Luna Creciente{}",
                "Al salir de la tienda, gana {C:chips}+#1# fichas{}",
                " por cada {C:attention}Joker{} de {X:fire,C:white}Fuego{} en juego",
                "{C:inactive}(Actual:{} {C:chips}+#2#{}{C:inactive}){}" }
        },

        j_ina_Nashmith = {
            name = "Nashmith",
            text = {
                "{C:forest}Potenciación{}",
                "Cada {C:spades}Pica{} jugada otorga",
                "{C:chips}+#1#{} fichas por cada",
                "{C:attention}Joker{} de {X:forest,C:white}Bosque{}",
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
                "Genera {C:attention}#1#{} {X:mountain,C:white}barrera{} al puntuar",
                "un mínimo de {C:attention}#2#{} de {C:attention}figuras{}" },
                { "{C:attention}Muralla Gigante{}",
                    "{{C:mult}Consume{} todas las {X:mountain,C:white}barrera{}",
                    "y otorga {C:chips}+#3# Chips{} por cada una",
                    "{C:inactive}(Actual:{} {C:chips}+#4#{}{C:inactive}){}" } }
        },

        j_ina_Hephestus = {
            name = "Hephestus",
            text = {
                "{C:fire}Entrada Tormenta{}",
                "Al ganar la ciega convierte ",
                "una {C:attention}Carta{} en {C:enhanced}Acero{} por",
                "cada {C:attention}Joker{} {X:fire,C:white}Fuego{} {X:df,C:white}DF{}"
            }
        },

        j_ina_Apollo = {
            name = "Apollo",
            text = {
                "{C:forest}Hora Celestial{}",
                "Al jugar {C:attention}doble pareja{} gana {C:chips}+#2# fichas{}",
                "{C:inactive}De 14:00 a 19:00h:{} gana {C:chips}+#1# fichas{} y {C:mult}+#4# multi{}",
                "{C:inactive}(Actual:{} {C:chips}+#3#{} {C:inactive}y{} {C:mult}+#5#{}{C:instead}{C:inactive}){}"
            }
        },

        j_ina_Artemis = {
            name = "Artemis",
            text = { "{C:wind}Flecha Divina{}",
                "Tras jugar una figura {C:attention}Siémbrala{}.",
                "{C:attention}Cosechador:{} Gana {C:chips}+#1#{} fichas",
                "{C:inactive}(Actual:{} {C:chips}+#2#{}{C:inactive}){}" }
        },

        j_ina_Hermes = {
            name = "Hermes",
            text = { "{C:forest}Oro divino",
                "Si la primera mano jugada es {C:attention}pareja{}",
                "la convierte en {C:gold}cartas de oro{}" }
        },

        j_ina_Demeter = {
            name = "Demeter",
            text = {
                "{C:fire}Disparo con Rebotes{}",
                "Otorga {C:mult}+#1#{} de multi y {C:chips}+#2#{} fichas",
                "por cada descarte restante",
                "{C:inactive}(Actual:{} {C:mult}+#3#{} {C:inactive}y{} {C:chips}+#4#{}{C:inactive}){}"
            }
        },

        j_ina_Aphrodite = {
            name = "Aphrodite",
            text = { { "{C:forest}Sabiduría Divina{}",
                "Al acabar una ronda",
                "cambia entre {X:fw,C:white}FW{} y {X:mf,C:white}MF{}",
                "según venga mejor" },
                { "Si es {X:fw,C:white}FW{} {X:mult,C:white}X#1#{} por cada",
                    "{X:fw,C:white}FW{}, {X:zeus,C:white}Zeus{} y multiplicado por {C:mult}descartes",
                    "Si es {X:mf,C:white}MF{} {X:mult,C:white}X#2#{} por cada",
                    "{X:mf,C:white}MF{}, {X:zeus,C:white}Zeus{} y multiplicado por {C:chips}manos",
                    "{C:inactive}Actualmente{} {X:mult,C:white}X#3#{}" } },
            unlock = {
                "Llega al ante {C:attention}9",
            },
        },

                j_ina_Hadrian_Diesel = {
            name = "Hades",
            text = { {
                "{C:wind}Subida al cielo{}",
                "Un {C:attention}#1#%{} de las {C:chips}fichas{} obtenidas se convierten",
                "en {C:mult}multi{} mientras está {C:attention}activo{}"
            } }
        },

        j_ina_Percy_Hurst = {
            name = "Perseus",
            text = { {
                "{C:wind}Sierra celestial{}",
                "Cada mano consecutiva con {C:attention}>=2 cartas{} de {C:hearts}corazones{}",
                "acumula {C:mult}+#1# mult{}, si falla {C:attention}#2# mano/s{} se resta {C:mult}#3#% mult{}",
                "{C:inactive}(Actual:{} {C:mult}+#4# mult{}{C:inactive}){}" 
            } }
        },

        j_ina_Ace_Server = {
            name = "Ace Server",
            text = { {
                "{C:fire}Puño vengativo{}",
                "{C:green}1 en #1# {}de aumentar el",
                "nivel de la mano jugada",
                "{C:attention}#2# nivel{} si {C:attention}#3# Ases{} puntúan."
            } }
        },

        j_ina_Blazer = {
            name = "Blazer",
            text = { {
                "{C:purple}Carga elemental{}",
                "Todos los {C:attention}Jokers{} son de {X:fire,C:white}Fuego{}",
                "Solo funciona el elemental {C:attention}izquierdo",
            },
                {
                    "Se revierte fuera del área de juego",
                    "{C:inactive}Funciona aún {C:mult}deshabilitado{}{}"
                }
            }
        },

        j_ina_Weathervane = {
            name = "Weathervane",
            text = { {
                "{C:purple}Carga elemental{}",
                "Todos los {C:attention}Jokers{} son de {X:wind,C:white}Viento{}",
                "Solo funciona el elemental {C:attention}izquierdo"
            },
                {
                    "Se revierte fuera del área de juego",
                    "{C:inactive}Funciona aún {C:mult}deshabilitado{}{}"
                }
            }
        },

        j_ina_Noggin = {
            name = "Noggin",
            text = { {
                "{C:purple}Carga elemental{}",
                "Todos los {C:attention}Jokers{} son de {X:forest,C:white}Bosque{}",
                "Solo funciona el elemental {C:attention}izquierdo"
            },
                {
                    "Se revierte fuera del área de juego",
                    "{C:inactive}Funciona aún {C:mult}deshabilitado{}{}"
                }
            }
        },

        j_ina_Montayne = {
            name = "Montayne",
            text = { {
                "{C:purple}Carga elemental{}",
                "Todos los {C:attention}Jokers{} son de {X:mountain,C:white}Montaña{}",
                "Solo funciona el elemental {C:attention}izquierdo"
            },
                {
                    "Se revierte fuera del área de juego",
                    "{C:inactive}Funciona aún {C:mult}deshabilitado{}{}"
                }
            }
        },

        j_ina_Dulce = {
            name = "Dulce",
            text = {
                "{C:wind}Viento de cosecha{}",
                "Siembra {C:attention}#1#{} carta/s al azar por cada",
                "{C:attention}Joker {X:mf,C:white}MF{} ó {X:wind,C:white}Viento{} al elegir la ciega",
            }
        },

        j_ina_Ryoma = {
            name = "Ryoma",
            text = {
                "{C:mountain}Parada Infinita{}",
                "Gana {C:mult}+#1#{} de multi cada vez",
                "que se activa un {X:gk,C:white}GK{}",
                "{C:inactive}(Actual:{} {C:mult}+#2#{}{C:inactive}){}"
            }
        },

        j_ina_Mach = {
            name = "Mach",
            text = {
                "{C:fire}Chut Granada{}",
                "Gana {X:mult,C:white}X#1#{} al vender",
                "un {C:attention}Joker {}o {C:attention}Mánager{}",
                "{C:inactive}(Actual:{} {X:mult,C:white}X#2#{}{C:inactive}){}"
            }
        },

        j_ina_Rex_George = {
            name = "Rex George",
            text = { {
                "{C:wind}Hojarasca{}",
                "Convierte los {C:attention}#1#{}",
                "puntuados en {C:attention}#2#s{}",
            } }
        },

        -- GANADORES DE TORNEO
        j_ina_Turi = {
            name = "Turiño",
            text = { { "{C:forest}Remate Rebotado{}",
                "Gana {X:dark_edition,C:white}^X#2#{} por cada",
                "{C:attention}#3#{} {C:tarot}Tarots{} de {C:suits}Palo{} usados",
                "{C:inactive}(Actual:{} {X:mult,C:white}X#1#{}, {C:tarot}#4#{} {C:inactive}usados){}" }, }
        },

        -- GERENTES
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
        j_ina_Chester = {
            name = "Chester",
            text = {
                "Puedes ver las próximas {C:tarot}#1#{}",
                "cartas que van a salir"
            }
        },
        j_ina_Akihiro = {
            name = "Akihiro Hino",
            text = {
                "{C:dark_edition,E:1}Por favor espere un poco más{}"
            }
        },

    },
}
