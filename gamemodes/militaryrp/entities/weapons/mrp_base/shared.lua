
local Sound = Sound
local Vector = Vector
local CreateConVar = CreateConVar
local CurTime = CurTime
local IsFirstTimePredicted = IsFirstTimePredicted
local Angle = Angle
local EffectData = EffectData
local SinglePlayer = SinglePlayer
local FrameTime = FrameTime
local IsValid = IsValid
local WorldSound = WorldSound
local util = util
local hook = hook
local math = math
local timer = timer
local ents = ents
local ACT_VM_IDLE = ACT_VM_IDLE
local PLAYERANIMEVENT_CUSTOM_GESTURE = PLAYERANIMEVENT_CUSTOM_GESTURE
local GESTURE_SLOT_ATTACK_AND_RELOAD = GESTURE_SLOT_ATTACK_AND_RELOAD
local ACT_MP_ATTACK_CROUCH_PRIMARYFIRE = ACT_MP_ATTACK_CROUCH_PRIMARYFIRE
local ACT_MP_ATTACK_STAND_PRIMARYFIRE = ACT_MP_ATTACK_STAND_PRIMARYFIRE
local FCVAR_REPLICATED = FCVAR_REPLICATED
local FCVAR_ARCHIVE = FCVAR_ARCHIVE
local ACT_VM_DRAW_EMPTY = ACT_VM_DRAW_EMPTY
local ACT_VM_DRAW_SILENCED = ACT_VM_DRAW_SILENCED
local ACT_VM_DRAW = ACT_VM_DRAW
local IN_SPEED = IN_SPEED
local ACT_VM_IDLE_SILENCED = ACT_VM_IDLE_SILENCED
local ACT_VM_IDLE_EMPTY = ACT_VM_IDLE_EMPTY
local IN_FORWARD = IN_FORWARD
local IN_BACK = IN_BACK
local IN_MOVELEFT = IN_MOVELEFT
local IN_MOVERIGHT = IN_MOVERIGHT
local ACT_VM_RELOAD = ACT_VM_RELOAD
local ACT_VM_RELOAD_SILENCED = ACT_VM_RELOAD_SILENCED
local ACT_VM_RELOAD_EMPTY = ACT_VM_RELOAD_EMPTY
local IN_USE = IN_USE
local ACT_INVALID = ACT_INVALID
local IN_DUCK = IN_DUCK
local SERVER = SERVER
local CLIENT = CLIENT
local MAT_GLASS = MAT_GLASS
local MAT_SAND = MAT_SAND
local MAT_FLESH = MAT_FLESH
local MAT_ALIENFLESH = MAT_ALIENFLESH
local MAT_WOOD = MAT_WOOD
local MAT_CONCRETE = MAT_CONCRETE
local MAT_PLASTIC = MAT_PLASTIC



local RecoilMul = CreateConVar ("mrp_recoilmul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})
local DamageMul = CreateConVar ("mrp_damagemul", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE})

SWEP.Category			= "MilitaryRP Weapons"
SWEP.Author				= "Subject_Alpha"
SWEP.Contact			= ""


SWEP.Purpose			= ""
SWEP.Instructions			= ""
SWEP.HoldType				= "pistol"
SWEP.ViewModelFOV			= 60
SWEP.ViewModelFlip		= false
SWEP.ViewModel			= "models/weapons/c_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"
SWEP.AnimPrefix			= "python"
SWEP.UseHands			= true

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound		= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil		= 10
SWEP.Primary.Damage		= 10
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.Delay 		= 0

SWEP.Primary.ClipSize		= 5					// Size of a clip
SWEP.Primary.DefaultClip	= 5					// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1					// Size of a clip
SWEP.Secondary.DefaultClip	= -1					// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo		= "none"

SWEP.ActionDelay			= CurTime()

SWEP.DeployDelay			= 1

SWEP.ShellDelay			= 0

SWEP.Pistol				= false
SWEP.Rifle				= false
SWEP.Shotgun			= false
SWEP.Sniper				= false

SWEP.IronSightsPos 		= Vector (0, 0, 0)
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.RunArmOffset 		= Vector (0, 0, 5.5)
SWEP.RunArmAngle 			= Vector (-35, -3, 0)

SWEP.Burst				= false
SWEP.BurstShots			= 3
SWEP.BurstDelay			= 0.05
SWEP.BurstCounter			= 0
SWEP.BurstTimer			= 0

