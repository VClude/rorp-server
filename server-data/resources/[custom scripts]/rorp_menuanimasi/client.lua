ESX                                   = nil
local PlayerData              	      = {}

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local elements = {
    {label = 'Menyerah', value = 'menyerah'},
    {label = 'Polisi: Investigasi', value = 'investigasi'},
    {label = 'Polisi: Mengatur jalan', value = 'mengatur_jalan'},
    {label = 'Memperbaiki kolong kendaraan', value = 'memperbaiki_kolong_kendaraan'},
    {label = 'Memperbaiki mesin', value = 'memperbaiki_mesin'},
    {label = 'Taxi: Memberi tagihan', value = 'memberi_tagihan'},
    {label = 'Mengambil belanjaan', value = 'mengambil_belanjaan'},
    {label = 'Membuat catatan', value = 'membuat_catatan'},
    {label = 'Memotret', value = 'memotret'},
}

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
    
    Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function OpenGetMenuAnimasi()

    ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animasi_menu', {
			title    = 'Animasi Pekerjaan',
			align    = 'bottom-right',
			elements = elements
        }, function(data, menu)
            
            if data.current.value == 'menyerah' then
                ExecuteCommand('k')
            elseif data.current.value == 'investigasi' then
                ExecuteCommand('e tablet2')
            elseif data.current.value == 'mengatur_jalan' then
                ExecuteCommand('e copbeacon')
            elseif data.current.value == 'memperbaiki_kolong_kendaraan' then
                ExecuteCommand('e mechanic3') 
            elseif data.current.value == 'memperbaiki_mesin' then
                ExecuteCommand('e mechanic')               
            elseif data.current.value == 'memberi_tagihan' then
                ExecuteCommand('e clipboard')
            elseif data.current.value == 'mengambil_belanjaan' then
                ExecuteCommand('e box')
            elseif data.current.value == 'membuat_catatan' then
                ExecuteCommand('e notepad')
            elseif data.current.value == 'memotret' then
                ExecuteCommand('e camera')
            end   
        end, function(data,menu)       
            menu.close()    
        end)
end

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)
            if ESX.PlayerData.job and ( ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" or ESX.PlayerData.job.name == "pedagang" or ESX.PlayerData.job.name == "bennys" ) then
                if IsControlJustReleased(0, Keys["F5"]) then
                    OpenGetMenuAnimasi()
                end
            end
    end
end)