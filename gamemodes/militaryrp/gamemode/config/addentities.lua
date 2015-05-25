DarkRP.createShipment("Desert eagle", {
	model = "models/weapons/w_pist_deagle.mdl",
	entity = "mrp_deagle",
	price = 215,
	amount = 10,
	seperate = true,
	pricesep = 215,
	noship = true,
	allowed = {TEAM_GUN},
	category = "Pistols",
})

DarkRP.createShipment("Fiveseven", {
	model = "models/weapons/w_pist_fiveseven.mdl",
	entity = "mrp_fiveseven",
	price = 0,
	amount = 10,
	seperate = true,
	pricesep = 205,
	noship = true,
	allowed = {TEAM_GUN},
	category = "Pistols",
})

DarkRP.createShipment("Glock", {
	model = "models/weapons/w_pist_glock18.mdl",
	entity = "mrp_glock",
	price = 0,
	amount = 10,
	seperate = true,
	pricesep = 160,
	noship = true,
	allowed = {TEAM_GUN},
	category = "Pistols",
})

DarkRP.createShipment("P228", {
	model = "models/weapons/w_pist_p228.mdl",
	entity = "mrp_p228",
	price = 0,
	amount = 10,
	seperate = true,
	pricesep = 185,
	noship = true,
	allowed = {TEAM_GUN},
	category = "Pistols",
})

DarkRP.createShipment("AK47", {
	model = "models/weapons/w_rif_ak47.mdl",
	entity = "mrp_ak47",
	price = 2450,
	amount = 10,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN},
	category = "Rifles",
})

DarkRP.createShipment("MP5", {
	model = "models/weapons/w_smg_mp5.mdl",
	entity = "mrp_mp5",
	price = 2200,
	amount = 10,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN},
	category = "Rifles",
})

DarkRP.createShipment("M4", {
	model = "models/weapons/w_rif_m4a1.mdl",
	entity = "mrp_m4",
	price = 2450,
	amount = 10,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN},
	category = "Rifles",
})

DarkRP.createShipment("Mac 10", {
	model = "models/weapons/w_smg_mac10.mdl",
	entity = "mrp_mac10",
	price = 2150,
	amount = 10,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN}
})

DarkRP.createShipment("Pump shotgun", {
	model = "models/weapons/w_shot_m3super90.mdl",
	entity = "mrp_pumpshotgun",
	price = 1750,
	amount = 10,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN},
	category = "Shotguns",
})

DarkRP.createShipment("Sniper rifle", {
	model = "models/weapons/w_snip_g3sg1.mdl",
	entity = "ls_sniper",
	price = 3750,
	amount = 10,
	seperate = false,
	pricesep = nil,
	noship = false,
	allowed = {TEAM_GUN},
	category = "Snipers",
})

if not DarkRP.disabledDefaults["modules"]["hungermod"] then
	DarkRP.createEntity("Microwave", {
		ent = "microwave",
		model = "models/props/cs_office/microwave.mdl",
		price = 400,
		max = 1,
		cmd = "buymicrowave",
		allowed = TEAM_COOK
	})
end

DarkRP.createCategory{
	name = "Other",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 255,
}

DarkRP.createCategory{
    name = "Other",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 255,
}

DarkRP.createCategory{
    name = "Rifles",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 100,
}

DarkRP.createCategory{
    name = "Shotguns",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 101,
}

DarkRP.createCategory{
    name = "Snipers",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 102,
}

DarkRP.createCategory{
	name = "Pistols",
	categorises = "weapons",
	startExpanded = true,
	color = Color(0, 107, 0, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 100,
}

DarkRP.createCategory{
	name = "Other",
	categorises = "weapons",
	startExpanded = true,
	color = Color(0, 107, 0, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 255,
}

DarkRP.createCategory{
	name = "Other",
	categorises = "vehicles",
	startExpanded = true,
	color = Color(0, 107, 0, 255),
	canSee = fp{fn.Id, true},
	sortOrder = 255,
}
