local PLY = FindMetaTable( "Player" )
function PLY:CreateDeathRagdoll( ply, atk, dmginfo )
	if self.Gibbed then self.Gibbed = false return end
end 

hook.Add( "DoPlayerDeath", "Hidden Gore", function( ply, atk, dmginfo )
	ply:CreateDeathRagdoll( ply, atk, dmginfo )
	return 
end)

Gibs = {}
Gibs.LargeBodyParts = 
{
	Model( "models/gibs/fast_zombie_torso.mdl" ),
	Model( "models/humans/charple02.mdl" ),
	Model( "models/humans/charple03.mdl" ),
	Model( "models/humans/charple04.mdl" )
}

Gibs.MediumBodyParts =
{
	Model( "models/gibs/HGIBS.mdl" ),
	Model( "models/weapons/w_bugbait.mdl" ),
	Model( "models/gibs/antlion_gib_medium_1.mdl" ),
	Model( "models/gibs/antlion_gib_medium_2.mdl" ),
	Model( "models/gibs/shield_scanner_gib5.mdl" ),
	Model( "models/gibs/shield_scanner_gib6.mdl" ),
	Model( "models/props_junk/shoe001a.mdl" ),
	Model( "models/props_junk/rock001a.mdl" ),
	Model( "models/props_combine/breenbust_chunk03.mdl" ),
	Model( "models/props_debris/concrete_chunk03a.mdl" ),
	Model( "models/props_debris/concrete_spawnchunk001g.mdl" ),
	Model( "models/props_debris/concrete_spawnchunk001k.mdl" ),
	Model( "models/props_wasteland/prison_sinkchunk001c.mdl" ),
	Model( "models/props_wasteland/prison_toiletchunk01j.mdl" ),
	Model( "models/props_wasteland/prison_toiletchunk01k.mdl" ),
	Model( "models/props_junk/watermelon01_chunk01b.mdl" ),
	Model( "models/props/cs_italy/bananna.mdl" ) 
}

Gibs.SmallBodyParts =
{
	Model( "models/gibs/HGIBS_scapula.mdl" ),
	Model( "models/gibs/HGIBS_spine.mdl" ),
	Model( "models/props_phx/misc/potato.mdl" ),
	Model( "models/gibs/antlion_gib_small_1.mdl" ),
	Model( "models/gibs/antlion_gib_small_2.mdl" ),
	Model( "models/gibs/shield_scanner_gib1.mdl" ),
	Model( "models/props_debris/concrete_chunk04a.mdl" ),
	Model( "models/props_debris/concrete_chunk05g.mdl" ),
	Model( "models/props_wasteland/prison_sinkchunk001h.mdl" ),
	Model( "models/props_wasteland/prison_toiletchunk01f.mdl" ),
	Model( "models/props_wasteland/prison_toiletchunk01i.mdl" ),
	Model( "models/props_wasteland/prison_toiletchunk01l.mdl" ),
	Model( "models/props_combine/breenbust_chunk02.mdl" ),
	Model( "models/props_combine/breenbust_chunk04.mdl" ),
	Model( "models/props_combine/breenbust_chunk05.mdl" ),
	Model( "models/props_combine/breenbust_chunk06.mdl" ),
	Model( "models/props_junk/watermelon01_chunk02a.mdl" ),
	Model( "models/props_junk/watermelon01_chunk02b.mdl" ),
	Model( "models/props_junk/watermelon01_chunk02c.mdl" ),
	Model( "models/props/cs_office/computer_mouse.mdl" ),
	Model( "models/props/cs_italy/banannagib1.mdl" ),
	Model( "models/props/cs_italy/banannagib2.mdl" ),
	Model( "models/props/cs_italy/orangegib1.mdl" ),
	Model( "models/props/cs_italy/orangegib2.mdl" )
}

local ENTITY = FindMetaTable( "Entity" )
function ENTITY:Gore( dir )
	local gm = Gibs
	if self:IsPlayer() then
		self.Gibbed = true
		for i = 1,math.Rand( 9, 18 ) do

			local tbl = gm.SmallBodyParts

			if i == 1 then

				local doll = ents.Create( "prop_ragdoll" )
				doll:SetModel( table.Random( gm.LargeBodyParts ) )
				doll:SetPos( self:GetPos() )
				doll:SetAngles( self:GetAngles() )
				doll:Spawn()
				doll:SetCollisionGroup( COLLISION_GROUP_WEAPON )
				doll:SetMaterial( "models/flesh" )
				doll.IsGib = true 

				local phys = doll:GetPhysicsObject()
						
				if IsValid( phys ) then
						
					phys:AddAngleVelocity( VectorRand() * 2000 )
					phys:ApplyForceCenter( dir * math.random( 6000, 9000 ) )

				end	

				continue

			elseif i < 3 then

				tbl = gm.MediumBodyParts

			end

			local gib = ents.Create( "ent_gore" )
			gib:SetPos( self:GetPos() + VectorRand()*20 )
			gib:SetModel( table.Random( tbl ) )
			gib:Spawn()

		end
	elseif self:GetClass() == "prop_ragdoll" then
		for i = 1,math.Rand( 9, 18 ) do

			local tbl = gm.SmallBodyParts

			if i == 1 and not self.IsGib then

				local doll = ents.Create( "prop_ragdoll" )
				doll:SetModel( table.Random( gm.LargeBodyParts ) )
				doll:SetPos( self:GetPos() )
				doll:SetAngles( self:GetAngles() )
				doll:Spawn()
				doll:SetCollisionGroup( COLLISION_GROUP_WEAPON )
				doll:SetMaterial( "models/flesh" )
				doll.IsGib = true 

				local phys = doll:GetPhysicsObject()
						
				if IsValid( phys ) then
						
					phys:AddAngleVelocity( VectorRand() * 2000 )
					phys:ApplyForceCenter( dir * math.random( 3000, 6000 ) )

				end	

				continue

			elseif i < 3 and not self.IsGib then

				tbl = gm.MediumBodyParts

			end

			local gib = ents.Create( "ent_gore" )
			gib:SetPos( self:GetPos() + VectorRand()*20 )
			gib:SetModel( table.Random( tbl ) )
			gib:Spawn()

		end
		self:Remove()
	end
end 

