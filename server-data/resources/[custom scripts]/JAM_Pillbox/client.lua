RegisterNetEvent('JAM_Pillbox:DoNotify')
RegisterNetEvent('JAM_Pillbox:GetTreated')

local JPB = JAM_Pillbox

function JPB:Start()
  while not ESX do Citizen.Wait(0); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end

  self:DrawBlips()
  self:Update()
end

function JPB:Update()
  while true do
    Citizen.Wait(0)
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    local dist = Utils:GetVecDist(plyPos, self.HospitalPosition)
    if dist < self.LoadZoneDist then
      local closestKey,closestVal,closestDist = self:GetClosestAction(plyPos)
      if closestDist < self.DrawTextDist then
        local pos = closestVal
        local rot = self.BedRotations[closestVal] or false
        if closestKey == 1 then
          if self.PatientID then Utils:DrawText3D(pos.x,pos.y,pos.z, "~h~Press [~r~E~s~] to check yourself out.")
          else Utils:DrawText3D(pos.x,pos.y,pos.z, self.ActionText[closestKey])
          end
        elseif closestKey == 2 then
          if not self.LayingDown then
            Utils:DrawText3D(pos.x,pos.y,pos.z, self.ActionText[closestKey])
          end
        end
        if closestDist < self.InteractDist then
          if Utils:GetKeyPressed("E") then
            self:DoAction(self.Actions[closestKey], pos or false, rot or false)
          end
        end
      end
    else
      if self.PatientID then
        self:CheckPlayerOut()
      end
    end
  end
end

function JPB:DoAction(action, pos, rot)
  local plyPed = GetPlayerPed(-1)
  if action == "Check In" then
    if self.PatientID then
      self:CheckPlayerOut()
    else
      ESX.TriggerServerCallback('JAM_Pillbox:GetCapacity', function(capacity,id)
        if capacity >= self.MaxCapacity then
          ESX.ShowNotification("The hospital is currently full!")
        else
          self:CheckPlayerIn(id)
        end
      end)
    end
  elseif action == "Lay Down" and pos and rot then
    self.LayingDown = not self.LayingDown
    if self.LayingDown then
      self:PutInBed(plyPed,pos,rot.y)
    end
  end
end

function JPB:PutInBed(ped,pos,heading)
    DoScreenFadeOut(950)
    Wait(1000)
    SetEntityCoordsNoOffset(ped, pos, 0, 0, 0)
    SetEntityHeading(ped, heading)
    ESX.TriggerServerCallback('JAM_Pillbox:GetOnlineEMS', function(count)
      local animTime = self.AutoHealTimer * 1000
      if count then animTime = -1; end

      ESX.Streaming.RequestAnimDict("missfbi5ig_0",function()
        TaskPlayAnim(ped, "missfbi5ig_0", "lyinginpain_loop_steve", 8.0, 1.0, animTime, 45, 1.0, 0, 0, 0)
      end)

      Citizen.CreateThread(function(...) 
        while self.LayingDown do
          Citizen.Wait(0)
          DisablePlayerFiring(playerPed, true) -- Disable weapon firing
          DisableControlAction(0,  25, true) -- INPUT_AIM
          DisableControlAction(0,  30, true) -- UP
          DisableControlAction(0,  31, true) -- DOWN
          DisableControlAction(0,  32, true) -- UP
          DisableControlAction(0,  33, true) -- DOWN
          DisableControlAction(0,  34, true) -- LEFT
          DisableControlAction(0,  35, true) -- RIGHT
          DisableControlAction(0, 142, true) -- MeleeAttackAlternate
          DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
          DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
        end
      end)

      Wait(1000)
      DoScreenFadeIn(10000)

      if not count or count < self.MinEMSCount then
        if self.UsingProgressBars then 
          exports['progressBars']:startUI((self.AutoHealTimer - 2) * 1000, "Healing")
        end

        Wait((self.AutoHealTimer - 2) * 1000)

        DoScreenFadeOut(950)
        Wait(1000)

        SetEntityHealth(ped,200)
        ClearPedBloodDamage(ped)
        ResetPedVisibleDamage(ped)
        ClearPedTasksImmediately(ped)

        if self.UsingSkeletalSystem then
          TriggerEvent('MF_SkeletalSystem:HealBones', "all")
        end

        if self.UsingBasicNeeds then
          TriggerEvent('esx_basicneeds:healPlayer')
        end

        local newPos = self.GetUpLocations[pos]
        SetEntityCoords(ped,newPos.x,newPos.y,newPos.z)
        SetEntityHeading(ped,newPos.w)

        Wait(1000)
        DoScreenFadeIn(1000)
        self.LayingDown = false
      else
        TriggerServerEvent('JAM_Pillbox:NotifyEMS')

        if self.UsingProgressBars then 
          exports['progressBars']:startUI(10000000 * 1000000, "Waiting for EMS")
        end
        local timer = GetGameTimer()
        while (GetGameTimer() - timer) < (((self.AutoHealTimer + 1)*self.OnlineEMSTimerMultiplier) * 1000) and not self.BeingTreated do
          Citizen.Wait(0)
        end
        
        exports['progressBars']:closeUI()
        if not self.BeingTreated then

          if self.UsingProgressBars then 
            exports['progressBars']:startUI((self.AutoHealTimer - 2) * 1000, "Healing")
          end

          Wait((self.AutoHealTimer - 2) * 1000)

          DoScreenFadeOut(950)
          Wait(1000)

          SetEntityHealth(ped,200)
          ClearPedBloodDamage(ped)
          ResetPedVisibleDamage(ped)
          ClearPedTasksImmediately(ped)

          if self.UsingSkeletalSystem then
            TriggerEvent('MF_SkeletalSystem:HealBones', "all")
          end

          if self.UsingBasicNeeds then
            TriggerEvent('esx_basicneeds:healPlayer')
          end

          local newPos = self.GetUpLocations[pos]
          SetEntityCoords(ped,newPos.x,newPos.y,newPos.z)
          SetEntityHeading(ped,newPos.w)

          Wait(1000)
          DoScreenFadeIn(1000)
          self.LayingDown = false
        else

          if self.UsingProgressBars then 
            exports['progressBars']:startUI(self.HealingTimer * 1000, "Healing")
          end

          Wait((self.HealingTimer - 2) * 1000)

          DoScreenFadeOut(950)
          Wait(1000)

          SetEntityHealth(ped,200)
          ClearPedBloodDamage(ped)
          ResetPedVisibleDamage(ped)
          ClearPedTasksImmediately(ped)

          if self.UsingSkeletalSystem then
            TriggerEvent('MF_SkeletalSystem:HealBones', "all")
          end

          if self.UsingBasicNeeds then
            TriggerEvent('esx_basicneeds:healPlayer')
          end

          local newPos = self.GetUpLocations[pos]
          SetEntityCoords(ped,newPos.x,newPos.y,newPos.z)
          SetEntityHeading(ped,newPos.w)

          Wait(1000)
          DoScreenFadeIn(1000)
          self.LayingDown = false
        end
      end
    end)      
