local PlayerData                = {}
ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent("charselect:register")
AddEventHandler("charselect:register", function()
    SetNuiFocus(true,true)
    Citizen.Wait(1000)
	SetEntityCoords(PlayerPedId(), 409.42, -1001.14, -99.90, 0.0, 0.0, 0.0, true)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent("charselect:animation")
    TriggerEvent("rtx_selector:camera")
	Visible()
end)

RegisterNetEvent("charselect:visibleplayer")
AddEventHandler("charselect:visibleplayer", function()
	Visiblee()
end)

RegisterNetEvent("charselect:register2")
AddEventHandler("charselect:register2", function(source)
    Citizen.Wait(1000)
	SetEntityCoords(PlayerPedId(), 409.42, -1001.14, -99.90, 0.0, 0.0, 0.0, true)
	FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent("charselect:animation2")
    TriggerEvent("rtx_selector:camera")
	Visible()
end)

local heading = 360.00
local signmodel = GetHashKey("prop_police_id_board")
local textmodel = GetHashKey("prop_police_id_text")
local scaleform = {}
local text = {}
local enable = true
local enablee = false
local coords = nil
local notifytext = false
local cam = nil
local cam2 = nil
local cam3 = nil
local cam4 = nil
local cam5 = nil
local SignProp1 = {}
local SignProp2 = {}

Citizen.CreateThread(function()
  scaleform = LoadScaleform("mugshot_board_01")
  text = CreateNamedRenderTargetForModel("ID_TEXT", textmodel)

  while text do
      Citizen.Wait(1)
      SetTextRenderId(text) -- set render target
      Set_2dLayer(4)
      Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
      Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
      Citizen.InvokeNative(0xC6372ECD45D73BCD, 1)
      DrawScaleformMovie(scaleform, 0.40, 0.35, 0.80, 0.75, 255, 255, 255, 255, 0)
      Citizen.InvokeNative(0xC6372ECD45D73BCD, 0)
      SetTextRenderId(GetDefaultScriptRendertargetRenderId())
  end
end)

RegisterNetEvent('rtx_selector:camera')
AddEventHandler('rtx_selector:camera', function()
	local playerPed = GetPlayerPed(-1)
	Citizen.Wait(2000) 
	SetFocusEntity(playerPed)
	cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 415.55, -998.50, -99.29, 0.00, 0.00, 89.75, 50.00, false, 0)
    SetCamActive(cam2, true)
    RenderScriptCams(true, false, 2000, true, true)
end)

RegisterNetEvent('rtx_selector:camera2')
AddEventHandler('rtx_selector:camera2', function()
	local playerPed = GetPlayerPed(-1)
	SetFocusEntity(playerPed)
    cam3 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 413.40, -998.43, -99.01, 0.00, 0.00, 89.75, 50.00, false, 0)
    PointCamAtCoord(cam3, 413.40, -998.43, -99.01)
    SetCamActiveWithInterp(cam3, cam2, 5000, true, true)
end)

RegisterNetEvent('rtx_selector:camera3')
AddEventHandler('rtx_selector:camera3', function()
	local playerPed = GetPlayerPed(-1)
	SetFocusEntity(playerPed)
    local pos = coords
	SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
    DoScreenFadeIn(500)
	FreezeEntityPosition(GetPlayerPed(-1), true)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    Citizen.Wait(500)
    cam5 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam5, pos.x,pos.y,pos.z+200)
    SetCamActiveWithInterp(cam5, cam4, 900, true, true)
    Citizen.Wait(900)
    cam4 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x,pos.y,pos.z+200, 300.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam4, pos.x,pos.y,pos.z+2)
    SetCamActiveWithInterp(cam4, cam5, 3700, true, true)
    Citizen.Wait(3700)
    PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    Citizen.Wait(500)
    SetCamActive(cam4, false)
    DestroyCam(cam4, true)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	EnableAllControlActions(0)
	Collision(false)
end)

RegisterNetEvent("charselect:animation")
AddEventHandler("charselect:animation", function()
	local ped = PlayerPedId()
	local playerPed = GetPlayerPed()
	enable = true
	SetEntityHeading(PlayerPedId(), 350.0)
	Citizen.Wait(2000) 
    TriggerServerEvent("charselect:createsign") 
	DoScreenFadeIn(1000)
    AnimationIntro()
    Citizen.Wait(1000)
	SetCamActive(cam2, false)
	TriggerEvent("rtx_selector:camera2")
	while enable == true do
        if not notifytext == true then
			notifytext = true
			exports['mythic_notify']:PersistentAlert('start', '85848451521ddd', 'inform', 'Tekan [Enter] untuk memilih karakter', { ['background-color'] = '#000000' })
		end
		Citizen.Wait(1)
        RequestAnimDict("mp_character_creation@customise@male_a")
        TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 1, 0, 0, 0)
        SetNuiFocus(true,true)
		FreezeEntityPosition(PlayerPedId(), true)
        if IsControlJustReleased(1, 201) then
			FreezeEntityPosition(GetPlayerPed(-1), false)
			Citizen.Wait(200)
			DestroyAllCams(true)
			exports['mythic_notify']:PersistentAlert('end', '85848451521ddd')
			RequestAnimDict("mp_character_creation@lineup@male_a")
			TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "outro", 1.0, 1.0, 9000, 0, 1, 0, 0, 0)
			Citizen.Wait(2800)
			DeleteObject(SignProp1)
			DeleteObject(SignProp2)
			Citizen.Wait(5000)							
			SetCamActive(cam3, false)
			DestroyCam(createdCamera, 0)
			RenderScriptCams(0, 0, 1, 1, 1)
			createdCamera = 0
			enable = false
			Collision(false)
			DoScreenFadeOut(10)
			ClearTimecycleModifier("scanline_cam_cheap")
			TriggerEvent('rtx_selection:phase1')
        end
	end
