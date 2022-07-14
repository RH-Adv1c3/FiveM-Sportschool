exports.qtarget:AddTargetModel({1234788901}, {
	options = {
		{
			event = "hx_sporten:kledingMenu",
			icon = "fas fa-box-circle-check",
			label = "Verander Kleding",
			num = 1
		}
	},
	distance = 2
})

exports.qtarget:AddTargetModel({1732037892}, {
	options = {
		{
			event = "hx_sporten:trainRuns",
			icon = "fas fa-box-circle-check",
			label = "Train Runs",
			num = 1
		}
	},
	distance = 2
})

exports.qtarget:AddBoxZone("FlexMirror", vector3(255.92, -265.74, 59.92), 0.45, 0.35, {
	name="FlexMirror",
	heading=-265.74,
	debugPoly=false,
	minZ=57.92,
	maxZ=61.92,
	}, {
		options = {
			{
				event = "hx_sporten:flexAnim",
				icon = "fas fa-sign-in-alt",
				label = "Bekijk Spieren",
			}
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("GymMenu3", vector3(259.96,-270.96,53.96), 0.45, 0.35, {
	name="GymMenu3",
	heading=154.22,
	debugPoly=false,
	minZ=51.44,
	maxZ=55.44,
	}, {
		options = {
			{
				event = "hx_sporten:mainMenu",
				icon = "fas fa-sign-in-alt",
				label = "Open Menu",
			}
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("GymMenu2", vector3(257.56,-270.1,53.44), 0.45, 0.35, {
	name="GymMenu2",
	heading=163.22,
	debugPoly=false,
	minZ=51.44,
	maxZ=55.44,
	}, {
		options = {
			{
				event = "hx_sporten:mainMenu",
				icon = "fas fa-sign-in-alt",
				label = "Open Menu",
			}
		},
		distance = 3.5
})

exports.qtarget:AddBoxZone("GymMenu1", vector3(-1195.15,-1577.25,4.6), 0.45, 0.35, {
	name="GymMenu1",
	heading=307.0,
	debugPoly=false,
	minZ=2,
	maxZ=6,
	}, {
		options = {
			{
				event = "hx_sporten:mainMenu",
				icon = "fas fa-sign-in-alt",
				label = "Open Menu",
			}
		},
		distance = 3.5
})

for k,v in pairs(Config.Arms) do
	exports.qtarget:AddBoxZone("Arms"..k, vector3(v.x,v.y,v.z), 0.45, 0.35, {
		name="Arms"..k,
		heading=v.heading,
		debugPoly=false,
		minZ=v.z-0.5,
		maxZ=v.z+0.5,
		}, {
			options = {
				{
					event = "hx_sporten:trainArms",
					icon = "fas fa-sign-in-alt",
					label = "Train Armen",
				}
			},
			distance = 3.5
	})
end

for k,v in pairs(Config.Chins) do
	exports.qtarget:AddBoxZone("Chins"..k, vector3(v.x,v.y,v.z), 0.45, 0.35, {
		name="Chins"..k,
		heading=v.heading,
		debugPoly=false,
		minZ=v.z-0.5,
		maxZ=v.z+0.5,
		}, {
			options = {
				{
					event = "hx_sporten:trainChins",
					icon = "fas fa-sign-in-alt",
					label = "Train Pullups",
				}
			},
			distance = 3.5
	})
end

for k,v in pairs(Config.Yoga) do
	exports.qtarget:AddBoxZone("Yoga"..k, vector3(v.x,v.y,v.z), 0.45, 0.35, {
		name="Yoga"..k,
		heading=v.heading,
		debugPoly=false,
		minZ=v.z-0.5,
		maxZ=v.z+0.5,
		}, {
			options = {
				{
					event = "hx_sporten:trainYoga",
					icon = "fas fa-sign-in-alt",
					label = "Train Yoga",
				}
			},
			distance = 3.5
	})
end

for k,v in pairs(Config.Pushups) do
	exports.qtarget:AddBoxZone("Pushups"..k, vector3(v.x,v.y,v.z), 0.45, 0.35, {
		name="Pushups"..k,
		heading=v.heading,
		debugPoly=false,
		minZ=v.z-0.5,
		maxZ=v.z+0.5,
		}, {
			options = {
				{
					event = "hx_sporten:trainPushups",
					icon = "fas fa-sign-in-alt",
					label = "Train Pushups",
				}
			},
			distance = 3.5
	})
end

AddEventHandler('hx_sporten:trainArms',function()
	trainArms()
end)

AddEventHandler('hx_sporten:trainRuns',function()
	trainRuns()
end)

AddEventHandler('hx_sporten:trainChins',function()
	trainChins()
end)

AddEventHandler('hx_sporten:trainYoga',function()
	trainYoga()
end)

AddEventHandler('hx_sporten:flexAnim',function()
	flexSpieren()
end)