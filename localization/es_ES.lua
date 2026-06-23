-- Central localization loader for es_ES
-- Imports from localization/es_ES/ subdirectory
-- Edit the sub-files, not this file

local function deep_merge(target, source)
    for k, v in pairs(source) do
        if type(v) == "table" and type(target[k]) == "table" then
            deep_merge(target[k], v)
        else
            target[k] = v
        end
    end
    return target
end

local function load_sub(path, result)
    local fn, err = SMODS.load_file(path, "Pokerleven")
    if err then
        sendDebugMessage("[PokerLeven] Loc error in " .. path .. ": " .. tostring(err))
    elseif fn then
        local sub = fn()
        if sub then deep_merge(result, sub) end
    end
end

local result = {
    descriptions = {
        Back = {}, Blind = {}, Strat = {}, Training = {},
        Edition = {}, Enhanced = {}, Joker = {}, Other = {},
        Planet = {}, Spectral = {}, Stake = {}, Tag = {},
        Tarot = {}, Voucher = {},
    },
    misc = {
        achievement_descriptions = {}, achievement_names = {},
        blind_states = {}, challenge_names = {}, collabs = {},
        dictionary = {}, high_scores = {}, labels = {},
        poker_hand_descriptions = {}, poker_hands = {},
        quips = {}, ranks = {}, suits_plural = {}, suits_singular = {},
        tutorial = {}, v_dictionary = {}, v_text = {},
    },
}

-- Non-joker sections
load_sub("localization/es_ES/backs.lua", result)
load_sub("localization/es_ES/blinds.lua", result)
load_sub("localization/es_ES/consumables.lua", result)
load_sub("localization/es_ES/tags.lua", result)
load_sub("localization/es_ES/vouchers.lua", result)
load_sub("localization/es_ES/other.lua", result)
load_sub("localization/es_ES/misc.lua", result)

-- Joker team files
load_sub("localization/es_ES/jokers/IE1/IE1_A_raimon.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_B_occult.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_C_royal.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_D_wild.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_E_brain.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_F_otaku.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_G_inazuma_eleven.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_H_shuriken.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_I_farm.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_J_kirkwood.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_K_zeus.lua", result)
load_sub("localization/es_ES/jokers/IE1/IE1_special.lua", result)

-- IE99 team files
load_sub("localization/es_ES/jokers/IE99/IE99_Y_scouts.lua", result)
load_sub("localization/es_ES/jokers/IE99/IE99_Z_Winners.lua", result)

return result
