function ulx.addXP(calling_ply, target_ply, amount)
	if not amount then ULib.tsayError("Amount not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	target_ply:addXP(amount, true)
	DarkRP.notify(target_ply, 0,4,calling_ply .. " gave you "..amount.."XP")
	ulx.fancyLogAdmin(calling_ply .. ' gave '..target_ply..' '..amount)
end
local addXPx = ulx.command("Levels", "ulx addxp", ulx.addXP, "!addxp")
addXPx:addParam{type=ULib.cmds.PlayerArg}
addXPx:addParam{type=ULib.cmds.NumArg, hint="xp"}
addXPx:defaultAccess(ULib.ACCESS_ADMIN)
addXPx:help("Add XP to a player.")

function ulx.setLevel(calling_ply, target_ply, level)
	if not level then ULib.tsayError("Level not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	DarkRP.storeXPData(target_ply,level,0)
        target_ply:setDarkRPVar('level',level)
        target_ply:setDarkRPVar('xp',0)
	DarkRP.notify(target_ply, 0,4,calling_ply .. " set your level to "..level)
	ulx.fancyLogAdmin(calling_ply .. ' set '..target_ply..' level to '..level)
end
local setLevelx = ulx.command("Levels", "ulx setlevel", ulx.setLevel, "!setlevel")
setLevelx:addParam{type=ULib.cmds.PlayerArg}
setLevelx:addParam{type=ULib.cmds.NumArg, hint="level"}
setLevelx:defaultAccess(ULib.ACCESS_ADMIN)
setLevelx:help("Set a players level.")

function ulx.setPrestige(calling_ply, target_ply, level)
	if not level then ULib.tsayError("Prestige not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
        DarkRP.storePrestigeData(target_ply, level)
        target_ply:setDarkRPVar('prestige',level)
	DarkRP.notify(target_ply, 0,4,calling_ply .. " set your prestige to "..level)
	ulx.fancyLogAdmin(calling_ply .. ' set '..target_ply..' prestige to '..level)
end
local setLevel2x = ulx.command("Levels", "ulx setprestige", ulx.setPrestige, "!setprestige")
setLevel2x:addParam{type=ULib.cmds.PlayerArg}
setLevel2x:addParam{type=ULib.cmds.NumArg, hint="prestige"}
setLevel2x:defaultAccess(ULib.ACCESS_ADMIN)
setLevel2x:help("Set a players prestige.")