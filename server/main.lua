local oxv = exports.ox_inventory
local isTraining = {}

RegisterServerEvent('hx_sporten:buyID')
AddEventHandler('hx_sporten:buyID',function()
	local src = source
	if not hasID(src) then
		local money = getMoney(src)
		if money and money >= 100 then
			oxv:RemoveItem(src,'money',100)
			oxv:AddItem(src,'gym_membership',1)
			boughtItem(src,'Sport Abonnement')
			TriggerClientEvent('hx_sporten:serverResponses',true)
		else
			local am = 100-tonumber(money)
			notEnough(src,am)
		end
	else
		TriggerClientEvent('hx_API:newNotify',src,'error',3,'Je hebt al een pas')
	end
end)

RegisterServerEvent('hx_sporten:buyShake')
AddEventHandler('hx_sporten:buyShake',function()
	local src = source
	local money = getMoney(src)
	if money >= 6 then
		oxv:RemoveItem(src,'money',6)
		oxv:AddItem(src,'protein_shake',1)
		boughtItem(src,'Proteine Shake')
	else
		local am = money - 6
		notEnough(src,am)
	end
end)

RegisterServerEvent('hx_sporten:buyPowerade')
AddEventHandler('hx_sporten:buyPowerade',function()
	local src = source
	local money = getMoney(src)
	if money >= 4 then
		oxv:RemoveItem(src,'money',4)
		oxv:AddItem(src,'powerade',1)
		boughtItem(src,'Powerade')
	else
		local am = money - 4
		notEnough(src,am)
	end
end)

RegisterServerEvent('hx_sporten:buyLunch')
AddEventHandler('hx_sporten:buyLunch',function()
	local src = source
	local money = getMoney(src)
	if money >= 12 then
		oxv:RemoveItem(src,'money',12)
		oxv:AddItem(src,'sportlunch',1)
		boughtItem(src,'Sport Lunch')
	else
		local am = money - 6
		notEnough(src,am)
	end
end)

function hasID(src)
	local item = oxv:Search(src,'count',{'gym_membership'})
	if item and item > 0 then return true else return false end
end
function getMoney(src) return oxv:Search(src,'count',{'money'}) end
function notEnough(src,missing) TriggerClientEvent('hx_API:newNotify',src,'error',3,'Je moet nog €'..missing..' hebben om dit te kopen') end
function boughtItem(src,item) TriggerClientEvent('hx_API:newNotify',src,'success',4,'Je hebt een '..item..' gekocht!') end

lib.callback.register('hx_sporten:hasID',function()
	return hasID(source)
end)

RegisterServerEvent('hx_sporten:beginTraining')
AddEventHandler('hx_sporten:beginTraining',function(type)
	local src = source
	if hasID(src) then
		isTraining[src] = type
	else
		print('[HXSPRT] '..src..' heeft geprobeert training te doen zonder pas. (MOD MENU) | LET OP GEEN AUTO BAN OP DIT EVENT')
	end
end)

RegisterServerEvent('hx_sporten:endTraining')
AddEventHandler('hx_sporten:endTraining',function(type)
	local src = source
	if isTraining[src] == type then
		isTraining[src] = 'none'
		TriggerClientEvent('esx_status:add',src,'thirst',-50000)
		addNewStat(src,type)
	end
end)

RegisterCommand('checkall',function(source,args,rawCommand)
	if #isTraining == 0 then print('[HXSPRT] Niemand is aan het trainen') end
	for sr,type in pairs(isTraining) do
		print(sr..' is '..type..' aan het trainen')
	end
end)

RegisterCommand('anim',function(source,args,rawCommand)
	if #args == 1 then
		TriggerClientEvent('anim',source,args[1])
	end
end)

RegisterCommand('getstats',function(source,args,rawCommand)
	TriggerEvent('hx_sporten:getNewStats',source)
end)

RegisterServerEvent('hx_sporten:getNewStats')
AddEventHandler('hx_sporten:getNewStats',function(source)
	local src = source
	local iden = GetSteam(src)
	MySQL.Async.fetchAll("SELECT * FROM sport_stats WHERE steam = @identifier", {['@identifier'] = iden}, function(result)
		if result[1] then
			local stats = {}
			stats.staminaCt = json.decode(result[1].stamina)
			stats.strengthCt = json.decode(result[1].strength)
			stats.stamLVL = stats.staminaCt/1000
			stats.strenLVL = stats.strengthCt/1000
			TriggerClientEvent('hx_sporten:initStats',src,stats)
		else
			MySQL.Sync.execute("INSERT INTO sport_stats (steam,stamina,strength) VALUES (@steam,@stamina,@strength)", {['steam'] = iden,['stamina'] = 0, ['strength'] = 0})
		end
    end)
end)

RegisterServerEvent('hx_sporten:initStatsSV')
AddEventHandler('hx_sporten:initStatsSV',function()
	TriggerEvent('hx_sporten:getNewStats',source)
end)

function addNewStat(id,type)
	local src = id
	local iden = GetSteam(src)
	if type == 'arms' or type == 'pushups' or type == 'chins' then
		local strengthCt = 0
		MySQL.Async.fetchAll("SELECT * FROM sport_stats WHERE steam = @identifier", {['@identifier'] = iden}, function(result)
			strengthCt = json.decode(result[1].strength)
			MySQL.Async.execute("UPDATE sport_stats SET strength=@strengthCt WHERE steam=@identifier", {['@identifier'] = iden, ['@strengthCt'] = strengthCt+10}) 
		end)
	else
		local staminaCt = 0
		MySQL.Async.fetchAll("SELECT * FROM sport_stats WHERE steam = @identifier", {['@identifier'] = iden}, function(result)
			staminaCt = json.decode(result[1].stamina)
			MySQL.Async.execute("UPDATE sport_stats SET stamina=@staminaCt WHERE steam=@identifier", {['@identifier'] = iden, ['@staminaCt'] = staminaCt+10})
		end)
	end
end


function GetSteam(src)
    local steam = ""
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then
            steam = id
        end
    end
    return steam
end