SWEP.Type				= 1 					// 1 = Automatic/Semi-Automatic mode, 2 = Suppressor mode, 3 = Burst fire mode
SWEP.Mode				= false

SWEP.data 				= {}
SWEP.data.NormalMsg		= "Switched to semi-automatic."
SWEP.data.ModeMsg			= "Switched to automatic."
SWEP.data.Delay			= 0.5 				// You need to wait 0.5 second after you change the fire mode
SWEP.data.Cone			= 1
SWEP.data.Damage			= 1
SWEP.data.Recoil			= 1
SWEP.data.Automatic		= false

SWEP.ConstantAccuracy		= false

SWEP.Penetration			= true
SWEP.Ricochet			= true
SWEP.MaxRicochet			= 1

SWEP.Tracer				= 0					// 0 = Normal Tracer, 1 = Ar2 Tracer, 2 = Airboat Gun Tracer, 3 = Normal Tracer + Sparks Impact

SWEP.IdleDelay			= 0
SWEP.IdleApply			= false
SWEP.AllowIdleAnimation		= true
SWEP.AllowPlaybackRate		= true

SWEP.BoltActionSniper		= false				
SWEP.ScopeAfterShoot		= false				

SWEP.IronSightZoom 		= 1.5
SWEP.ScopeZooms			= {10}
SWEP.ScopeScale 			= 0.4

SWEP.ShotgunReloading		= false
SWEP.ShotgunFinish		= 0.5
SWEP.ShotgunBeginReload		= 0.3



/*---------------------------------------------------------
   Name: SWEP:Initialize()
   Desc: Called when the weapon is first loaded.
---------------------------------------------------------*/
function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	if (SERVER) then
		
		self:SetNPCMinBurst(30)
		self:SetNPCMaxBurst(30)
		self:SetNPCFireRate(self.Primary.Delay)
	end
end

/*---------------------------------------------------------
   Name: SWEP:Precache()
   Desc: Use this function to precache stuff.
---------------------------------------------------------*/
function SWEP:Precache()

	util.PrecacheSound("weapons/clipempty_pistol.wav")
end

/*---------------------------------------------------------
   Name: ENT:SetupDataTables()
---------------------------------------------------------*/
function SWEP:SetupDataTables()  

	self:DTVar("Bool", 0, "Holsted")
	self:DTVar("Bool", 1, "Ironsights")
	self:DTVar("Bool", 2, "Scope")
	self:DTVar("Bool", 3, "Mode")
end 

/*---------------------------------------------------------
   Name: SWEP:IdleAnimation()
---------------------------------------------------------*/
function SWEP:IdleAnimation(time)

	if not self.AllowIdleAnimation then return false end

	self.IdleApply = true
	self.ActionDelay = CurTime() + time
	self.IdleDelay = CurTime() + time
end

/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack()
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	if (not self.Owner:IsNPC() and self.Owner:KeyDown(IN_USE)) then
		bHolsted = !self.Weapon:GetDTBool(0)
		self:SetHolsted(bHolsted)

		self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)

		self:SetIronsights(false)

		return
	end

	if (not self:CanPrimaryAttack()) then return end

	self.ActionDelay = (CurTime() + self.Primary.Delay + 0.05)
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

	if self.Weapon:GetDTBool(3) and self.Type == 3 then
		self.BurstTimer 	= CurTime()
		self.BurstCounter = self.BurstShots - 1
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
	end

	self.Weapon:EmitSound(self.Primary.Sound)

	self:TakePrimaryAmmo(1)

	self:ShootBulletInformation()
end

/*---------------------------------------------------------
   Name: SWEP:SecondaryAttack()
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if self.Owner:IsNPC() then return end
	if not IsFirstTimePredicted() then return end

	if (self.Owner:KeyDown(IN_USE) and (self.Mode)) then // Mode
		bMode = !self.Weapon:GetDTBool(3)
		self:SetMode(bMode)
		self:SetIronsights(false)

		self.Weapon:SetNextPrimaryFire(CurTime() + self.data.Delay)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.data.Delay)

		return
	end

	if (!self.IronSightsPos) or (self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0)) then return end
	
	bIronsights = !self.Weapon:GetDTBool(1)
	self:SetIronsights(bIronsights)

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
end

/*---------------------------------------------------------
   Name: SWEP:SetHolsted()
---------------------------------------------------------*/
function SWEP:SetHolsted(b)

	if (self.Owner) then
		if (b) then
			self.Weapon:EmitSound("weapons/universal/iron_in.wav")
		else
			self.Weapon:EmitSound("weapons/universal/iron_out.wav")
		end
	end

	if (self.Weapon) then
		self.Weapon:SetDTBool(0, b)
	end
