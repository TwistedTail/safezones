local function BlockSpawning(_, Model, Ent)
    Ent = Ent or Model

    if IsValid(Ent) and Ent:InSafeZone() then
        Ent:Remove()
    end
end

local function ToggleSpawn(Ply, Cmd, Args)
    if not Ply:IsSuperAdmin() then return end

    local Ex = string.Explode("_", Cmd)

    local Type = string.gsub(" " .. Ex[3], "%W%l", string.upper):sub(2)

    if tobool(Args[1]) then -- Add hook
        hook.Add("PlayerSpawned" .. Type, Cmd, BlockSpawning)
    else -- Remove hook
        hook.Remove("PlayerSpawned" .. Type, Cmd)
    end
end
concommand.Add("safezones_block_Effect", ToggleSpawn, nil, nil, FCVAR_ARCHIVE)
concommand.Add("safezones_block_NPC", ToggleSpawn, nil, nil, FCVAR_ARCHIVE)
concommand.Add("safezones_block_Prop", ToggleSpawn, nil, nil, FCVAR_ARCHIVE)
concommand.Add("safezones_block_Ragdoll", ToggleSpawn, nil, nil, FCVAR_ARCHIVE)
concommand.Add("safezones_block_SENT", ToggleSpawn, nil, nil, FCVAR_ARCHIVE)
concommand.Add("safezones_block_SWEP", ToggleSpawn, nil, nil, FCVAR_ARCHIVE)
concommand.Add("safezones_block_Vehicle", ToggleSpawn, nil, nil, FCVAR_ARCHIVE)