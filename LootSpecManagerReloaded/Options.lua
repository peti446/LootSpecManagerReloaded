local AddonName, Private = ...

local LootSpecManager = Private.LootSpecManager

LootSpecManager.Options = {
    name = AddonName,
    handler = LootSpecManager,
    type = 'group',
    args = {}
}