end

/*---------------------------------------------------------
   Name: SWEP:SetIronsights()
---------------------------------------------------------*/
function SWEP:SetIronsights(b)

	if (self.Owner) then
		if (b) then
			if (SERVER) then
				self.Owner:SetFOV(65, 0.2)
			end

			if self.AllowIdleAnimation then
				if self.Weapon:GetDTBool(3) and self.Type == 2 then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
				else
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				end

				self.Owner:GetViewModel():SetPlaybackRate(0)
			end

			self.Weapon:EmitSound("weapons/universal/iron_in.wav")
		else
			if (SERVER) then
				self.Owner:SetFOV(0, 0.2)
			end

			if self.AllowPlaybackRate and self.AllowIdleAnimation then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			end	

			self.Weapon:EmitSound("weapons/universal/iron_out.wav")
		end
	end

	if (self.Weapon) then
		self.Weapon:SetDTBool(1, b)
	end
end

/*---------------------------------------------------------
   Name: SWEP:SetMode()
---------------------------------------------------------*/
function SWEP:SetMode(b)

	if (self.Owner) then
		if (b) then
			if self.Type == 1 then
				self.Primary.Automatic = self.data.Automatic
				self.Weapon:EmitSound("weapons/smg1/switch_burst.wav")
			elseif self.Type == 2 then
				self.Weapon:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
				self.Primary.Sound = Sound(self.Primary.SuppressorSound)

				if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
					self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
				end
			elseif self.Type == 3 then
				self.Weapon:EmitSound("weapons/smg1/switch_burst.wav")
			end
		end
	end

	if (self.Weapon) then
		self.Weapon:SetDTBool(3, b)
	end
end
/*---------------------------------------------------------
   Name: SWEP:CheckReload()
   Desc: CheckReload.
---------------------------------------------------------*/
function SWEP:CheckReload()
end

/*---------------------------------------------------------
   Name: SWEP:Reload()
   Desc: Reload is being pressed.
---------------------------------------------------------*/
function SWEP:Reload()

	if (self.ActionDelay > CurTime()) then return end 

	self.Weapon:DefaultReload(ACT_VM_RELOAD)

	if (self.Weapon:Clip1() < self.Primary.ClipSize) and (self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
		self:SetIronsights(false)
		self:ReloadAnimation()
	end
end

/*---------------------------------------------------------
   Name: SWEP:ReloadAnimation()
---------------------------------------------------------*/
function SWEP:ReloadAnimation()

	if self.Weapon:GetDTBool(3) and self.Type == 2 then
		self.Weapon:DefaultReload(ACT_VM_RELOAD_SILENCED)
	else
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
	end

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end
end

/*---------------------------------------------------------
   Name: SWEP:SecondThink()
---------------------------------------------------------*/
function SWEP:SecondThink()
end

/*---------------------------------------------------------
   Name: SWEP:Think()
---------------------------------------------------------*/
function SWEP:Think()

	self:SecondThink()

	if self.Weapon:Clip1() > 0 and self.IdleDelay < CurTime() and self.IdleApply then
		local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

		if self.Owner and self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel and self.Owner:Alive() then
			if self.Weapon:GetDTBool(3) and self.Type == 2 then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			end

			if self.AllowPlaybackRate and not self.Weapon:GetDTBool(1) then
				self.Owner:GetViewModel():SetPlaybackRate(1)
			else
				self.Owner:GetViewModel():SetPlaybackRate(0)
			end		
		end

		self.IdleApply = false
	elseif self.Weapon:Clip1() <= 0 then
		self.IdleApply = false
	end

	if self.Weapon:GetDTBool(1) and self.Owner:KeyDown(IN_SPEED) then
		self:SetIronsights(false)
	end

	if self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) then
		if self.Rifle or self.Sniper or self.Shotgun then
			if self.Owner:KeyDown(IN_DUCK) then
				self:SetWeaponHoldType("normal")
			else
				self:SetWeaponHoldType("passive")
			end

		elseif self.Pistol then
			self:SetWeaponHoldType("normal")
		end
	else
		self:SetWeaponHoldType(self.HoldType)
	end
	

	// Burst fire mode
	if self.Weapon:GetDTBool(3) and self.Type == 3 then
		if self.BurstTimer + self.BurstDelay < CurTime() then
			if self.BurstCounter > 0 then
				self.BurstCounter = self.BurstCounter - 1
				self.BurstTimer = CurTime()
				
				if self:CanPrimaryAttack() then
					self.Weapon:EmitSound(self.Primary.Sound)
					self:ShootBulletInformation()
					self:TakePrimaryAmmo(1)
				end
			end
		end
	end

	self:NextThink(CurTime())
