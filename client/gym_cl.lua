local training,isResting = false,false
ESX = nil
function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local isMember = true

function isMemberFunction()
	lib.callback('hx_sporten:hasID',false,function(r)
		isMember = r
	end)
	return isMember
end

Citizen.CreateThread(function()
	for _, info in pairs(Config.Blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
	while ESX == nil do
		TriggerEvent('ishgucciNiffo:getFuckingDuckedWhileSitting',function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
end)

function trainArms()
	if not ifResting() then
		if isMemberFunction() then
			Citizen.Wait(1000)
			local pPed = PlayerPedId()
			TaskStartScenarioInPlace(pPed, "world_human_muscle_free_weights", 0, true)
			TriggerServerEvent('hx_sporten:beginTraining','arms')
			exports.rprogress:Start('Armen Trainen',10000)
			ClearPedTasksImmediately(pPed)
			TriggerServerEvent('hx_sporten:endTraining','arms')
			startCooldown('arms')
		else
			TriggerServerEvent('hx_API:newNotify','error',5,'Je hebt geen Leden pas bij je')
		end
	end
end

function trainRuns()
	if not ifResting() then
		if isMemberFunction() then
			Citizen.Wait(1000)
			local pPed = PlayerPedId()
			TaskStartScenarioInPlace(pPed, "WORLD_HUMAN_JOG_STANDING", 0, true)
			TriggerServerEvent('hx_sporten:beginTraining','runs')
			exports.rprogress:Start('Cardio Trainen',10000)
			ClearPedTasksImmediately(pPed)
			TriggerServerEvent('hx_sporten:endTraining','runs')
			startCooldown('runs')
		else
			TriggerServerEvent('hx_API:newNotify','error',5,'Je hebt geen Leden pas bij je')
		end
	end
end

function trainChins()
	if not ifResting() then
		if isMemberFunction() then
			local pPed = PlayerPedId()
			TaskStartScenarioInPlace(pPed, "PROP_HUMAN_MUSCLE_CHIN_UPS", 0, true)
			local fishingRod = GetClosestObjectOfType(playerPedPos, 2.0, GetHashKey("prop_fishing_rod_01"), false, false, false)
			TriggerServerEvent('hx_sporten:beginTraining','chins')
			exports.rprogress:Start('Bovenlichaam Trainen',15000)
			ClearPedTasksImmediately(pPed)
			TriggerServerEvent('hx_sporten:endTraining','chins')
			startCooldown('chins')
		else
			TriggerServerEvent('hx_API:newNotify','error',5,'Je hebt geen Leden pas bij je')
		end
	end
end

function trainYoga()
	if not ifResting() then
		if isMemberFunction() then
			local pPed = PlayerPedId()
			TaskStartScenarioInPlace(pPed, "WORLD_HUMAN_YOGA", 0, true)
			TriggerServerEvent('hx_sporten:beginTraining','yoga')
			exports.rprogress:Start('Yoga Trainen',15000)
			ClearPedTasksImmediately(pPed)
			TriggerServerEvent('hx_sporten:endTraining','yoga')
			startCooldown('yoga')
		else
			TriggerServerEvent('hx_API:newNotify','error',5,'Je hebt geen Leden pas bij je')
		end
	end
end

function trainushup()
	if not ifResting() then
		if isMemberFunction() then
			local pPed = PlayerPedId()
			TaskStartScenarioInPlace(pPed, "WORLD_HUMAN_PUSH_UPS", 0, true)
			TriggerServerEvent('hx_sporten:beginTraining','pushups')
			exports.rprogress:Start('Pushups Trainen',15000)
			ClearPedTasksImmediately(pPed)
			TriggerServerEvent('hx_sporten:endTraining','pushups')
			startCooldown('pushups')
		else
			TriggerServerEvent('hx_API:newNotify','error',5,'Je hebt geen Leden pas bij je')
		end
	end
end

function flexSpieren()
	if isMemberFunction() then
		local pPed = PlayerPedId()
		TaskStartScenarioInPlace(pPed, "WORLD_HUMAN_MUSCLE_FLEX", 0, true)
		exports.rprogress:Start('Spieren Showen',20000)
		ClearPedTasksImmediately(pPed)
	else
		TriggerServerEvent('hx_API:newNotify','error',5,'Je hebt geen Leden pas bij je')
	end
end

function startCooldown(type)
	isResting = true
	if type == 'arms' then
		Citizen.Wait(Config.Timers.arms*1000)
		isResting = false
	elseif type == 'runs' then
		Citizen.Wait(Config.Timers.runs*1000)
		isResting = false
	elseif type == 'pushups' then
		Citizen.Wait(Config.Timers.puhsups*1000)
		isResting = false
	elseif	type == 'yoga' then
		Citizen.Wait(Config.Timers.yoga*1000)
		isResting = false
	elseif type == 'situps' then
		Citizen.Wait(Config.Timers.situps*1000)
		isResting = false
	elseif type == 'chins' then
		Citizen.Wait(Config.Timers.chins*1000)
		isResting = false
	else
		isResting = false
	end
end

RegisterNetEvent('hx_sporten:mainMenu',function()
	TriggerEvent("nh-context:createMenu", {
        {
            header = "Sportschool",
        },
        {
            header = "Winkel",
            context = "Voor al u sport artikelen",
            event = "hx_sporten:sportWinkelMenu"
        },
		{
            header = "Sport Abonnement (€100)",
            context = "De enige pas die in je leven belangrijk is",
            event = "hx_sporten:buyID",
			server = true
        },
    })
end)

RegisterNetEvent('hx_sporten:kledingMenu',function()
	TriggerEvent("nh-context:createMenu", {
        {
            header = "Kleed Kamer",
        },
        {
            header = "Swem Kleding",
            context = "Verander in zwem kleding",
            event = "hx_sporten:zwemKleding"
        },
		{
            header = "Normale Kleding",
            context = "Wissel terug naar normale kleding",
            event = "hx_sporten:normaleKleding"
        },
		{
            header = "Kleedruimte",
            context = "Wissel naar opgeslagen setjes",
			job = 'police',
            event = "koe_storageunits:viewClothes"
        },
    })
end)

RegisterNetEvent('hx_sporten:sportWinkelMenu', function(id, number)
    TriggerEvent('nh-context:createMenu', {
        {
            header = "< Terug",
            event = "hx_sporten:mainMenu"
        },
        {
            header = 'Proteïne Shake',
            context = '€6',
			event = 'hx_sporten:buyShake',
			server = true,
        },
		{
            header = 'Powerade',
            context = '€4',
			event = 'hx_sporten:buyPowerade',
			server = true,
        },
		{
            header = 'Sport Lunch',
            context = '€12',
			event = 'hx_sporten:buyLunch',
			server = true,
        },
    })
end)

function ifResting()
	if isResting then TriggerServerEvent('hx_API:newNotify','error',5,'Je zit nog in je rust periode') end
	return isResting
end

RegisterNetEvent('anim')
AddEventHandler('anim',function(anim)
	local pPed = PlayerPedId()
	TaskStartScenarioInPlace(pPed, anim, 0, true)
end)

RegisterNetEvent('hx_sporten:zwemKleding')
AddEventHandler('hx_sporten:zwemKleding',function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadClothes', skin, Config.ZwemKleding['zwemKleding']['man'])
		else
			TriggerEvent('skinchanger:loadClothes', skin, Config.ZwemKleding['zwemKleding']['vrouw'])
		end
	end)
end)

RegisterNetEvent('hx_sporten:normaleKleding')
AddEventHandler('hx_sporten:normaleKleding',function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end)