
local rectangle = {}

local gc = require("getColor")
local fn = require("auxFunctions")
local class = require('middleclass')

Rectangle = class('Rectangle')

function Rectangle:initialize( ... )
    local op = { ... }
    -- x, y, w, h, ln, cl, op
    self.x = (op.xc or op[1] or 0); self.y = (op.yc or op[2] or 0)
    self.width = op.w or op[3] or 50; self.height = op.h or op[4] or 50
    self.line_width = op.ln or op[5] or 2 
    self.color_default = op.cl or op[6] or 'ffffff'
    self.__opacity = op.op or op[7] or 1.
    
end
function Rectangle:opacity(value_opacity) -- setter line_width
    if value_opacity then self.__opacity = value_opacity end
    return self.__opacity
end
function Rectangle:color(color) -- setter line_width
    if color then self.color_default = color end
    return self.color_default
end
function Rectangle:lineWidth(ln) -- setter line_width
    if ln then self.line_width = ln end
    return self.line_width
end
function Rectangle:xy(x, y) -- setter x and y
    if x then self.x = x end
    if y then self.y = y end
    return self.x, self.y
end
function Rectangle:radiusEdge(radius) -- setter line_width
    if radius then self.rd = radius end
    return self.rd
end
function Rectangle:Width(width) -- setter line_width
    if width then self.width = width end
    return self.width
end
function Rectangle:height(height) -- setter line_height
    if height then self.height = height end
    return self.height
end

roundedRectangle = class('roundedRectangle', Rectangle)

function roundedRectangle:initialize( ... )
    Rectangle.initialize(self, ...)
    local pr = {...}
    self.radius_edge = pr[rd] or pr[8] or 5
end
function roundedRectangle:radiusEdge(radius_edge) 
    if radius_edge then self.radius_edge = radius_edge end
    return self.radius_edge
end

function roundedRectangle:draw( ... )
    cairo_set_line_width (dr, self.line_width)
    cairo_set_source_rgba (dr, gc.hex(self.color_default, self.__opacity))
    --""" draws rectangles with rounded (circular arc) corners """
    -- # an area with coordinates of
    -- # (top, bottom, left, right) edges in absolute coordinates:
    local a,b,c,d, radius = self.x, self.height, self.y, self.width, self.radius_edge
    cairo_arc(dr, a + radius, c + radius, radius, 2*(math.pi/2), 3*(math.pi/2))
    cairo_arc(dr, b - radius, c + radius, radius, 3*(math.pi/2), 4*(math.pi/2))
    cairo_arc(dr, b - radius, d - radius, radius, 0*(math.pi/2), 1*(math.pi/2)) 
    cairo_arc(dr, a + radius, d - radius, radius, 1*(math.pi/2), 2*(math.pi/2))
    cairo_close_path(dr)
    cairo_stroke(dr)
    
end 

function roundedRectangle:drawRounded_2(...)
    -- def roundedrec(self,context,x,y,w,h,r = 10):
    -- "Draw a rounded rectangle"
    -- #   A****BQ
    -- #  H      C
    -- #  *      *
    -- #  G      D
    -- #   F****E
    local r = self.radius_edge

    cairo_set_line_width (dr, self.line_width)
    cairo_set_source_rgba (dr, gc.hex(self.color_default, self.__opacity))

    cairo_move_to(dr,self.x+r,self.y)                      -- # Move to A
    cairo_line_to(dr,self.x+self.width-r,self.y)                    -- # Straight line to B
    cairo_curve_to(dr,self.x+self.width,self.y,self.x+self.width,self.y,self.x+self.width,self.y+r)       -- # Curve to C, Control points are both at Q
    cairo_line_to(dr,self.x+self.width,self.y+self.height-r)                  -- # Move to D
    cairo_curve_to(dr,self.x+self.width,self.y+self.height,self.x+self.width,self.y+self.height,self.x+self.width-r,self.y+self.height) -- # Curve to E
    cairo_line_to(dr,self.x+r,self.y+self.height)                    -- # Line to F
    cairo_curve_to(dr,self.x,self.y+self.height,self.x,self.y+self.height,self.x,self.y+self.height-r)       -- # Curve to G
    cairo_line_to(dr,self.x,self.y+r)                      -- # Line to H
    cairo_curve_to(dr,self.x,self.y,self.x,self.y,self.x+r,self.y)             -- # Curve to A
    cairo_stroke(dr)
end

rectangle.Rectangle = Rectangle
rectangle.roundedRectangle = roundedRectangle

return rectangle

-- LIXEIRA 
--[[

local v1 = Rectangle:new()
-- local v2 = roundedRectangle({x=80,y=280})
local v2 = roundedRectangle:new(20,288)
v1:xy(50, 150)
-- v2:xy(60, 250)

print(v1:xy())
print(v2:xy())
print(v2:radiusEdge())
print(v1:xy())




function rectangle.new(width)
    local rec = {
        
        width = width or 1, height =  (width or 1) /(2*math.sqrt(3)),
        line_width = 1, color_default = 'ffffff', opacity = 1.
        
    }
    
    function rec:drawRounded(cr, a, b, c, d, radius)
        -- body
        --""" draws rectangles with rounded (circular arc) corners """
        -- # an area with coordinates of
        -- # (top, bottom, left, right) edges in absolute coordinates:
        -- local a,b,c,d=area
        cairo_arc(dr, a + radius, c + radius, radius, 2*(math.pi/2), 3*(math.pi/2))
        cairo_arc(dr, b - radius, c + radius, radius, 3*(math.pi/2), 4*(math.pi/2))
        cairo_arc(dr, b - radius, d - radius, radius, 0*(math.pi/2), 1*(math.pi/2)) 
        cairo_arc(dr, a + radius, d - radius, radius, 1*(math.pi/2), 2*(math.pi/2))
        cairo_close_path(dr)
        cairo_stroke(dr)
        
    end 
    function rec:draw_Rounded_2(x,y,w,h,r)
        -- def roundedrec(self,context,x,y,w,h,r = 10):
        -- "Draw a rounded rectangle"
        -- #   A****BQ
        -- #  H      C
        -- #  *      *
        -- #  G      D
        -- #   F****E

        cairo_move_to(x+r,y)                      -- # Move to A
        cairo_line_to(x+w-r,y)                    -- # Straight line to B
        cairo_curve_to(x+w,y,x+w,y,x+w,y+r)       -- # Curve to C, Control points are both at Q
        cairo_line_to(x+w,y+h-r)                  -- # Move to D
        cairo_curve_to(x+w,y+h,x+w,y+h,x+w-r,y+h) -- # Curve to E
        cairo_line_to(x+r,y+h)                    -- # Line to F
        cairo_curve_to(x,y+h,x,y+h,x,y+h-r)       -- # Curve to G
        cairo_line_to(x,y+r)                      -- # Line to H
        cairo_curve_to(x,y,x,y,x+r,y)             -- # Curve to A
        
    end
    
    return rec
    
end
return rectangle





    -- function roundedRectangle:initialize( x, y, w, h, ln, cl, op, radiusEdge )
    --     Rectangle.initialize(self, x, y, w, h, ln, cl, op)
        --x, y, w, h, ln, cl, op, radiusEdge
        -- print(type(params))

        








        
    ]]