end)

RegisterNetEvent("charselect:animation2")
AddEventHandler("charselect:animation2", function()
	local ped = PlayerPedId()
	local playerPed = GetPlayerPed()
	enable = true
	SetEntityHeading(PlayerPedId(), 350.0)
	Citizen.Wait(2000) 
    TriggerServerEvent("charselect:createsign") 
    TriggerServerEvent("charselect:lastpos")
	DoScreenFadeIn(1000)
    AnimationIntro()
    Citizen.Wait(1000)
	SetCamActive(cam2, false)
	TriggerEvent("rtx_selector:camera2")
	while enable == true do
		if not notifytext == true then
			notifytext = true
			exports['mythic_notify']:PersistentAlert('start', '85848451521ddd', 'inform', 'Tekan [Enter] untuk memilih karakter', { ['background-color'] = '#000000' })
		end
		Citizen.Wait(1)
        RequestAnimDict("mp_character_creation@customise@male_a")
        TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 8.0, -8.0, -1, 0, 1, 0, 0, 0)
		FreezeEntityPosition(PlayerPedId(), true)
        if IsControlJustReleased(1, 201) then
			FreezeEntityPosition(GetPlayerPed(-1), false)
			Citizen.Wait(200)
			DestroyAllCams(true)
			exports['mythic_notify']:PersistentAlert('end', '85848451521ddd')
			RequestAnimDict("mp_character_creation@lineup@male_a")
			TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "outro", 1.0, 1.0, 9000, 0, 1, 0, 0, 0)
			Citizen.Wait(2800)
			DeleteObject(SignProp1)
			DeleteObject(SignProp2)
			Citizen.Wait(5000)			
			SetCamActive(cam3, false)
			enable = false
			DestroyCam(createdCamera, 0)
			RenderScriptCams(0, 0, 1, 1, 1)
			createdCamera = 0
			ClearTimecycleModifier("scanline_cam_cheap")
			TriggerEvent('rtx_selector:camera3')
        end
	end
end)

RegisterNetEvent("charselect:createsign")
AddEventHandler("charselect:createsign", function(name, job, money) 
    SignProp1 = CreateObject(signmodel, 1, 1, 1, false, true, false)
    SignProp2 = CreateObject(textmodel, 1, 1, 1, false, true, false)

    AttachEntityToEntity(SignProp1, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);
    AttachEntityToEntity(SignProp2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 58868), 0.12, 0.24, 0.0, 5.0, 0.0, 70.0, true, true, false, false, 2, true);

    local ScaleformMovie = RequestScaleformMovie("MUGSHOT_BOARD_01")

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

    while HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
        PushScaleformMovieFunction(ScaleformMovie, "SET_BOARD")
        PushScaleformMovieFunctionParameterString(job)
        PushScaleformMovieFunctionParameterString(name)
        PushScaleformMovieFunctionParameterString("RETRONIX.CZ")
        PushScaleformMovieFunctionParameterString(money)
        PushScaleformMovieFunctionParameterString(0)
        PushScaleformMovieFunctionParameterString(5)
        PushScaleformMovieFunctionParameterString(0)
        PopScaleformMovieFunctionVoid()
    end
end)

RegisterNetEvent("charselect:lastpos")
AddEventHandler("charselect:lastpos", function(position) 
    coords = position
end)

function AnimationIntro()
	FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityHeading(PlayerPedId(), 350.0)
    RequestAnimDict("mp_character_creation@lineup@male_a")
    Citizen.Wait(100)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "intro", 1.0, 1.0, 5900, 0, 1, 0, 0, 0)
    Citizen.Wait(5700)
    RequestAnimDict("mp_character_creation@customise@male_a")
    Citizen.Wait(100)
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@customise@male_a", "loop", 1.0, 1.0, -1, 0, 1, 0, 0, 0)
end
	
