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

-- ======================= Chat Untuk Pedagang =======================

RegisterServerEvent('pedagangreport')
AddEventHandler('pedagangreport', function(source, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:ReportSendPedagang', -1, source, fal, msg)
end)

--==================================================================

-- ======================= Chat Untuk Bennys =======================

RegisterServerEvent('bennysreport')
AddEventHandler('bennysreport', function(source, msg)
    local name = getIdentity(source)
    fal = name.firstname  .. '  ' .. name.lastname
    TriggerClientEvent('chat:ReportSendBennys', -1, source, fal, msg)
end)

--==================================================================

-- ======================= Chat Untuk OOC =======================

RegisterCommand('ooc', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
        TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message"><b>[ OOC ] {0}:</b> {1}</div>',
        args = { fal, msg }
    })
end, false)

--==================================================================

-- ======================= Chat Untuk Bisik =======================

RegisterCommand('bisik', function(source, args, rawCommand)
	local msg = rawCommand:sub(6)
	local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
    TriggerClientEvent('chat:bisik', -1, source, fal, msg)
end, false)




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