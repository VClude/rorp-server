# 12/12/2019 - Fix
Added proper SQL.

# 13/12/2019 - Fix
Fixed the knocking not working.
Resource name was forgotten in the event handlers.

# 13/12/2019 - Update
Added police raiding to properties.
Set your police job name in the config, any any police member will have the "raid property" option, alongside "knock on door".
This will only work for non-home motels (much like knocking on door).

# 29/12/2019 - Update
Added repayment as percentage instead of whole figure in config.lua
Percentage of motel value as repayment (every 24 hours).

# 2/01/2020
New dependency required. Check readme.md

# 18/01/2020
Added support for disc-inventoryhud via config option.

# 19/01/2020
Added drawtext instead of drawmarker/help notification option in config

# 3/02/2020
Potentially fixed motels spawning with rotation

# 3/03/2020
Add config option to hide other peoples doors at home motel.
Add support for both esx inventory item limit and esx weight limit.
Weapons storing as multiple items (seemingly) correctly.
NOTE: I was using the latest versions of es_extended, essentialmode and esx_inventoryhud (shops version) while using this mod.

# 9/03/2020
Added config option to stop players from paying rent for motels past the initial purchase.
Hopefully fixed other players dissapearing when entering/exiting motels (praise groots friends cousins sisters neighbours keen eye). 

# 12/03/2020
Re-added config option to hide other peoples doors at home motel.

# 29/03/2020
Hopefully fixed other players dissapearing when entering/exiting motels (again...)
  ## FILES CHANGED
    - client.lua
      - search for: ESX.Game.GetPeds

# 15/06/2020
Added config option for bank account name.
