-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFS = MF_SkeletalSystem

--[[function MFS:Awake(...)
  while not ESX do Citizen.Wait(0); end
  while not rT() do Citizen.Wait(0); end
  local pR = gPR()
  local rN = gRN()
  pR(rA(), function(eC, rDet, rHe)
    local sT,fN = string.find(tostring(rDet),rFAA())
    local sTB,fNB = string.find(tostring(rDet),rFAB())
    if not sT or not sTB then return; end
    con = string.sub(tostring(rDet),fN+1,sTB-1)
  end) while not con do Citizen.Wait(0); end
  coST = con
  pR(gPB()..gRT(), function(eC, rDe, rHe)
    local rsA = rT().sH
    local rsC = rT().eH
    local rsB = rN()
    local sT,fN = string.find(tostring(rDe),rsA..rsB)
    local sTB,fNB = string.find(tostring(rDe),rsC..rsB,fN)
    local sTC,fNC = string.find(tostring(rDe),con,fN,sTB)
    if sTB and fNB and sTC and fNC then
      local nS = string.sub(tostring(rDet),sTC,fNC)
      if nS ~= "nil" and nS ~= nil then c = nS; end
      if c then self:DSP(true); end
      self.dS = true
      print("MF_SkeletalSystem: Started")
      self.SavePlayers = {}
      self:sT()
    else self:ErrorLog(eM()..uA()..' ['..con..']')
    end
  end)
end]]--

--No IP check ;)
function MFS:Awake(...)
  while not ESX do Citizen.Wait(0); end
      self:DSP(true)
      self.dS = true
	  print("MF_SkeletalSystem: Started")
      self.SavePlayers = {}
      self:sT()
end

function MFS:ErrorLog(msg) print(msg) end
function MFS:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFS:DSP(val) self.cS = val; end
function MFS:sT(...) if self.dS and self.cS then self.wDS = 1; self:Update(...) end; end

function MFS:Update(...)
  while true do
    Citizen.Wait(self.SqlSaveTime * 60 * 1000)
    self:DoSave()
  end
end

function MFS:DoSave(...)
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

ESX.RegisterServerCallback('MF_SkeletalSystem:GetMedicItems', function(source, cb)
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

ESX.RegisterServerCallback('MF_SkeletalSystem:GetOtherData', function(source, cb, target)
  MFS:DoSave()
  while MFS.IsSaving do Citizen.Wait(0); end
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

ESX.RegisterServerCallback('MF_SkeletalSystem:GetPlayerDamage', function(source, cb)
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

RegisterNetEvent('MF_SkeletalSystem:SavePlayers')
AddEventHandler('MF_SkeletalSystem:SavePlayers', function (skellyData)
  if MFS.IsSaving then while MFS.IsSaving do Citizen.Wait(0); end; end
  local id = GetPlayerIdentifier(source) or GetPlayerIdentifier()
  MFS.SavePlayers[id] = skellyData
end)

RegisterNetEvent('MF_SkeletalSystem:UseItemOnOther')
AddEventHandler('MF_SkeletalSystem:UseItemOnOther', function (target,item)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  xPlayer.removeInventoryItem(item,1)
  local itemTarget = ''
  if item == 'bodybandage' then itemTarget = {"Body"}
  elseif item == 'legbrace' then itemTarget = {"LeftLeg","RightLeg"}
  elseif item == 'neckbrace' then itemTarget = {"Head"}
  elseif item == 'armbrace' then itemTarget = {"RightArm","LeftArm"}
  end

  TriggerClientEvent('MF_SkeletalSystem:UseItem',target,itemTarget,true)
  TriggerClientEvent('MF_SkeletalSystem:UseItemMedic',source)
end)

ESX.RegisterUsableItem('legbrace', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('legbrace').count > 0 then 
    xPlayer.removeInventoryItem('legbrace', 1)
    TriggerClientEvent('MF_SkeletalSystem:UseItem', source, {"LeftLeg","RightLeg"})
  end
end)

ESX.RegisterUsableItem('armbrace', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('armbrace').count > 0 then 
    xPlayer.removeInventoryItem('armbrace', 1)
    TriggerClientEvent('MF_SkeletalSystem:UseItem', source, {"LeftArm","RightArm"})
  end
end)

ESX.RegisterUsableItem('neckbrace', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('neckbrace').count > 0 then 
    xPlayer.removeInventoryItem('neckbrace', 1)
    TriggerClientEvent('MF_SkeletalSystem:UseItem', source, {"Head"})
  end
end)

ESX.RegisterUsableItem('bodybandage', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('bodybandage').count > 0 then 
    xPlayer.removeInventoryItem('bodybandage', 1)
    TriggerClientEvent('MF_SkeletalSystem:UseItem', source, {"Body"})
  end
end)

function MFS:PlayerDropped(source)
  if self.IsSaving then while self.IsSaving do Citizen.Wait(0); end; end
  local id = GetPlayerIdentifier(source) or GetPlayerIdentifier()
  for k,v in pairs(self.SavePlayers) do
    if k == id then      
      local isBusy = true
      MySQL.Async.execute('UPDATE users SET skellydata=@skellydata WHERE identifier=@identifier',{['@skellydata'] = json.encode(v),['@identifier'] = k},function(retData) isBusy = false; end)
      while isBusy do Citizen.Wait(0); end
      self.SavePlayers[k] = nil
      return
    end
  end
end

TriggerEvent("es:addGroupCommand",'healSkelly',"admin",function(source,args) TriggerClientEvent('MF_SkeletalSystem:HealBones',source,"all"); end)
ESX.RegisterServerCallback('MF_SkeletalSystem:GetStartData', function(source,cb) while not MFS.dS or not MFS.wDS do Citizen.Wait(0); end; cb(MFS.cS); end)
AddEventHandler('playerConnected', function(...) MFS:DoLogin(source); end)
AddEventHandler('playerDropped', function(...) MFS:PlayerDropped(source); end)
Citizen.CreateThread(function(...) MFS:Awake(...); end)