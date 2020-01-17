
local R = {}

local function rotPoint( x, y, x0 , y0, ang )

	if (ang == nil or ang == 0) then
		return x, y
	end

	local delta_x =  x - x0 -- math.abs( x0 - x )
	local delta_y =  y - y0 -- math.abs( y0 - y )
	local theta = math.atan2( delta_y , delta_x )
	local r = math.sqrt( math.pow(delta_x,2) + math.pow(delta_y,2) )

	r_ang = (ang or 0)*math.pi / 180

	return x0 + r * math.cos( theta + r_ang ), y0 + r * math.sin( theta + r_ang )
end

local function points( p1, p2, a, b )

	print( p1.x .. " : " .. p2.y)
	
	return p2
end

local function anglePosition(start_angle, current_angle)
	local pos = current_angle + start_angle
	return ( ( pos * (2 * math.pi / 360) ) - (math.pi / 2) )
end

local function anglePosGrad( start_angle, current_angle )
	return anglePosition(start_angle, current_angle) * 180 / math.pi
end

local function pointOfAngleGrad( x0, y0, raio, alfa_1) --x, y, x0 , y0
	return {
		x = x0 + raio*math.sin((90 - alfa_1) * math.pi/180), 
		y = y0 + raio*math.cos((90 - alfa_1) * math.pi/180)
	}

end
local function pointOfAngleRad( x0, y0, raio, alfa_1) --x, y, x0 , y0
	return {
		x = x0 + raio*math.sin(math.pi/2 - alfa_1) , 
		y = y0 + raio*math.cos(math.pi/2 - alfa_1)
	}

end  



-- local p1, p2 = {x=1,y=2}, {x=3,y=4}

-- points({x=1,y=2}, {x=3,y=4})
-- print(points(p1,p2).x)
-- print(rotPoint(10, 0, 0, 0, 45) )
-- print(rotPoint(10, 0, 0, 0, 0) )

R.rotPoint = rotPoint
R.anglePosition = anglePosition
R.anglePosGrad = anglePosGrad
R.pointOfAngleRad = pointOfAngleRad
R.pointOfAngleGrad = pointOfAngleGrad

return R
