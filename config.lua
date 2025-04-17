Config = {}

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.cat = { --categories
    {
        catid = 'vehicles',    --id for items in Config.items to refrence to the category 
        label = 'Vehicles' --label shown on the UI
    },
    {
        catid = 'weapons',
        label = 'Weapons'
    },
    {
        catid = 'general',
        label = 'General'
    },
}

Config.items = {
    ['armour50'] = {  --itemname
        name = 'armour50',    --itemname, must be the same as the key
        label = '50% Armour',   --label shown on the UI
        catid = 'general',  --catid should match one of the categories in Config.cat
        credit = 2,   -- Price of the item
        itemType = 'item', -- Item type, options: 'item' and 'vehicle'
    },
    ['WEAPON_PISTOL'] = {   
        name = 'WEAPON_PISTOL',
        label = 'pistol',
        catid = 'weapons',
        credit = 5,
        itemType = 'item',
    },
    ['bandage'] = {
        name = 'bandage',
        label = 'bandage',
        catid = 'general',
        credit = 10,
        itemType = 'item',
    },
    ['asea'] = {
        name = 'asea',
        label = 'Asea',
        catid = 'vehicles',
        credit = 20,
        itemType = 'vehicle',
    },
    
}

