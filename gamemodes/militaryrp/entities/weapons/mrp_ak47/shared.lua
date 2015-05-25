if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "AK-47"
	SWEP.Author = "Subject_Alpha"
	SWEP.Slot = 3
	SWEP.SlotPos = 0
	SWEP.IconLetter = "b"

	killicon.AddFont("weapon_ak47", "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255))
end

SWEP.Base = "mrp_base"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "MilitaryRP"

SWEP.UseHands = true
SWEP.ViewModelFOV    = 65
SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.HoldType = "ar2"

SWEP.Primary.Sound = Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil = 3
SWEP.Primary.Damage = 40
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.05
SWEP.Primary.ClipSize = 30
SWEP.Primary.Delay = 0.1
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.IronSightsPos = Vector(-6.6, -15, 2.6)
SWEP.IronSightsAng = Vector(2.6, 0.02, 0)

SWEP.MultiMode = true