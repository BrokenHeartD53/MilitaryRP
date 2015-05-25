if (CLIENT) then
	SWEP.Author = "Subject_Alpha"
	SWEP.Contact = ""
	SWEP.Purpose = ""
	SWEP.Instructions = ""
	SWEP.PrintName = "Glock 18"
	SWEP.Instructions = "Shoot with it"
	SWEP.Slot = 1
	SWEP.SlotPos = 0
	SWEP.IconLetter = "c"

	killicon.AddFont("weapon_p228","CSKillIcons",SWEP.IconLetter,Color(255,80,0,255))
end

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

SWEP.Base = "mrp_base"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "MilitaryRP"

SWEP.ViewModelFOV    = 75
SWEP.ViewModel = "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.HoldType = "pistol"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.Sound = Sound("Weapon_Glock.Single")
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Unrecoil = 6
SWEP.Primary.Damage = 45
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.03
SWEP.Primary.ClipSize = 10
SWEP.Primary.Delay = 0.1
SWEP.Primary.DefaultClip = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

--Start of Firemode configuration
SWEP.IronSightsPos = Vector(-5.77, -6.6, 2.7)
SWEP.IronSightsAng = Vector(0.9, 0, 0)
