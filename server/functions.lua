ESX = exports["es_extended"]:getSharedObject() -- Uncomment if you don't use ESX and want to modify this script


function GetPlayerCredits(src)
    return ESX.GetPlayerFromId(src).getMeta('credits') or 0
end

function GivePlayerCredits(src, amount)
    local start = tonumber(GetPlayerCredits(src))
    SetPlayerCredits(src, (start+amount))
end

function RemovePlayerCredits(src, amount)
    local start = tonumber(GetPlayerCredits(src))
    SetPlayerCredits(src, (start-amount))
end

function SetPlayerCredits(src, amount)
    ESX.GetPlayerFromId(src).setMeta('credits', tonumber(amount))
end

function BuyItem(src, item, count, amount)
   if item.itemType == 'vehicle' then
    RemovePlayerCredits(src, amount)
        local randomPlate = GeneratePlate()
        MySQL.insert.await('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (?, ?, ?)', {
            ESX.GetPlayerFromId(src).identifier, randomPlate, json.encode({model = joaat(item.name), plate = randomPlate})
        })
        return
    end
    if item.itemType == 'item' then
        RemovePlayerCredits(src, amount)
        ESX.GetPlayerFromId(src).addInventoryItem(item.name, count)
        return
    end
    error("Wrong itemtype in item: "..item.name.. " Item type: " ..item.itemType)
end

ESX.RegisterCommand(
    { "givecredits"},
    "admin",
    function(xPlayer, args)
        local xTarget = args.PlayerId
        local amount = args.amount
        if not xTarget then
            TriggerClientEvent('7Credits:Client:Notify', xPlayer.source, "Invalid player ID")
            return
        end
        if not amount then
            TriggerClientEvent('7Credits:Client:Notify', xPlayer.source, "Invalid amount")
            return
        end
        TriggerClientEvent('7Credits:Client:Notify', xPlayer.source, "You gave credits")
        GivePlayerCredits(xTarget.source, amount)
    end,
    false,
    {
        help = "Give Credits",
        validate = false,
        arguments = {
            { name = "PlayerId", help = "Player's ID", type = "player" },
            { name = "amount", help = "Credits Amount", type = "number" },
        },
    }
)


-- Generate plate from esx_vehicleshop: https://github.com/esx-framework/esx_vehicleshop

local function IsPlateTaken(plate)
    local result = MySQL.scalar.await('SELECT plate FROM owned_vehicles WHERE plate = ?', {
        plate
    })
    return result
end

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	math.randomseed(GetGameTimer())

	local generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. (Config.PlateUseSpace and ' ' or '') .. GetRandomNumber(Config.PlateNumbers))

	local isTaken = IsPlateTaken(generatedPlate)
	if isTaken then 
		return GeneratePlate()
	end

	return generatedPlate
end

function GetRandomNumber(length)
	Wait(0)
	return length > 0 and GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)] or ''
end

function GetRandomLetter(length)
	Wait(0)
	return length > 0 and GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)] or ''
end
