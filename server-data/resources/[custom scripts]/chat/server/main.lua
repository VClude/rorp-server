-- StarBlazt Chat

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = identity['name'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height'],
			job = identity['job'],
			group = identity['group']
		}
	else
		return nil
	end
end



AddEventHandler("chatMessage", function(source, color, message)
    local src = source
    args = stringsplit(message, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
    end
end)

RegisterServerEvent('chat:server:ServerPSA')
AddEventHandler('chat:server:ServerPSA', function(message)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message server">SERVER: {0}</div>',
        args = { message }
    })
    CancelEvent()
end)

-- ======================= Chat Untuk EMS ===========================

RegisterServerEvent('emsreport')
AddEventHandler('emsreport', function(source, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:ReportSendEms', -1, source, fal, msg)
end)

--==================================================================

-- ======================= Chat Untuk Polisi =======================

RegisterServerEvent('polisreport')
AddEventHandler('polisreport', function(source, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:ReportSendPolisi', -1, source, fal, msg)
end)

--==================================================================

-- RegisterServerEvent('chat:server:emsreportsource')
-- AddEventHandler('chat:server:emsreportsource', function(source, msg)
--     local name = getIdentity(source)
-- 	fal = name.firstname .. "  " .. name.lastname
--     TriggerClientEvent('chat:addMessage', source, {
--         template = '<div class="chat-message emergency">[ EMS ] {0} : {1} </div>',
--         args = { fal, msg }
--     })
--     CancelEvent()
-- end)

RegisterServerEvent('911')
AddEventHandler('911', function(source, caller, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:EmergencySend911', -1, source, fal, msg)
end)

-- RegisterServerEvent('chat:server:911source')
-- AddEventHandler('chat:server:911source', function(source, caller, msg)
--     local name = getIdentity(source)
-- 	fal = name.firstname .. "  " .. name.lastname
--     TriggerClientEvent('chat:addMessage', source, {
--         template = '<div class="chat-message emergency">911 {0} ({1}): {2} </div>',
--         args = { fal, caller, msg }
--     })
--     CancelEvent()
-- end)

RegisterServerEvent('911r')
AddEventHandler('911r', function(target, source, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:EmergencySend911r', -1, source, fal, msg)
end)

RegisterServerEvent('chat:server:911r')
AddEventHandler('chat:server:911r', function(target, caller, msg)
    local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
    TriggerClientEvent('chat:addMessage', target, {
        template = '<div class="chat-message emergency">911r {0} : {1} </div>',
        args = { fal, msg }
    })
    CancelEvent()
    TriggerClientEvent('chat:EmergencySend911', fal, caller, msg)
end)



function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end