end

/*---------------------------------------------------------
   Name: SWEP:Holster()
---------------------------------------------------------*/
function SWEP:Holster()

	return true
end

/*---------------------------------------------------------
   Name: SWEP:Deploy()
   Desc: Whip it out.
---------------------------------------------------------*/
function SWEP:Deploy()

	self:DeployAnimation()

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end

	self.Weapon:SetNextPrimaryFire(CurTime() + self.DeployDelay + 0.05)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.DeployDelay + 0.05)
	self.ActionDelay = (CurTime() + self.DeployDelay + 0.05)

	self:SetIronsights(false)

	return true
end

/*---------------------------------------------------------
   Name: SWEP:DeployAnimation()
---------------------------------------------------------*/
function SWEP:DeployAnimation()

	// Weapon has a suppressor
	if self.Weapon:GetDTBool(3) and self.Type == 2 then
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
	else
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
end

/*---------------------------------------------------------
   Name: SWEP:CrosshairAccuracy()
   Desc: Crosshair informations.
---------------------------------------------------------*/
SWEP.SprayTime 		= 0.1
SWEP.SprayAccuracy 	= 0.2

function SWEP:CrosshairAccuracy()

	if (self.ConstantAccuracy) or (self.Owner:IsNPC()) then
		return 1.0
	end
	
	local LastAccuracy 	= self.LastAccuracy or 0
	local Accuracy 		= 1.0
	local LastShoot 		= self.Weapon:GetNetworkedFloat("LastShootTime", 0)
	
	local Speed 		= self.Owner:GetVelocity():Length()

	local SpeedClamp = math.Clamp(math.abs(Speed / 705), 0, 1)
	
	if (CurTime() <= LastShoot + self.SprayTime) then
		Accuracy = Accuracy * self.SprayAccuracy
	end
	
	if (not self.Owner:IsOnGround()) then
		Accuracy = Accuracy * 0.1
	elseif (Speed > 10) then
		Accuracy = Accuracy * (((1 - SpeedClamp) + 0.1) / 2)
	end

	if (LastAccuracy != 0) then
		if (Accuracy > LastAccuracy) then
			Accuracy = math.Approach(self.LastAccuracy, Accuracy, FrameTime() * 2)
		else
			Accuracy = math.Approach(self.LastAccuracy, Accuracy, FrameTime() * -2)
		end
	end
	
	self.LastAccuracy = Accuracy
	return math.Clamp(Accuracy, 0.2, 1)
end

