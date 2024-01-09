ESX = nil
ESX = exports["es_extended"]:getSharedObject() --This is standalone script , just added to be sure not to get any errors
local DISCORD_BOT_TOKEN = 'discord bot token here'
local GUILD_ID = 'server guild id' 
local PLAYING_ROLE_ID = 'Role id here'

AddEventHandler('playerConnecting', function()
    local src = source
    local identifiers = GetNumPlayerIdentifiers(src)
    local discordId = ""

    for i = 0, identifiers - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "discord:") then
            discordId = id:sub(9) -- Extracting the Discord ID part
            --print
            print(discordId)
            break
        end
    end

    if discordId then
        local endpoint = string.format('https://discord.com/api/v9/guilds/%s/members/%s/roles/%s', GUILD_ID, discordId, PLAYING_ROLE_ID)

        PerformHttpRequest(endpoint, function(statusCode, data, headers)
            if statusCode == 204 then
                print('Role added successfully to Discord member.')
            else
                print('Failed to add role:', statusCode, data)
            end
        end, 'PUT', '{}', { ['Authorization'] = 'Bot ' .. DISCORD_BOT_TOKEN, ['Content-Type'] = 'application/json' })
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    local identifiers = GetNumPlayerIdentifiers(src)
    local discordId = ""

    for i = 0, identifiers - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "discord:") then
            discordId = id:sub(9) -- Extracting the Discord ID part
            --print
            print(discordId)
            break
        end
    end

    if discordId then
        local endpoint = string.format('https://discord.com/api/v9/guilds/%s/members/%s/roles/%s', GUILD_ID, discordId, PLAYING_ROLE_ID)

        PerformHttpRequest(endpoint, function(statusCode, data, headers)
            if statusCode == 204 then
                print('Role removed successfully from Discord member.')
            else
                print('Failed to remove role:', statusCode, data)
            end
        end, 'DELETE', '{}', { ['Authorization'] = 'Bot ' .. DISCORD_BOT_TOKEN })
    end
end)
--create a while loop to check identifier if not found then remove role if found add role
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(1000)
        local src = source
        local identifiers = GetNumPlayerIdentifiers(src)
        local discordId = ""

        for i = 0, identifiers - 1 do
            local id = GetPlayerIdentifier(src, i)
            if string.find(id, "discord:") then
                discordId = id:sub(9) -- Extracting the Discord ID part
                --print
                print(discordId)
                break
            end
        end

        if discordId then
            local endpoint = string.format('https://discord.com/api/v9/guilds/%s/members/%s/roles/%s', GUILD_ID, discordId, PLAYING_ROLE_ID)

            PerformHttpRequest(endpoint, function(statusCode, data, headers)
                if statusCode == 204 then
                    print('Role added successfully to Discord member.')
                else
                    print('Failed to add role:', statusCode, data)
                end
            end, 'PUT', '{}', { ['Authorization'] = 'Bot ' .. DISCORD_BOT_TOKEN, ['Content-Type'] = 'application/json' })
        else
            local endpoint = string.format('https://discord.com/api/v9/guilds/%s/members/%s/roles/%s', GUILD_ID, discordId, PLAYING_ROLE_ID)

            PerformHttpRequest(endpoint, function(statusCode, data, headers)
                if statusCode == 204 then
                    print('Role removed successfully from Discord member.')
                else
                    print('Failed to remove role:', statusCode, data)
                end
            end, 'DELETE', '{}', { ['Authorization'] = 'Bot ' .. DISCORD_BOT_TOKEN })
        end
        
    end
end)