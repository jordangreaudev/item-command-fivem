RegisterNetEvent('itemjordan:openMenu', function(itemList)
    local options = {}

    for _, item in ipairs(itemList) do
        table.insert(options, {
            title = item.title,
            description = item.description,
            icon = 'box',
            arrow = true,
            onSelect = function()
                local input = lib.inputDialog('Donner : ' .. item.title, {
                    { type = 'number', label = 'ID du joueur', description = 'Mets ton propre ID pour toi', required = true, default = GetPlayerServerId(PlayerId()) },
                    { type = 'number', label = 'Quantité', description = 'Nombre à give', required = true, default = 1 }
                })

                if input then
                    local targetId = tonumber(input[1])
                    local count = tonumber(input[2])
                    if targetId and count then
                        TriggerServerEvent('itemjordan:giveItem', {
                            targetId = targetId,
                            itemName = item.name,
                            count = count
                        })
                    end
                end
            end
        })
    end

    lib.registerContext({
        id = 'itemjordan_main_menu',
        title = '📦 Catalogue des Items (' .. #itemList .. ')',
        options = options
    })

    lib.showContext('itemjordan_main_menu')
end)