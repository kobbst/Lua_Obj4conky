
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
--===================================================================
-- devolve uma tabela com ponto pertencente a um circulo dados
-- ponto central, radio e angulo em graus
--===================================================================
local function pointOfAngleGrad( x0, y0, raio, alfa_1) --x, y, x0 , y0
	return {
		x = x0 + raio*math.sin((90 - alfa_1) * math.pi/180), 
		y = y0 + raio*math.cos((90 - alfa_1) * math.pi/180)
	}

end
--===================================================================
-- devolve uma tabela com ponto pertencente a um circulo dados
-- ponto central, radio e angulo em radianos
--===================================================================
local function pointOfAngleRad( x0, y0, raio, alfa_1) --x, y, x0 , y0
	return {
		x = x0 + raio*math.sin(math.pi/2 - alfa_1) , 
		y = y0 + raio*math.cos(math.pi/2 - alfa_1)
	}

end  


--===================================================================
-- devolve uma tabela contendo a qtde de pontos solicitados em um 
-- seguimento de reta entre dois pontos fornecidos
--===================================================================
local function pointsOfLine( xi, yi, xf, yf, n )
	local p1, p2 = {x = xi or 0, y = yi or 0}, {x = xf or 0, y = yf or 0}

	local delta = {x = p2.x - p1.x, y = p2.y - p1.y}
	local incl = delta.y/delta.x
	-- local diag =  (delta.x^2 + delta.y^2)^(1/2)
	-- local teta = math.atan(incl)
	-- p0.x + math.abs(delta.x)/2 , p0.y +  (math.abs(delta.x)/2 * incl) 
	local p0 = {}
	if (p2.x >= p1.x) then
		p0 = {x = p1.x, y = p1.y}
	else
		p0 = {x = p2.x, y = p2.y}
	end
	-- if(n == nil or n == 0) then 
	-- 	return {p = {x = p0.x + math.abs(delta.x)/2 ,y = p0.y +  (math.abs(delta.x)/2 * incl)} }
	-- end
	p = {}
	for i=1, (n or 0) + 2 do
		table.insert( p, {x = p0.x + i * math.abs(delta.x)/(n + 2),y = p0.y +  i * (math.abs(delta.x)/(n + 2) * incl)})
	end

	return p

end

local function pointsArcGrad( x0, y0, raio, angi, angf, npoints )
    local p = {}
    for alfa_1=angi, angf, (angf-angi)/(npoints + 1) do
       table.insert( p, pointOfAngleGrad(x0, y0, raio, alfa_1))
    end
    return p
end

local function sumPoint( ... )
	local p = {...}
	if(#p == 2) then 
		return {x = (p[1].x or 0) + (p[2].x or 0), y = (p[1].y or 0) + (p[2].y or 0)}
	end
	return nil
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
R.pointsOfLine = pointsOfLine
R.pointsArcGrad = pointsArcGrad
R.sumPoints = sumPoint


return R
