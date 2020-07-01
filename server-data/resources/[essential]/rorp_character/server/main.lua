ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("rorp_character:createsign")
AddEventHandler("rorp_character:createsign", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if result[1] then
        if xPlayer ~= nil then
            TriggerClientEvent("rorp_character:createsign", _source, (result[1].firstname .. " " .. result[1].lastname), xPlayer.job.label, ("Cash: " .. xPlayer.getAccount('money').money .. "$"))
        end
    end
end)    

RegisterServerEvent("charselect:select")
AddEventHandler("charselect:select", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM characters WHERE identifier=@username", {['@username'] = player})
    if xPlayer ~= nil then
        if result[1] then   
            TriggerClientEvent("charselect:animation", _source, true)
        else
        end
    end
end)    

RegisterServerEvent("charselect:lastpos")
AddEventHandler("charselect:lastpos", function(xPlayer)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local player = xPlayer.getIdentifier()
    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier=@username", {['@username'] = player})
    if (result) then
        if xPlayer ~= nil then
            TriggerClientEvent("charselect:lastpos", _source, json.decode(result[1].position))
        end
    end
end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		local user = users[1]
		local skin = nil

		local jobSkin = {
			skin_male   = xPlayer.job.skin_male,
			skin_female = xPlayer.job.skin_female
		}
		
		if user.skin ~= nil then
			skin = json.decode(user.skin)
		end

		cb(skin, jobSkin)
	end)
end)

-- Commands
TriggerEvent('es:addGroupCommand', 'skin', 'admin', function(source, args, user)
	TriggerClientEvent('esx_skin:openSaveableMenu', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('skin')})
