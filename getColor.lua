local M = {}

local function hex (hex, alpha) 
	local redColor,greenColor,blueColor=hex:match('(..)(..)(..)')
	redColor, greenColor, blueColor = tonumber(redColor, 16)/255, tonumber(greenColor, 16)/255, tonumber(blueColor, 16)/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	elseif alpha > 1 then
		alpha = alpha / 100
	end
	return redColor, greenColor, blueColor, alpha
end

local function rgb (r, g, b, alpha)
	local redColor,greenColor,blueColor=r/255, g/255, b/255
	redColor, greenColor, blueColor = math.floor(redColor*100)/100, math.floor(greenColor*100)/100, math.floor(blueColor*100)/100
	if alpha == nil then
		return redColor, greenColor, blueColor
	elseif alpha > 1 then
		alpha = alpha / 100
	end
	return redColor, greenColor, blueColor, alpha
end

--[[
	Option 2:
If you like math, you could use Python's math package to rotate your polygon's points.
You could convert your points to a polar coordinate format which includes radius and angle.
This means you just add a rotation angle to each vertex and you'd represent the new rotation angle for your polygon.
Rotation in the polar coordinate system is as simple as moving your shape up/down, left/right in x-y coordinates.  
When you want to draw, you can then follow formals such as:

x = cx + r * math.cos(a + rotation_angle), 
y = cy + r * math.sin(a + rotation_angle).

Note that Python's math sin and cos functions interpret the parameter as being in radians instead of degrees.
180 degrees == math.pi radians.



]]

local function rotPoint( x, y, x0 , y0, ang )

	local delta_x =  x - x0 -- math.abs( x0 - x )
	local delta_y =  y - y0 -- math.abs( y0 - y )
	local theta = math.atan2( delta_y, delta_x )
	local r = math.sqrt( math.pow(2,delta_x) + math.pow(2,delta_y) )

	r_ang = (ang or 0)*math.pi / 180

	return x0 + r * math.cos( tetha + r_ang ), y0 + r * math.sin( tetha + r_ang )
end

M.hex = hex
M.rgb = rgb
M.rotPoint = rotPoint
return M