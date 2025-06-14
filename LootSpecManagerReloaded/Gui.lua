local _, Private = ...

local LootSpecManager = Private.LootSpecManager
local AceGUI = Private.AceGUI

local Gui = {}
LootSpecManager.Gui = Gui

function Gui:OnLootSpecDropdownItemClick(specId)
    if self.isEncounter then
        LootSpecManager:SetLootSpecForEncounter(self.encounterId, self.difficultyId, specId)
        Gui:UpdateEncounterLootSpecDropdown(self.encounterId, self.difficultyId)
    else
        LootSpecManager:SetLootSpecForMap(self.mapId, self.difficultyId, specId)
        Gui:UpdateInstanceLootSpecDropdown(self.mapId, self.difficultyId)
    end
end

function Gui:CreateLootSpecDropdown()
    -- Re-ceate
    if(self.dropdownMenu) then
        self.dropdownMenu:ReleaseChildren()
        self.dropdownMenu.frame:Hide()
        return
    end
    self.dropdownMenu = AceGUI:Create("Dropdown")
    self.dropdownMenu:SetWidth(200)
    self.dropdownMenu.frame:SetParent(EncounterJournalEncounterFrameInfoDifficulty)
    self.dropdownMenu.frame:SetPoint("RIGHT", EncounterJournalEncounterFrameInfoDifficulty, "LEFT", -10, 0)
    self.dropdownMenu:SetCallback("OnValueChanged", function(_, _, value)
        self:OnLootSpecDropdownItemClick(value)
    end)
    local list = {};
    list[LootSpecManager.CURRENT_LOOT_SPEC] = LootSpecManager.CURRENT_LOOT_SPEC_NAME;
    for i = 1, GetNumSpecializations() do
        local specId, name = GetSpecializationInfo(i)
        list[specId] = name;
    end
    self.dropdownMenu:SetList(list)
end

function Gui:UpdateEncounterLootSpecDropdown(encounterId, difficultyId)
    local lootSpecForEncounter = LootSpecManager:GetLootSpecForEncounter(encounterId, difficultyId)

    self.isEncounter = true
    self.encounterId = encounterId
    self.difficultyId = difficultyId

    self.dropdownMenu:SetValue(lootSpecForEncounter)
    self.dropdownMenu.frame:Show()
end

function Gui:UpdateInstanceLootSpecDropdown(mapId, difficultyId)
    local lootSpecForInstance = LootSpecManager:GetLootSpecForMap(mapId, difficultyId)

    self.isEncounter = false
    self.mapId = mapId
    self.difficultyId = difficultyId

    self.dropdownMenu:SetValue(lootSpecForInstance)
    self.dropdownMenu.frame:Show()
end

function Gui:HideLootSpecDropDown()
    self.dropdownMenu.frame:Hide()
end
