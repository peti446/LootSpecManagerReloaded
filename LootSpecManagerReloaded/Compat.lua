local _, Private = ...

local LootSpecManager = Private.LootSpecManager

local Compat = {}
LootSpecManager.Compat = Compat

local RAID_DIFFICULTY_NAME_TO_ID = {
    lfr = 17,
    normal = 14,
    heroic = 15,
    mythic = 16
}

function Compat:GetVersion()
    return LTSM.version
end