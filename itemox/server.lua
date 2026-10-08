lib.addCommand('items', {
    help = 'Afficher la liste de tous les items du serveur et en give',
    restricted = 'group.admin'
}, function(source, args, raw)
    local items = exports.ox_inventory:Items()
    local itemList = {}

    for itemName, data in pairs(items) do
        table.insert(itemList, {
            title = data.label or itemName,
            description = "Nom technique : " .. itemName,
            name = itemName
        })
    end

    table.sort(itemList, function(a, b)
        return a.title < b.title
    end)

    TriggerClientEvent('itemjordan:openMenu', source, itemList)
end)

lib.addCommand('item', {
    help = 'Afficher la liste de tous les items du serveur et en give',
    restricted = 'group.admin'
}, function(source, args, raw)
    ExecuteCommand(source, 'items')
end)

RegisterNetEvent('itemjordan:giveItem', function(data)
    local src = source
    local targetId = data.targetId
    local itemName = data.itemName
    local count = tonumber(data.count) or 1

    local success = exports.ox_inventory:AddItem(targetId, itemName, count)
    if success then
        TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = 'Item give avec succès !' })
        TriggerClientEvent('ox_lib:notify', targetId, { type = 'info', description = 'Vous avez reçu ' .. count .. 'x ' .. itemName })
    else
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = 'Inventaire cible plein ou erreur.' })
    end
end)