/*---------------------------------------------------------
   Name: SWEP:ShootBulletInformation()
---------------------------------------------------------*/
function SWEP:ShootBulletInformation()

	local CurrentDamage
	local CurrentRecoil
	local CurrentCone

	if self.Weapon:GetDTBool(3) then
		CurrentDamage = self.Primary.Damage * self.data.Damage * DamageMul:GetFloat()
		CurrentRecoil = self.Primary.Recoil * self.data.Recoil * RecoilMul:GetFloat()
		CurrentCone = self.Primary.Cone * self.data.Cone
	else
		CurrentDamage = self.Primary.Damage * DamageMul:GetFloat()
		CurrentRecoil = self.Primary.Recoil * RecoilMul:GetFloat()
		CurrentCone = self.Primary.Cone
	end

	if self.Owner:IsNPC() then
		self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, self.Primary.Cone)
		return
	end


	if not self.Owner:IsOnGround() then
		if (self.Weapon:GetDTBool(1)) then
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil), math.Rand(-1, 1) * (CurrentRecoil), 0))
		else
			self:ShootBullet(CurrentDamage, CurrentRecoil * 2.5, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil * 2.5), math.Rand(-1, 1) * (CurrentRecoil * 2.5), 0))
		end

	elseif self.Owner:KeyDown (bit.bor( IN_FORWARD, IN_BACK, IN_MOVELEFT, IN_MOVERIGHT )) then

		if (self.Weapon:GetDTBool(1)) then
			self:ShootBullet(CurrentDamage, CurrentRecoil / 2, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 1.5), math.Rand(-1, 1) * (CurrentRecoil / 1.5), 0))

		else
			self:ShootBullet(CurrentDamage, CurrentRecoil * 1.5, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil * 1.5), math.Rand(-1, 1) * (CurrentRecoil * 1.5), 0))
		end

	elseif self.Owner:Crouching() then
	
		if (self.Weapon:GetDTBool(1)) then
			self:ShootBullet(CurrentDamage, 0, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 3), math.Rand(-1, 1) * (CurrentRecoil / 3), 0))

		else
			self:ShootBullet(CurrentDamage, CurrentRecoil / 2, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 2), math.Rand(-1, 1) * (CurrentRecoil / 2), 0))
		end

	else

		if (self.Weapon:GetDTBool(1)) then
			self:ShootBullet(CurrentDamage, CurrentRecoil / 6, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * (CurrentRecoil / 2), math.Rand(-1, 1) * (CurrentRecoil / 2), 0))

		else
			self:ShootBullet(CurrentDamage, CurrentRecoil, self.Primary.NumShots, CurrentCone)
			self.Owner:ViewPunch(Angle(math.Rand(-0.75, -1.0) * CurrentRecoil, math.Rand(-1, 1) * CurrentRecoil, 0))
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootEffects()
---------------------------------------------------------*/
function SWEP:ShootEffects()

	if not self.Owner:IsNPC() then
		self:ShootAnimation()
	end

	if (IsValid(self.Owner) and self.Owner:GetViewModel()) then
		self:IdleAnimation(self.Owner:GetViewModel():SequenceDuration())
	end

	local WeaponModel = self.Weapon:GetOwner():GetActiveWeapon():GetClass()

	if (not self.Owner:IsNPC() and self.Weapon:Clip1() < 1) then
		timer.Simple(self.Owner:GetViewModel():SequenceDuration(), function() 
			if self.Owner and self.Owner:Alive() and self.Weapon:GetOwner():GetActiveWeapon():GetClass() == WeaponModel then
				self.ActionDelay = CurTime()
				self:Reload() 
			end
		end)
	end

	self.Owner:MuzzleFlash()						// Crappy muzzle light
	self.Owner:SetAnimation(PLAYER_ATTACK1)				// 3rd Person Animation

	local effectdata = EffectData()
		effectdata:SetOrigin(self.Owner:GetShootPos())
		effectdata:SetEntity(self.Weapon)
		effectdata:SetStart(self.Owner:GetShootPos())
		effectdata:SetNormal(self.Owner:GetAimVector())
		effectdata:SetAttachment(1)

	if ((game.SinglePlayer() and SERVER) or CLIENT) then
	timer.Simple(0, function()
		if not IsValid(self.Owner) then return end
		if (not IsFirstTimePredicted() or not self.Owner:Alive())then return end

		if (self.Shotgun) then
			util.Effect("effect_shotgunsmoke", effectdata)
		else
			util.Effect("effect_gunsmoke", effectdata)
		end
	end)
	end
	--[[ Shell eject
	timer.Simple(self.ShellDelay, function()
		if not self.Owner then return end
		if not IsFirstTimePredicted() then return end
		if not self.Owner:IsNPC() and not self.Owner:Alive() then return end

		local effectdata = EffectData()
			effectdata:SetEntity(self.Weapon)
			effectdata:SetNormal(self.Owner:GetAimVector())
			effectdata:SetAttachment(2)
		util.Effect(self.ShellEffect, effectdata)
	end)]]

	if self.Owner:IsNPC() then return end

local trace = self.Owner:GetEyeTrace()

	if trace.HitPos:Distance(self.Owner:GetShootPos()) < 250 and self.Shotgun then
		if trace.Entity:GetClass() == "prop_door_rotating" and (SERVER) then
            trace.Entity:Fire("open", "", 0.1)
			trace.Entity:Fire("unlock", "", 0.1)

			local pos = trace.Entity:GetPos()
			local ang = trace.Entity:GetAngles()
			local model = trace.Entity:GetModel()
			local skin = trace.Entity:GetSkin()

			trace.Entity:SetNotSolid(true)
			trace.Entity:SetNoDraw(true)

			local function ResetDoor(door, fakedoor)
				door:SetNotSolid(false)
				door:SetNoDraw(false)
				fakedoor:Remove()
			end

			local push =(self.Owner:GetPos()):Normalize()
			local ent = ents.Create("prop_physics")

			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:SetModel(model)
			
			if(skin) then
				ent:SetSkin(skin)
			end

			ent:Spawn()
			timer.Simple( 25 , function() ResetDoor(trace.Entity, ent) end)

		end
	end

