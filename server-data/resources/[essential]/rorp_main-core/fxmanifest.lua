-- Resource Metadata
fx_version 'bodacious'

game 'gta5'

description 'Main Core RORP Server'
version '1.0.0'

-- What to run
client_scripts {
    'config/NoCarJack_cfg.lua',
    'client/BetterRecoil.lua',
    'client/Crouched.lua',
    'client/DisableSneaking.lua',
    'client/HandsUp.lua',
    'client/HoodAndTrunk.lua',
    'client/NoCarJack_cl.lua',
    'client/NoDriveBy.lua',
    'client/NoHelmet.lua',
    'client/NoMoreWeaponsOnNPC.lua',
    'client/NoRegeneration.lua',
    'client/NoWeaponReward.lua',
    'client/NoWhiping.lua',
    'client/PointingWithFinger.lua',
    'client/PushTheCar.lua',
    'client/Redzone.lua',
    'client/ShowID.lua',
    'client/TLG-ADS.lua',
    'client/TrafficControl.lua',
    'client/SlashK_cl.lua',
    'client/SmartTrafficLights_cl.lua',
    'client/TakeHostage_cl.lua',
    'client/Drift',
    'client/3DMe_cl.lua',
    'client/CarryPeople_cl.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/NoCarJack_sv.lua',
    'server/SlashK_sv.lua',
    'server/SmartTrafficLights_sv.lua',
    'server/TakeHostage_sv.lua',
    'server/3DMe_sv.lua',
    'server/CarryPeople_sv.lua',
}