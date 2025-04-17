RegisterNetEvent('7Credits:Server:Start', function()
    local src = source 
    local credits = GetPlayerCredits(src)
    TriggerClientEvent('7Credits:Client:Start', src, credits)
end)

RegisterNetEvent('7Credits:Server:Buy', function(data)
    local src = source 
    local item = data.Item
    local count = tonumber(data.Count)
    local info = Config.items[item]

    if not info then 
        print("CHEATER ID: "..src)
        return
    end

    local creditAmount = (info.credit*count)
    local playerCredits = GetPlayerCredits(src)
    if playerCredits >= creditAmount then
        BuyItem(src, info, count, creditAmount)
    else
        TriggerClientEvent('7Credits:Client:Notify', src, "Not enough credits")
    end
end)