end


/*---------------------------------------------------------
   Name: SWEP:ShootFire()
---------------------------------------------------------*/
function SWEP:ShootFire(attacker, tr, dmginfo)

	self.Owner:SetNetworkedInt("Fuel", math.Clamp(self.Owner:GetNetworkedInt("Fuel") - (math.random(1, 3) / self.Primary.NumShots), 0, 100))

	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
	effectdata:SetNormal(tr.HitNormal)
	effectdata:SetScale(20)
	util.Effect("effect_firehit", effectdata)

	util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

	local random = (1 / self.Primary.Delay) * (self.Primary.NumShots * (self.Primary.NumShots / 4))

	if math.random(0, random) < 1 then
		if tr.Entity:GetPhysicsObject():IsValid() and not tr.Entity:IsPlayer() then
			tr.Entity:Ignite(math.random(5, 20), 0)

			local tracedata = {}
			tracedata.start = tr.HitPos
			tracedata.endpos = Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z - 10)
			tracedata.filter = tr.HitPos
			local tracedata = util.TraceLine(tracedata)

			if tracedata.HitWorld then
				local fire = ents.Create("env_fire")
				fire:SetPos(tr.HitPos)
				fire:SetKeyValue("health", math.random(5, 15))
				fire:SetKeyValue("firesize", "8")
				fire:SetKeyValue("fireattack", "10")
				fire:SetKeyValue("damagescale", "1.0")
				fire:SetKeyValue("StartDisabled", "0")
				fire:SetKeyValue("firetype", "0")
				fire:SetKeyValue("spawnflags", "128")
				fire:Spawn()
				fire:Fire("StartFire", "", 0)
			end
		end
	end
end


/*---------------------------------------------------------
   Name: SWEP:ShootAnimation()
---------------------------------------------------------*/
function SWEP:ShootAnimation()

	local AllowDryFire = self.Owner:GetActiveWeapon():GetClass() == ("mrp_deagle") 
				   or self.Owner:GetActiveWeapon():GetClass() == ("mrp_usp") 

	if (self.Weapon:Clip1() <= 0) then
		if (AllowDryFire) then
			if self.Weapon:GetDTBool(3) and self.Type == 2 then
				self.Weapon:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)	// View model animation
			else
				self.Weapon:SendWeaponAnim(ACT_VM_DRYFIRE) 		// View model animation
			end
		elseif self.Weapon:GetDTBool(3) and self.Type == 2 then
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED) 	// View model animation
		else
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK) 		// View model animation
		end
	else
		if self.Weapon:GetDTBool(3) and self.Type == 2 then
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED) 	// View model animation
		else
			self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK) 		// View model animation
		end
	end
end

/*---------------------------------------------------------
   Name: SWEP:ShootBullet()
---------------------------------------------------------*/
local TracerName = "Tracer"

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone)

	num_bullets 		= num_bullets or 1
	aimcone 			= aimcone or 0

	self:ShootEffects()

	if self.Tracer == 1 then
		TracerName = "Ar2Tracer"
	elseif self.Tracer == 2 then
		TracerName = "AirboatGunHeavyTracer"
	else
		TracerName = "Tracer"
	end
	
	local bullet = {}
		bullet.Num 		= num_bullets
		bullet.Src 		= self.Owner:GetShootPos()			// Source
		bullet.Dir 		= self.Owner:GetAimVector()			// Dir of bullet
		bullet.Spread 	= Vector(aimcone, aimcone, 0)			// Aim Cone
		bullet.Tracer	= 1							// Show a tracer on every x bullets
		bullet.TracerName = TracerName
		bullet.Force	= damage * 0.5					// Amount of force to give to phys objects
		bullet.Damage	= damage
		bullet.Callback	= function(attacker, tr, dmginfo) 
						if not self.Owner:IsNPC() and self.Owner:GetNetworkedInt("Fuel") > 0 then
							self:ShootFire(attacker, tr, dmginfo) 
						end

					  end

	self.Owner:FireBullets(bullet)

	if (SERVER and (self.Sniper or self.Shotgun) and not self.Owner:GetActiveWeapon():GetClass() == ("mrp_pumpshotgun")) then
		self.Owner:SetVelocity(self.Owner:GetAimVector() * -(damage * num_bullets))
	end

	// Recoil
	if (not self.Owner:IsNPC()) and ((game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT)) then
		local eyeangle 	= self.Owner:EyeAngles()
		eyeangle.pitch 	= eyeangle.pitch - recoil
		self.Owner:SetEyeAngles(eyeangle)
	end
