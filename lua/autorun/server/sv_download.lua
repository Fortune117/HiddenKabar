
function AddDir(dir) // recursively adds everything in a directory to be downloaded by client  
	local files, directories = file.Find( dir.."/*", "GAME")
	for k,v in pairs( files ) do
		resource.AddFile(dir.."/"..v)
		print( "[FAST DL] Adding "..v.." to FastDL.")
	end

	for k,v in pairs( directories ) do
		AddDir( dir.."/"..v )
	end
end

resource.AddFile( "materials/hud/hvision.vmt")
resource.AddFile( "materials/hud/hvision.vtf")
resource.AddFile( "materials/hud/hvision_dx6.vmt")

resource.AddFile( "materials/models/weapons/v_hands/HiddenHands.vmt")
resource.AddFile( "materials/models/weapons/v_hands/HiddenHands_Normal.vtf") 

resource.AddFile( "materials/sprites/hdn_crosshairs.vmt")
resource.AddFile( "materials/sprites/hdn_crosshairs_tluc.vmt")


AddDir( "materials/models/weapons/v_kabar" )


AddDir( "models/weapons/kabar" )
AddDir( "sound/player/hidden" )

