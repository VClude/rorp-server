function skeletalsystem:Update(...)
  self.SavePlayers = {}
  while true do
    Citizen.Wait(self.SqlSaveTime * 60 * 1000)
    self:DoSave()
  end
end

function skeletalsystem:DoSave(...)
  if self.IsSaving then return; end  
  self.IsSaving = true
  for k,v in pairs(self.SavePlayers) do
    local isBusy = true
    MySQL.Async.execute('UPDATE users SET skellydata=@skellydata WHERE identifier=@identifier',{['@skellydata'] = json.encode(v),['@identifier'] = k},function(retData) isBusy = false; end)
    while isBusy do Citizen.Wait(0); end
  end
  self.SavePlayers = {}
  self.IsSaving = false
end

ESX.RegisterServerCallback('skeletalsystem:GetMedicItems', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end

  local items = {}
  local bodybandage = xPlayer.getInventoryItem('bodybandage')
  local legbrace = xPlayer.getInventoryItem('legbrace')
  local armbrace = xPlayer.getInventoryItem('armbrace')
  local neckbrace = xPlayer.getInventoryItem('neckbrace')

  if bodybandage and bodybandage.count > 0 then table.insert(items,bodybandage); end
  if legbrace and legbrace.count > 0 then table.insert(items,legbrace); end
  if armbrace and armbrace.count > 0 then table.insert(items,armbrace); end
  if neckbrace and neckbrace.count > 0 then table.insert(items,neckbrace); end

  if not items[1] then cb(false) else cb(items); end
end)

ESX.RegisterServerCallback('skeletalsystem:GetOtherData', function(source, cb, target)
  skeletalsystem:DoSave()
  while skeletalsystem.IsSaving do Citizen.Wait(0); end
  Citizen.Wait(1000)
  local xPlayer = ESX.GetPlayerFromId(target)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(target); end
  local data = MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier=@identifier",{['@identifier'] = xPlayer.identifier},function(data)
    local cbData = false
    if not data or not data[1] or not data[1].skellydata then cbData = false
    else cbData = json.decode(data[1].skellydata)
    end
    cb(cbData)
  end)
end)

ESX.RegisterServerCallback('skeletalsystem:GetPlayerDamage', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local data = MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier=@identifier",{['@identifier'] = xPlayer.identifier},function(data)
    local cbData = false
    if not data or not data[1] or not data[1].skellydata then cbData = false
    else cbData = json.decode(data[1].skellydata)
    end
    cb(cbData)
  end)
end)

RegisterNetEvent('skeletalsystem:SavePlayers')
AddEventHandler('skeletalsystem:SavePlayers', function (skellyData)
  if skeletalsystem.IsSaving then while skeletalsystem.IsSaving do Citizen.Wait(0); end; end
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local id = xPlayer.getIdentifier()
  skeletalsystem.SavePlayers[id] = skellyData
end)

RegisterNetEvent('skeletalsystem:UseItemOnOther')
AddEventHandler('skeletalsystem:UseItemOnOther', function (target,item)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  xPlayer.removeInventoryItem(item,1)
  local itemTarget = ''
  if item == 'bodybandage' then itemTarget = {"Body"}
  elseif item == 'legbrace' then itemTarget = {"LeftLeg","RightLeg"}
  elseif item == 'neckbrace' then itemTarget = {"Head"}
  elseif item == 'armbrace' then itemTarget = {"RightArm","LeftArm"}
  end

  TriggerClientEvent('skeletalsystem:UseItem',target,itemTarget,true)
  TriggerClientEvent('skeletalsystem:UseItemMedic',source)
end)

ESX.RegisterUsableItem('legbrace', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('legbrace').count > 0 then 
    xPlayer.removeInventoryItem('legbrace', 1)
    TriggerClientEvent('skeletalsystem:UseItem', source, {"LeftLeg","RightLeg"})
  end
end)

ESX.RegisterUsableItem('armbrace', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('armbrace').count > 0 then 
    xPlayer.removeInventoryItem('armbrace', 1)
    TriggerClientEvent('skeletalsystem:UseItem', source, {"LeftArm","RightArm"})
  end
end)

ESX.RegisterUsableItem('neckbrace', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('neckbrace').count > 0 then 
    xPlayer.removeInventoryItem('neckbrace', 1)
    TriggerClientEvent('skeletalsystem:UseItem', source, {"Head"})
  end
end)

ESX.RegisterUsableItem('bodybandage', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('bodybandage').count > 0 then 
    xPlayer.removeInventoryItem('bodybandage', 1)
    TriggerClientEvent('skeletalsystem:UseItem', source, {"Body"})
  end
end)

function skeletalsystem:PlayerDropped(source)
  skeletalsystem:DoSave()
end


--
if skeletalsystem.UseESCommand then
  TriggerEvent("es:addGroupCommand",'healSkelly',"admin",function(source,args) TriggerClientEvent('skeletalsystem:HealBones',source,"all"); end)
else
  RegisterCommand('healSkelly',function(source,args) TriggerClientEvent("skeletalsystem:HealBones",source,"all"); end,true)
end

AddEventHandler('playerConnected', function(...) skeletalsystem:DoLogin(source); end)
AddEventHandler('playerDropped', function(...) skeletalsystem:PlayerDropped(source); end)
Citizen.CreateThread(function(...) skeletalsystem:Update(...); end)