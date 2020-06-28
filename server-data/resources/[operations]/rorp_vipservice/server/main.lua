TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  

function getIdentity(ident)
	local identifier = ident
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

RegisterCommand('addvip', function(source, args, rawCommand)
    local iden = tostring(args[1])
    local bulan = tonumber(args[2])
    if IsPlayerAceAllowed(source, "vip") and (type(bulan) == "number") and (math.floor(bulan) == bulan) then
        local name = getIdentity(iden)
        if name ~= nil then
            print(name.firstname)
            local fal = name.firstname .. "  " .. name.lastname
            local length = bulan * 2592000
            local now = os.time()
            local start = os.date("%Y-%m-%d", now)
            local akhir = os.date("%Y-%m-%d", now+length)
            print(fal)
            print(start)
            print(akhir)


        MySQL.Async.execute('INSERT INTO `vip` VALUES (@identifier, @startdate, @expiredate)',
		{
			['@identifier'] 	= iden,
			['@startdate']      = start,
			['@expiredate']     = akhir
		}, function(rowsChanged)
			if (rowsChanged > 0) then
                TriggerClientEvent('chat:addMessage', -1, {
                    template = '<div class="chat-messagez vip">User <b> {0} </b> Telah ditambahkan ke VIP Group, terimakasih atas dukungan anda</div>',
                    args = {fal}			
                })
            else
				TriggerClientEvent('esx:showNotification', "Gagal Memasukan user ke VIP")
			end

        end)
        else
        TriggerClientEvent("chatMessage", source, 'ga ada')
        end
    else
        TriggerClientEvent("chatMessage", source, "anda jangan coba coba ea.")
    end

end, false)
