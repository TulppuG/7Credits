--COMMAND--
RegisterCommand('creditshop', function()
    TriggerServerEvent('7Credits:Server:Start')
end)

RegisterNetEvent('7Credits:Client:Notify', function(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(false, false)
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false)
end)

RegisterNUICallback('buy', function(data, cb)
    SetNuiFocus(false)
    TriggerServerEvent('7Credits:Server:Buy', data)
end)

RegisterNetEvent('7Credits:Client:Start', function(credits)
    local items = {}
    for _, i in pairs(Config.items) do
        local data = {}
        data.name = i.name
        data.label = i.label
        data.credit = i.credit
        data.catid = i.catid
        table.insert(items, data)
    end
    SetNuiFocus(true, true)
    SendNUIMessage({
        toggle = true,
        items = json.encode(items),
        cat = json.encode(Config.cat),
        creditamount = credits,
     })
end)
    