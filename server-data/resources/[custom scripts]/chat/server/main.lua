-- StarBlazt Chat
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local whitelisted = {
	{job='bennys',alias='Benny'},
	{job='pedagang',alias='Pedagang'},
	{job='police',alias='Polisi'},
	{job='ambulance',alias='EMS'},
  }

  function getIdentityZ(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	return {
		name = xPlayer.getName(),
		job = xPlayer.getJob().name
	}
  end
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


RegisterCommand('info', function(source, args, rawCommand)
	local msg = rawCommand:sub(5)
	local name = getIdentityZ(source)
	for _k, _v in ipairs(whitelisted) do
		if _v.job == name.job then
			fal = _v.alias
			nama = name.name
			TriggerClientEvent('chat:addMessage', -1, {
			template = '<div class="chat-message ' .. _v.job .. '"><b>{0} | {1} :</b> {2}</div>',
			args = { fal, nama, msg }
		})
		end
	  end
end, false)
--==================================================================

-- ======================= Chat Untuk OOC =======================

RegisterCommand('ooc', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	local name = getIdentity(source)
	fal = 'ID ' .. source
        TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message"><b>[ OOC ] {0} :</b> {1}</div>',
        args = { fal, msg }
    })
end, false)

--==================================================================



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