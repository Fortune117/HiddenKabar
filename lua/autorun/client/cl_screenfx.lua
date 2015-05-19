
ColorMod = {}
ColorMod[ "$pp_colour_addr" ] 			= 0
ColorMod[ "$pp_colour_addg" ] 			= 0
ColorMod[ "$pp_colour_addb" ] 			= 0
ColorMod[ "$pp_colour_brightness" ] 	= 0
ColorMod[ "$pp_colour_contrast" ] 		= 1
ColorMod[ "$pp_colour_colour" ] 		= 1
ColorMod[ "$pp_colour_mulr" ] 			= 1  
ColorMod[ "$pp_colour_mulg" ] 			= 1 
ColorMod[ "$pp_colour_mulb" ] 			= 1 

 
Contrast = 0.9
Colour = 1 
ModDelay = 0

local mat = Material( "hud/hvision", "noclamp smooth" )
function HDN_DrawHiddenScreen( ply )


	if CurTime() > ModDelay then
		if ply:HiddenVision() then
			Contrast = math.Approach( Contrast, 0.8, 0.015 )
			Colour = math.Approach( Colour, 0.0, 0.05 )
		else
			Contrast = math.Approach( Contrast, 0.9, 0.02 )
			Colour = math.Approach( Colour, 1, 0.03 )
		end
		ModDelay = CurTime() + 0.03
	end

	ColorMod[ "$pp_colour_addr" ]		= .09  
	ColorMod[ "$pp_colour_addg" ]		= .03
	ColorMod[ "$pp_colour_contrast" ] 	= Contrast
	ColorMod[ "$pp_colour_colour" ] 	= Colour
	DrawColorModify( ColorMod )
	ColorMod[ "$pp_colour_addr" ] 			= 0
	ColorMod[ "$pp_colour_addg" ] 			= 0
	ColorMod[ "$pp_colour_addb" ] 			= 0

	render.UpdateScreenEffectTexture()
	render.SetMaterial( mat )
	render.DrawScreenQuad()
end 

function HDN_RenderScreenspaceEffects()
	
	local ply = LocalPlayer()

	if ply:GetActiveWeapon():GetClass() == "weapon_hdn_knife" then
		HDN_DrawHiddenScreen( ply )
	end

end

hook.Add( "RenderScreenspaceEffects", "Hdn effects", HDN_RenderScreenspaceEffects )
