C = {}

-- Seals
C.SEALS = { 'Blue', 'Red', 'Gold', 'Purple' }

-- Types
C.ALL_TYPES = { "Wind", "Fire", "Forest", "Mountain" }
C.Wind = C.ALL_TYPES[1]
C.Fire = C.ALL_TYPES[2]
C.Forest = C.ALL_TYPES[3]
C.Mountain = C.ALL_TYPES[4]

C.STICKERS = {}
C.STICKERS.types = { "wind_sticker", "fire_sticker", "forest_sticker", "mountain_sticker" }
C.STICKERS.positions = { "fw_sticker", "mf_sticker", "gk_sticker", "df_sticker" }

-- Positions
C.ALL_POSITIONS = { "FW", "MF", "DF", "GK" }
C.FW = C.ALL_POSITIONS[1]
C.MF = C.ALL_POSITIONS[2]
C.DF = C.ALL_POSITIONS[3]
C.GK = C.ALL_POSITIONS[4]

-- Dictionary
C.TRAINING = "Training"
C.STRAT = "Strat"
C.INA_UPGRADE_TECHNIQUE_KEY = "c_ina_upgrade_technique_"

-- Overridable
C.MAX_HIGHLIGHTED_MAGICIAN = 2

-- Upgrades
C.UPGRADES = { "plus", "number", "grade" }
C.UPGRADES.Plus = C.UPGRADES[1]
C.UPGRADES.Number = C.UPGRADES[2]
C.UPGRADES.Grade = C.UPGRADES[3]
C.UPGRADES.NumberType = {}
C.UPGRADES.NumberType.A = "ina_tech_numbera_sticker"
C.UPGRADES.NumberType.S = "ina_tech_numbers_sticker"
C.UPGRADES.NumberType.Z = "ina_tech_numberz_sticker"

--- For specific jokers
C.CUSTOM = {}
C.CUSTOM.Bobby_Teams = {
    ["Raimon"]         = { x = 0, y = 0 },
    ["Royal Academy"]  = { x = 1, y = 0 },
    ["Occult"]         = { x = 5, y = 0 },
    ["Wild"]           = { x = 6, y = 0 },
    ["Brain"]          = { x = 7, y = 0 },
    ["Otaku"]          = { x = 8, y = 0 },
    ["Inazuma Eleven"] = { x = 9, y = 0 },
    ["Shuriken"]       = { x = 10, y = 0 },
    ["Farm"]           = { x = 11, y = 0 },
    ["Kirkwood"]       = { x = 12, y = 0 },
    ["Zeus"]           = { x = 0, y = 1 }
}

local team_number = 0
for _ in pairs(C.CUSTOM.Bobby_Teams) do
    team_number = team_number + 1
end
C.CUSTOM.Bobby_Teams_Number = team_number

C.ELEMENTALS_KEYS = { j_ina_Weathervane = true, j_ina_Noggin = true, j_ina_Montayne = true, j_ina_Blazer = true }

--- FOR GENERAL CREDITS
C.CREDITS = {}
C.CREDITS.lead = 'Deco'
C.CREDITS.developers = 'Synkro, Izan'
C.CREDITS.graphic = 'Shadorossa, Synkro'
