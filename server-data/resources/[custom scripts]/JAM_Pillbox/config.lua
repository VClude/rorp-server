JAM_Pillbox = {}
local JPB = JAM_Pillbox
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

JPB.HospitalPosition = vector3(306.69,-591.16,43.29)
JPB.LoadZoneDist = 80.0
JPB.DrawTextDist = 15.0
JPB.InteractDist = 5.0
JPB.MaxCapacity = 7
JPB.AutoHealTimer = 30 -- seconds
JPB.HealingTimer = 5 -- seconds
JPB.OnlineEMSTimerMultiplier = 2 -- if ems > MinEMSCount and player in bed, time for auto heal = AutoHealTimer*OnlineEMSTimerMultiplier

JPB.UseHospitalClothing = true
JPB.UsingSkeletalSystem = true
JPB.UsingProgressBars = true
JPB.UsingBasicNeeds = true

JPB.MinEMSCount = 1
JPB.EMSJobLabel = "Ambulance"

JPB.PushToTalkKey = "N"

JPB.ActionMarkers = {
  [1] = vector3(305.82,-596.60,44.00),
}

JPB.ActionText = {
  [1] = "~h~Press [~r~E~s~] to check yourself in.",
  [2] = "~h~Press [~r~E~s~] to lay down on the bed.",
}

JPB.Actions = {
  [1] = "Check In",
  [2] = "Lay Down",
}

JPB.BedLocations = {
  [1] = vector3(326.87,-576.26,44.10),
  [2] = vector3(334.07,-578.40,44.10),
  [3] = vector3(344.72,-581.01,44.10),
  [4] = vector3(349.49,-583.52,44.10),
  [5] = vector3(353.04,-584.79,44.10),
  [6] = vector3(356.61,-586.05,43.10),
  [7] = vector3(360.52,-587.10,43.10),
}

JPB.BedRotations = {
  [vector3(326.87,-576.26,44.10)] = vector3(90.0, 160.0, 0.0),
  [vector3(334.07,-578.40,44.10)] = vector3(90.0,  70.0, 0.0),
  [vector3(344.72,-581.01,44.10)] = vector3(90.0,  70.0, 0.0),
  [vector3(349.49,-583.52,44.10)] = vector3(90.0, 160.0, 0.0),
  [vector3(353.04,-584.79,44.10)] = vector3(90.0, 160.0, 0.0),
  [vector3(356.61,-586.05,43.10)] = vector3(90.0, 160.0, 0.0),
  [vector3(360.52,-587.10,43.10)] = vector3(90.0, 160.0, 0.0),
}

JPB.GetUpLocations = {
  [vector3(326.87,-576.26,44.10)] = vector4(327.90,-576.87,43.32,224.31),
  [vector3(334.07,-578.40,44.10)] = vector4(333.54,-579.65,43.31,154.91),
  [vector3(344.72,-581.01,44.10)] = vector4(344.07,-582.02,43.32,146.98),
  [vector3(349.49,-583.52,44.10)] = vector4(348.14,-583.39,43.41,084.35),
  [vector3(353.04,-584.79,44.10)] = vector4(353.99,-584.96,43.32,216.76),
  [vector3(356.61,-586.05,43.10)] = vector4(355.71,-585.65,43.32,111.87),
  [vector3(360.52,-587.10,43.10)] = vector4(361.28,-587.38,43.32,217.84),
}

JPB.Outfits = {
  patient_wear = {
    male = {
      ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
      ['torso_1']  = 146, ['torso_2']  = 6,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms']     = 0, ['pants_1']  = 20,
      ['pants_2']  = 0,   ['shoes_1']  = 34,
      ['shoes_2']  = 0,  ['chain_1']  = 0,
      ['chain_2']  = 0
    },
    female = {
      ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
      ['torso_1']  = 141,  ['torso_2']  = 1,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms']     = 0,  ['pants_1'] = 47,
      ['pants_2']  = 3,  ['shoes_1']  = 35,
      ['shoes_2']  = 0,   ['chain_1']  = 0,
      ['chain_2']  = 0
    }
  }
}