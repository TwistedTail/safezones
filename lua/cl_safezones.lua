--[[
	SafeZones - Client 
]]--

-- data table
local zData = zData or {} 

-- Long retarded drawing stuff
local function postDrawOpaqueRenderables()
	for k,v in pairs( zData ) do 
		local min = v.min 
		local max = v.max 

		local corners = v.corners 
		-- Only commenting the first one, the other follow this.
		cam.Start3D2D( max, Angle(0,0,0), 1 )
			-- Box color
			surface.SetDrawColor( Color(0,200,0,100) )

			-- Coordinates
			local x = max:Distance( corners[4] )
			local y = -max:Distance( corners[3] )

			-- Draw the wall
			surface.DrawRect( 0,0,x,y )
		cam.End3D2D() 

		cam.Start3D2D( max, Angle(90,0,0), 1 )
			surface.SetDrawColor( Color(0,180,0,100) )
			local x = max:Distance( corners[2] )
			local y = -corners[2]:Distance( corners[7] )

			surface.DrawRect( 0,0,x,y )
		cam.End3D2D() 

		cam.Start3D2D( max, Angle(0,0,90), 1 )
			surface.SetDrawColor( Color(0,160,0,100) )
			local x = max:Distance( corners[4] )
			local y = corners[4]:Distance( corners[6] )

			surface.DrawRect( 0,0,x,y )
		cam.End3D2D() 

		cam.Start3D2D( min, Angle(0,0,0), 1 )
			surface.SetDrawColor( Color(0,200,0,100) )
			local x = -min:Distance( corners[7] )
			local y = min:Distance( corners[6] )

			surface.DrawRect( 0,0,x,y )
		cam.End3D2D() 

		cam.Start3D2D( min, Angle(90,0,0), 1 )
			surface.SetDrawColor( Color(0,180,0,100) )
			local x = -min:Distance( corners[5] )
			local y = min:Distance( corners[6] )

			surface.DrawRect( 0,0,x,y )
		cam.End3D2D() 

		
		cam.Start3D2D( min, Angle(0,0,90), 1 )
			surface.SetDrawColor( Color(0,160,0,100) )
			local x = -min:Distance( corners[7] )
			local y = -min:Distance( corners[5] )

			surface.DrawRect( 0,0,x,y )
		cam.End3D2D() 

	end
end
hook.Add( "PostDrawOpaqueRenderables", "SafeZone_Draw", postDrawOpaqueRenderables )


-- net
net.Receive( "safezones_getzones", function()
	print( "Received SafeZone data!" )
	zData = net.ReadTable()
end)