--------------------------------
------- Created by Hamza -------
-------------------------------- 

local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx_policeArmory:weaponTakenOut")
AddEventHandler("esx_policeArmory:weaponTakenOut", function(weapon,giveAmmo)
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = ESX.GetPlayerFromId(source).getIdentifier()
	
    if xPlayer then
    local id = ESX.GetPlayerFromId(source).getIdentifier()
		MySQL.Async.fetchAll("SELECT weapons FROM user_policeArmory WHERE identifier='".. id .."'", {}, function(weapRow)
			local addWeaponToDB
			for k,v in pairs(weapRow) do
				addWeaponToDB = v.weapons
			end
			addWeaponToDB = addWeaponToDB .. weapon .. ", "
			MySQL.Async.execute("UPDATE user_policeArmory SET weapons='".. addWeaponToDB .."' WHERE identifier='".. id .."'", {}, function ()
			end)
		end)
        xPlayer.addWeapon(weapon, Config.AmmountOfAmmo)
		local DATE = os.date("%H:%M (%d.%m.%y)")
        -- local message = "```" ..GetPlayerName(source).. " [" ..xPlayer.getIdentifier().. "] | Telah mengambil [ " .. ESX.GetWeaponLabel(weapon) .. " ] dari gudang senjata polisi | " ..DATE.."```"
        local embed = [
            {
              "author": {
                "name": "Birdie♫",
                "url": "https://www.reddit.com/r/cats/",
                "icon_url": "https://i.imgur.com/R66g1Pe.jpg"
              },
              "title": "Title",
              "url": "https://google.com/",
              "description": "Text message. You can use Markdown here. *Italic* **bold** __underline__ ~~strikeout~~ [hyperlink](https://google.com) `code`",
              "color": 15258703,
              "fields": [
                {
                  "name": "Text",
                  "value": "More text",
                  "inline": true
                },
                {
                  "name": "Even more text",
                  "value": "Yup",
                  "inline": true
                },
                {
                  "name": "Use `\"inline\": true` parameter, if you want to display fields in the same line.",
                  "value": "okay..."
                },
                {
                  "name": "Thanks!",
                  "value": "You're welcome :wink:"
                }
              ],
              "thumbnail": {
                "url": "https://upload.wikimedia.org/wikipedia/commons/3/38/4-Nature-Wallpapers-2014-1_ukaavUI.jpg"
              },
              "image": {
                "url": "https://upload.wikimedia.org/wikipedia/commons/5/5a/A_picture_from_China_every_day_108.jpg"
              },
              "footer": {
                "text": "Woah! So cool! :smirk:",
                "icon_url": "https://i.imgur.com/fKL31aD.jpg"
              }
            }
          ]
		PerformHttpRequest(""..Config.DiscordWebook.."", function(err, text, headers) end, 'POST', json.encode({username = "SATPAM POLISI", embeds = embed}), { ['Content-Type'] = 'application/json' })
		TriggerClientEvent("esx:showNotification", source, "You ~y~took~s~ 1x ~r~" .. ESX.GetWeaponLabel(weapon).."~r~")
    end
	
end)

RegisterServerEvent("esx_policeArmory:weaponInStock")
AddEventHandler("esx_policeArmory:weaponInStock", function(weapon,ammo,giveAmmo)
    local xPlayer = ESX.GetPlayerFromId(source)
    local id = ESX.GetPlayerFromId(source).getIdentifier()

    if xPlayer then
        xPlayer.removeWeapon(weapon, ammo)
		MySQL.Async.fetchAll("SELECT weapons FROM user_policeArmory WHERE identifier='".. id .."'", {}, function(weapRow)
			for k,v in pairs(weapRow) do
				removeWeaponFromDB = string.gsub(v.weapons,weapon .. ", ", "")
			end
			MySQL.Async.execute("UPDATE user_policeArmory SET weapons='".. removeWeaponFromDB .."' WHERE identifier='".. id .."'", {}, function ()
			end)
		end)
		local DATE = os.date("%H:%M (%d.%m.%y)")
		local message = "**" ..GetPlayerName(source).. "** [" ..xPlayer.getIdentifier().. "] **|** has **put** " .. ESX.GetWeaponLabel(weapon) .. " back into the Police Armory **|** " ..DATE
		PerformHttpRequest(""..Config.DiscordWebook.."", function(err, text, headers) end, 'POST', json.encode({username = "Police Armory", content = message}), { ['Content-Type'] = 'application/json' })
        TriggerClientEvent("esx:showNotification", source, "You ~y~returned~s~ 1x ~r~" .. ESX.GetWeaponLabel(weapon) .. "~r~")
    end
	
end)

ESX.RegisterServerCallback("esx_policeArmory:getWeaponState", function(source, cb)
    local id = ESX.GetPlayerFromId(source).getIdentifier()
    MySQL.Async.fetchAll('SELECT weapons FROM user_policeArmory WHERE identifier = \"' .. id .. '\"', {}, function(rowsChanged)
        if next(rowsChanged) == nil then
            MySQL.Async.execute("INSERT INTO user_policeArmory (identifier,weapons) VALUES(\"" ..id .. "\",\"\")", {}, function () end)
            cb(nil)
        end
        cb(rowsChanged)
    end)
end)

ESX.RegisterServerCallback("esx_policeArmory:checkPoliceOnline", function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM user_policeArmory', {}, function(rowsChanged)
        local police = {}
        for k,v in pairs(rowsChanged) do
            local xPlayer = ESX.GetPlayerFromIdentifier(v.identifier)
            if xPlayer then
                table.insert(police,{id = v.identifier, name = xPlayer.getName(), job = xPlayer.getJob()})
            end
        end
        cb(police)
    end)
end)

RegisterServerEvent("esx_policeArmory:restockWeapons")
AddEventHandler("esx_policeArmory:restockWeapons", function(id)
    MySQL.Async.execute("UPDATE user_policeArmory SET weapons= \"\" WHERE identifier=\"" .. id .. "\"", {}, function ()
    end)
	local xPlayer = ESX.GetPlayerFromId(source)
	local target = ESX.GetPlayerFromIdentifier(id)
	local DATE = os.date("%H:%M (%d.%m.%y)")
	local message = "**" ..GetPlayerName(source).. "** [" ..xPlayer.getIdentifier().. "] **|** has **restocked** weapons for **" ..target.getName().. "** **|** " ..DATE
	PerformHttpRequest(""..Config.DiscordWebook.."", function(err, text, headers) end, 'POST', json.encode({username = "Police Armory", content = message}), { ['Content-Type'] = 'application/json' })	
end)