function SpawnEntity()
    RequestAnimDict("mp_character_creation@lineup@male_a")
    TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "outro", 1.0, 1.0, 9000, 0, 1, 0, 0, 0)
    Citizen.Wait(8000)
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    DeleteObject(SignProp1)
    DeleteObject(SignProp2)
    RenderScriptCams(false, true, 500, true, true)                                              
    enable = false
end

function Collision()
    for i=1,256 do
        if NetworkIsPlayerActive(i) then
            SetEntityVisible(GetPlayerPed(i), false, false)
            SetEntityVisible(PlayerPedId(), true, true)
            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
        end
    end
end

function Visible()
    while enable == true do
        Citizen.Wait(0)
        Collision()
    end
end

function Collisione()
    for i=1,256 do
        if NetworkIsPlayerActive(i) then
            SetEntityVisible(GetPlayerPed(i), false, false)
            SetEntityVisible(PlayerPedId(), true, true)
            SetEntityNoCollisionEntity(GetPlayerPed(i), GetPlayerPed(-1), false)
        end
    end
end

function Visiblee()
    while enablee == true do
        Citizen.Wait(0)
        Collisione()
    end
end

function LoadScaleform (scaleform)
    local text = RequestScaleformMovie(scaleform)

    if text ~= 0 then
        while not HasScaleformMovieLoaded(text) do
            Citizen.Wait(0)
        end
    end

    return text
end

RegisterNetEvent('rtx_selection:phase1')
AddEventHandler('rtx_selection:phase1', function()
	local playerPed = GetPlayerPed(-1)
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	enablee = true
    SetEntityCoords(PlayerPedId(), -796.16, 332.7, 220.43, 0.0, 0.0, 0.0, true)
	SetEntityHeading(PlayerPedId(), 84.0)
	TriggerEvent("charselect:visibleplayer")
	SetEntityCoords(PlayerPedId(), -796.16, 332.7, 220.43, 0.0, 0.0, 0.0, true)
	SetEntityHeading(PlayerPedId(), 84.0)
    Citizen.Wait(2000)
	SetFocusEntity(playerPed)
	createdCamera = cam
    SetCamCoord(cam, -794.9, 332.47, 221.38) 
	SetCamRot(cam, 0.0, 0.0, 77.70354)
    RenderScriptCams(1, 0, 0, 1, 1)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	TaskGoStraightToCoord(PlayerPedId(), -805.67, 332.75, 220.43, 1.0, 100000, 89.5, 2.0)
    Citizen.Wait(3500)
    SetCamCoord(cam, -807.05, 334.39, 221.25) 
    RenderScriptCams(1, 0, 0, 1, 1)
	SetCamRot(cam, 0.0, 0.0, -122.552)
    Citizen.Wait(3000)
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
	TriggerEvent('hud:loadMenu')
end)

RegisterNetEvent('rtx_selection:phase2')
AddEventHandler('rtx_selection:phase2', function()
	local playerPed = GetPlayerPed(-1)
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetEntityHeading(PlayerPedId(), 267.5)
	SetFocusEntity(playerPed)
	createdCamera = cam
    SetCamCoord(cam, -807.05, 334.39, 221.25) 
    RenderScriptCams(1, 0, 0, 1, 1)
	SetCamRot(cam, 0.0, 0.0, -122.552)
	Citizen.Wait(1500)
	TaskGoStraightToCoord(PlayerPedId(), -797.21, 332.69, 220.43, 1.0, 100000, 181.5, 2.0)
    Citizen.Wait(2000)
    SetCamCoord(cam, -800.5, 334.81, 221.82) 
    RenderScriptCams(1, 0, 0, 1, 1)
	SetCamRot(cam, 0.0, 0.0, -135.5482)
    Citizen.Wait(3000)
	TaskGoStraightToCoord(PlayerPedId(), -797.22, 327.84, 220.43, 1.0, 100000, 3.0, 2.0)
	Citizen.Wait(1000)
    SetCamCoord(cam, -799.29, 326.48, 221.25) 
    RenderScriptCams(1, 0, 0, 1, 1)
	SetCamRot(cam, 0.0, 0.0, -32.38942)
    Citizen.Wait(3000)
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
	TriggerEvent('hud:loadMenuClotheFIRST')
end)

function CreateNamedRenderTargetForModel(name, model)
    local text = 0
    if not IsNamedRendertargetRegistered(name) then
        RegisterNamedRendertarget(name, 0)
    end
    if not IsNamedRendertargetLinked(model) then
        LinkNamedRendertarget(model)
    end
    if IsNamedRendertargetRegistered(name) then
        text = GetNamedRendertargetRenderId(name)
    end

    return text
end

RegisterNetEvent("rtx_selection:showmenu")
AddEventHandler("rtx_selection:showmenu", function()
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetEntityCoords(PlayerPedId(), -1036.02, -2737.04, 19.2, 0.0, 0.0, 0.0, true)
	Citizen.Wait(1000)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	enablee = false
	Collision(false)
end)