end

function JPB:CheckPlayerIn(id)
  self.PatientID = id
  local canDo = false
  ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
    self.ActionMarkers[#self.ActionMarkers+1] = self.BedLocations[id]
    if isDead then
      Citizen.CreateThread(function(...)

        TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
        DoScreenFadeOut(4500)
        Wait(5000)
        TriggerEvent('esx_ambulancejob:revive')
        local timer = GetGameTimer()
        while (GetGameTimer() - timer) < 2000 do
          Citizen.Wait(0)
          DoScreenFadeOut(1)
        end

        local loc = self.BedLocations[id]
        local rot = self.BedRotations[loc]
        self:PutInBed(GetPlayerPed(-1),loc,rot.y)
        self.LayingDown = true
        canDo = true
      end)
    else
      canDo = true
    end
  end)

  while not canDo do Citizen.Wait(0); end
  TriggerServerEvent('JAM_Pillbox:CheckIn',id)

  if self.UseHospitalClothing then
    local plyPed = GetPlayerPed(-1)
    TriggerEvent('skinchanger:getSkin', function(skin)
      if skin.sex == 0 then
        TriggerEvent('skinchanger:loadClothes', skin, JPB.Outfits['patient_wear'].male)
      else
        TriggerEvent('skinchanger:loadClothes', skin, JPB.Outfits['patient_wear'].female)
      end
    end)  
  end
end

function JPB:CheckPlayerOut()
  TriggerServerEvent('JAM_Pillbox:CheckOut',self.PatientID)
  ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin) 
    TriggerEvent('skinchanger:loadSkin', skin)
  end)
  table.remove(self.ActionMarkers, #self.ActionMarkers)
  self.PatientID = false
  self.LayingDown = false
end

function JPB:GetClosestAction(plyPos)
  local plyPos = plyPos
  local closestKey,closestVal,closestDist
  for k,v in pairs(self.ActionMarkers) do
    if v then
      local dist = Utils:GetVecDist(plyPos,v)
      if not closestDist or dist < closestDist then
        closestKey = k
        closestVal = v
        closestDist = dist
      end
    end
  end
  if not closestKey then return false,false,999999
  else return closestKey,closestVal,closestDist
  end
end

function JPB:DrawBlips()
  local blip = AddBlipForCoord(self.HospitalPosition.x, self.HospitalPosition.y, self.HospitalPosition.z)
  SetBlipSprite               (blip, 61)
  SetBlipDisplay              (blip, 3)
  SetBlipScale                (blip, 1.0)
  SetBlipColour               (blip, 1)
  SetBlipAsShortRange         (blip, false)
  SetBlipHighDetail           (blip, true)
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ("Pillbox Hospital")
  EndTextCommandSetBlipName   (blip)
end

function JPB:TreatPlayer()
  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local closestKey,closestVal,closestDist = self:GetClosestBed(plyPos)
  if closestDist < self.InteractDist then
    local closestPly = ESX.Game.GetClosestPlayer(closestVal)
    local closestPed = GetPlayerPed(closestPly)
    if closestPed ~= plyPed then

      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
      Wait(5000)
      TriggerServerEvent('JAM_Pillbox:TreatPlayer', GetPlayerServerId(closestPly))
      Wait(5000)
      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, false)
      Wait(1000)
      ClearPedTasksImmediately(plyPed)
    end
  end
end

function JPB:GetClosestBed(plyPos)
  local key,val,dist
  for k,v in pairs(self.BedLocations) do
    local nDist = Utils:GetVecDist(plyPos,v)
    if not dist or nDist < dist then
      key = k
      val = v
      dist = nDist
    end
  end
  if key then return key,val,dist
  else return false,false,false
  end
end

Citizen.CreateThread(function(...) JPB:Start(...); end)

AddEventHandler('JAM_Pillbox:DoNotify', function(...) ESX.ShowNotification('Somebody needs medical assistance at Pillbox Hospital!'); end)
AddEventHandler('JAM_Pillbox:GetTreated', function(...) JPB.BeingTreated = true; end)

RegisterCommand('treatPlayer', function(...) JPB:TreatPlayer(...); end)