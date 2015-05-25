include('shared.lua')

SWEP.PrintName			= "MilitaryRP Base"			
SWEP.Slot				= 0							
SWEP.SlotPos			= 1							
SWEP.DrawAmmo			= true						
SWEP.DrawWeaponInfoBox		= true						
SWEP.BounceWeaponIcon   	= false						
SWEP.SwayScale			= 2.0							
SWEP.BobScale			= 3.0							

SWEP.RenderGroup 			= RENDERGROUP_OPAQUE

// Override this in your SWEP to set the icon in the weapon selection
if (file.Exists("materials/weapons/swep.vmt","GAME")) then
	SWEP.WepSelectIcon	= surface.GetTextureID("weapons/swep")
end

// This is the corner of the speech bubble
if (file.Exists("materials/gui/speech_lid.vmt","GAME")) then
	SWEP.SpeechBubbleLid	= surface.GetTextureID("gui/speech_lid")
end

/*---------------------------------------------------------
   Name: SWEP:DrawWeaponSelection()
   Desc: Checks the objects before any action is taken.
	   This is to make sure that the entities haven't been removed.
---------------------------------------------------------*/
function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	
	// Set us up the texture
	surface.SetDrawColor(255, 255, 255, alpha)
	surface.SetTexture(self.WepSelectIcon)
	
	// Lets get a sin wave to make it bounce
	local fsin = 0
	
	if (self.BounceWeaponIcon == true) then
		fsin = math.sin(CurTime() * 10) * 5
	end
	
	// Borders
	y = y + 10
	x = x + 10
	wide = wide - 20
	
	// Draw that mother
	surface.DrawTexturedRect(x + (fsin), y - (fsin), wide - fsin * 2, (wide / 2) + (fsin))
	
	// Draw weapon info box
	self:PrintWeaponInfo(x + wide + 20, y + tall * 0.95, alpha)
end

/*---------------------------------------------------------
   Name: SWEP:PrintWeaponInfo()
   Desc: Draws the weapon info box.
---------------------------------------------------------*/
function SWEP:PrintWeaponInfo(x, y, alpha)

	if (self.DrawWeaponInfoBox == false) then return end

	if (self.InfoMarkup == nil) then
		local str
		local title_color = "<color = 130, 0, 0, 255>"
		local text_color = "<color = 255, 255, 255, 200>"
		
		str = "<font=HudSelectionText>"
		if (self.Author != "") then str = str .. title_color .. "Author:</color>\t" .. text_color .. self.Author .. "</color>\n" end
		if (self.Contact != "") then str = str .. title_color .. "Contact:</color>\t" .. text_color .. self.Contact .. "</color>\n\n" end
		if (self.Purpose != "") then str = str .. title_color .. "Purpose:</color>\n" .. text_color .. self.Purpose .. "</color>\n\n" end
		if (self.Instructions!= "") then str = str .. title_color .. "Instructions:</color>\n" .. text_color .. self.Instructions .. "</color>\n" end
		str = str .. "</font>"
		
		self.InfoMarkup = markup.Parse(str, 250)
	end

	alpha = 180
	
	surface.SetDrawColor(0, 0, 0, alpha)
	surface.SetTexture(self.SpeechBubbleLid)
	
	surface.DrawTexturedRect(x, y - 69.5, 128, 64) 
	draw.RoundedBox(8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color(0, 0, 0, alpha))
	
	self.InfoMarkup:Draw(x + 5, y + 5, nil, nil, alpha)
end

/*---------------------------------------------------------
   Name: SWEP:GetViewModelPosition()
   Desc: Allows you to re-position the view model.
---------------------------------------------------------*/
local IRONSIGHT_TIME = 0.2

function SWEP:GetViewModelPosition(pos, ang)

	local bIron = self.Weapon:GetDTBool(1)	
	
	local DashDelta = 0
	
	if (self.Owner:KeyDown(IN_SPEED) or self.Weapon:GetDTBool(0)) then
		if (!self.DashStartTime) then
			self.DashStartTime = CurTime()
		end
		
		DashDelta = math.Clamp(((CurTime() - self.DashStartTime) / 0.1) ^ 1.2, 0, 1)
	else
		if (self.DashStartTime) then
			self.DashEndTime = CurTime()
		end
	
		if (self.DashEndTime) then
			DashDelta = math.Clamp(((CurTime() - self.DashEndTime) / 0.1) ^ 1.2, 0, 1)
			DashDelta = 1 - DashDelta
			if (DashDelta == 0) then self.DashEndTime = nil end
		end
	
		self.DashStartTime = nil
	end
	
	if (DashDelta) then
		local Down = ang:Up() * -1
		local Right = ang:Right()
		local Forward = ang:Forward()
	
		local bUseVector = false
		
		if(!self.RunArmAngle.pitch) then
			bUseVector = true
		end
		
		if (bUseVector == true) then
			ang:RotateAroundAxis(ang:Right(), self.RunArmAngle.x * DashDelta)
			ang:RotateAroundAxis(ang:Up(), self.RunArmAngle.y * DashDelta)
			ang:RotateAroundAxis(ang:Forward(), self.RunArmAngle.z * DashDelta)
			
			pos = pos + self.RunArmOffset.x * ang:Right() * DashDelta 
			pos = pos + self.RunArmOffset.y * ang:Forward() * DashDelta 
			pos = pos + self.RunArmOffset.z * ang:Up() * DashDelta 
		else
			ang:RotateAroundAxis(Right, elf.RunArmAngle.pitch * DashDelta)
			ang:RotateAroundAxis(Down, self.RunArmAngle.yaw * DashDelta)
			ang:RotateAroundAxis(Forward, self.RunArmAngle.roll * DashDelta)

			pos = pos + (Down * self.RunArmOffset.x + Forward * self.RunArmOffset.y + Right * self.RunArmOffset.z) * DashDelta			
		end
		
		if (self.DashEndTime) then
			return pos, ang
		end
	end

	if (bIron != self.bLastIron) then
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if (bIron) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if (!bIron && fIronTime < CurTime() - IRONSIGHT_TIME) then 
		return pos, ang
	end
	
	local Mul = 1.0
	
	if (fIronTime > CurTime() - IRONSIGHT_TIME) then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

		if (!bIron) then Mul = 1 - Mul end
	end

	if (self.IronSightsAng) then
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), 	self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), 	self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * Mul)
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	pos = pos + self.IronSightsPos.x * Right * Mul
	pos = pos + self.IronSightsPos.y * Forward * Mul
	pos = pos + self.IronSightsPos.z * Up * Mul
	
	return pos, ang
end

/*---------------------------------------------------------
   Name: SWEP:AdjustMouseSensitivity()
   Desc: Allows you to adjust the mouse sensitivity.
---------------------------------------------------------*/
function SWEP:AdjustMouseSensitivity()

	return nil
end

/*---------------------------------------------------------
   Name: SWEP:GetTracerOrigin()
   Desc: Allows you to override where the tracer comes from (in first person view)
	   returning anything but a vector indicates that you want the default action.
---------------------------------------------------------*/
function SWEP:GetTracerOrigin()

	if (self.Weapon:GetDTBool(1)) then
		local pos = self:GetOwner():EyePos() + self:GetOwner():EyeAngles():Up() * -4
		return pos
	end
end