local function NewCrosshair()

	local x = ScrW() / 2
	local y = ScrH() / 2

	surface.SetDrawColor( 0, 200, 0, 255 )
 
	local gap = 10
	local length = gap + 10

	surface.DrawLine( x - length, y, x - gap, y )
	surface.DrawLine( x + length, y, x + gap, y )
	surface.DrawLine( x, y - length, x, y - gap )
	surface.DrawLine( x, y + length, x, y + gap )
	surface.DrawCircle( ScrW()/2, ScrH()/2, 0, 0, 200, 0, 255 )
end

local function CreateFonts()
	surface.CreateFont("Triflux1", {
		font = "Default", 
		size = 24, 
		weight = 1000,
		blursize 	= 0,
		scanlines	= 0,
		antialias 	= true,
		underline 	= false,
		italic 		= false,
		strikeout 	= false,
		symbol 		= false,
		rotary 		= false,
		shadow 		= false,
		additive 	= false,
		outline 	= false, 
	})

	surface.CreateFont("Triflux2", {
		font = "Default", 
		size = 24, 
		weight = 300,
		blursize 	= 0,
		scanlines	= 0,
		antialias 	= true,
		underline 	= false,
		italic 		= false,
		strikeout 	= false,
		symbol 		= false,
		rotary 		= false,
		shadow 		= false,
		additive 	= false,
		outline 	= false,
	})

	surface.CreateFont("Triflux3", {
		font = "Default", 
		size = 20, 
		weight = 100,
		blursize 	= 0,
		scanlines	= 0,
		antialias 	= true,
		underline 	= false,
		italic 		= false,
		strikeout 	= false,
		symbol 		= false,
		rotary 		= false,
		shadow 		= false,
		additive 	= false,
		outline 	= false,
	})
end

local function GameInfo()

	surface.SetFont( "Triflux1" )
	surface.SetTextColor( 0, 0, 255, 255 )
	surface.SetTextPos( ScrW()/25, ScrH()/25 ) 
	surface.DrawText(GetHostName() )

	surface.SetFont("Default")
	surface.SetTextColor( 0, 0, 255, 255 )
	surface.SetTextPos( ScrW()/25, ScrH()/15 )
	surface.DrawText(LocalPlayer():SteamID())
end

local function Killcounter()
	w = 85
	h = 100
	
	x = 10
	y = 300

	draw.RoundedBox( 0, x, y, w, h, Color( 0, 0, 0, 0 ) ) 
	
	surface.SetFont("Triflux3")
	local tW, tH = surface.GetTextSize("Stats")
	
	draw.DrawText( "Kills: "..LocalPlayer():Frags(), "Triflux3", x + 5, y + (tH) + 8, color_white )
	
	draw.DrawText( "Deaths: "..LocalPlayer():Deaths(), "Triflux3", x + 5, y + (tH*2) + 8, color_white )

	draw.DrawText( "K/D Ratio: "..math.Round(LocalPlayer():Frags()/LocalPlayer():Deaths(), 1), "Triflux3", x + 5, y + (tH*3) + 8, color_white )
end

CreateFonts()

local function MRPHUDPaint()
	NewCrosshair()
	GameInfo()
	Killcounter()

	GAMEMODE.BaseClass:HUDPaint()
end
hook.Add( "HUDPaint", "MRPHUDPaint", MRPHUDPaint )