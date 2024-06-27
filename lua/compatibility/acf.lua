local entmeta = FindMetaTable("Entity")

function entmeta:InACFZone( name )
	if not IsValid( self ) then return end
	local pos = self:GetPos()

	for i = 1,table.Count(Zones.zones) do
		local zone = Zones.zones[i]
		if not zone.acf or tonumber(zone.acf) == 0 then continue end
		if name ~= nil and zone:Name() ~= name then continue end

		if inrange( pos, zone._truemin, zone._truemax ) then
			return true
		end
	end

	return false
end

if SERVER then
	local function IsProtected(Entity)
		if not IsValid(Entity) then return false end
		if Entity:InACFZone() then return false end
		if Entity:InSafeZone() then return true end

		return false
	end

	hook.Add("ACF_PreDamageEntity", "SafeZone_ACF", function(Entity, _, DmgInfo)
		if IsProtected(Entity) then return false end
		if IsProtected(DmgInfo:GetAttacker()) then return false end
		if IsProtected(DmgInfo:GetInflictor()) then return false end
	end)

	hook.Add("ACF_FireShell", "SafeZone_FireShell", function(Weapon)
		if IsProtected(Weapon) then return false end
	end)

	hook.Add("ACF_AmmoExplode", "SafeZone_Ammo", function(Crate)
		if IsProtected(Crate) then return false end
	end)
end