end

/*---------------------------------------------------------
   Name: SWEP:BulletPenetrate()
---------------------------------------------------------*/
function SWEP:BulletPenetrate(bouncenum, attacker, tr, dmginfo, isplayer)

	if (CLIENT) then return end

	local MaxPenetration

	if self.Primary.Ammo == "pistol" then // 5.56MM Ammo
		MaxPenetration = 10
	elseif self.Primary.Ammo == "smg1" then // 4.6MM Ammo
		MaxPenetration = 15
	elseif self.Primary.Ammo == "ar2" then // 5.7MM Ammo
		MaxPenetration = 30
	else
		MaxPenetration = 16
	end

	local DoDefaultEffect = true
	if ((tr.MatType == MAT_METAL and self.Ricochet) or (tr.MatType == MAT_SAND) or (tr.Entity:IsPlayer())) then return false end

	if (bouncenum > 3) then return false end
	
	local PenetrationDirection = tr.Normal * MaxPenetration
	
	if (tr.MatType == MAT_GLASS or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_WOOD or tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		PenetrationDirection = tr.Normal * (MaxPenetration * 2)
	end
		
	local trace 	= {}
	trace.endpos 	= tr.HitPos
	trace.start 	= tr.HitPos + PenetrationDirection
	trace.mask 		= MASK_SHOT
	trace.filter 	= {self.Owner}
	   
	local trace 	= util.TraceLine(trace) 
	
	if (trace.StartSolid or trace.Fraction >= 1.0 or tr.Fraction <= 0.0) then return false end
	
	local fDamageMulti = 0.5
	
	if (tr.MatType == MAT_CONCRETE) then
		fDamageMulti = 0.3
	elseif (tr.MatType == MAT_WOOD or tr.MatType == MAT_PLASTIC or tr.MatType == MAT_GLASS) then
		fDamageMulti = 0.8
	elseif (tr.MatType == MAT_FLESH or tr.MatType == MAT_ALIENFLESH) then
		fDamageMulti = 0.9
	end
		
	local bullet = 
	{	
		Num 		= 1,
		Src 		= trace.HitPos,
		Dir 		= tr.Normal,	
		Spread 	= Vector(0, 0, 0),
		Tracer	= 1,
		TracerName 	= "effect_penetration_trace",
		Force		= 5,
		Damage	= (dmginfo:GetDamage() * fDamageMulti),
		HullSize	= 2
	}
	
	bullet.Callback   = function(a, b, c) if (self.Ricochet) then return self:RicochetCallback(bouncenum + 1, a, b, c) end end
	
	timer.Simple(0.05, function()
		if not IsFirstTimePredicted() then return end
		attacker.FireBullets(attacker, bullet, true)
	end)

	return true
end

/*---------------------------------------------------------
   Name: SWEP:CanPrimaryAttack()
---------------------------------------------------------*/
function SWEP:CanPrimaryAttack()

	if (self.Weapon:Clip1() <= 0) or (self.Owner:WaterLevel() > 2) then
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
//		self.Weapon:EmitSound("Default.ClipEmpty_Pistol")
		return false
	end

	if not self.Owner:IsNPC() and (self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) or self.Owner:WaterLevel() > 2) then
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
		return false
	end

	return true
end

/*---------------------------------------------------------
   Name: SWEP:CanSecondaryAttack()
---------------------------------------------------------*/
function SWEP:CanSecondaryAttack()

	// Clip is empty or you're under water
	if (self.Weapon:Clip2() <= 0) then
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
//		self.Weapon:EmitSound("Default.ClipEmpty_Pistol")
		return false
	end

	if not self.Owner:IsNPC() and (self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0) or self.Owner:WaterLevel() > 2) then
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)
		return false
	end

	return true
end
