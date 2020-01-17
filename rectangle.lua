
local rectangle = {}

local gc = require("getColor")
local fn = require("auxFunctions")
local class = require('middleclass')
local Figure = require("figureObj")

-- ==================================================================
--               Rectangle normal x, y, width, height
-- ==================================================================

Rectangle = class('Rectangle', Figure)

function Rectangle:initialize( ... )
    Figure.initialize(self, ...)
    local op = { ... }
    -- x, y, ln, cl, op, w, h
    self.__width = op.w or op[6] or 50; 
    self.__height = op.h or op[7] or 50
    
end
-- ===========  getters/setters ====================
function Rectangle:width(value_width) -- setter width
    if value_width then self.__width = value_width end
    return self.__width
end
function Rectangle:height(value_height) -- setter height
    if value_height then self.__height = value_height end
    return self.__height
end
-- ===========  methods ====================
function Rectangle:draw(...)

    cairo_set_line_width (self.__cr, self.line_width)
    cairo_set_source_rgba (self.__cr, gc.hex(self.color_default, self.__opacity))
    
    cairo_save (self.__cr)
    cairo_translate (self.__cr, self.x , self.y )
    cairo_scale (self.__cr, self.__width , self.__height)
    cairo_rectangle(self.__cr, 0, 0, 1, 1)
    cairo_restore (self.__cr)
    if self.__fill then cairo_fill(self.__cr) end

    cairo_stroke (self.__cr)
end 
function Rectangle:erase()
    local op = cairo_get_operator(self.__cr)
    cairo_set_operator(self.__cr, CAIRO_OPERATOR_CLEAR)
    self:draw()
    cairo_set_operator(self.__cr, op)

end

function Rectangle:moveto( nx, ny )
    if type(nx)=='number' then self.x = nx end
    if type(ny)=='number' then self.y = ny end
    -- cairo_destroy(self.__cr)
    -- self.__cr = cairo_create(ds)
    self:draw()
    -- body
end
function Rectangle:axisPoints( ... )
    return {
        p0 = {x = self.x, y = self.y}, 
        p1 = {x = self.x + self.__width, y = self.y},  
        p2 = {x = self.x + self.__width, y = self.y + self.__height}, 
        p3 = {x = self.x , y = self.y + self.__height } 
    }
end

function Rectangle:drawGrid( x1, y1, x2, y2, n_sq_h, n_sq_v, espace )

    local collection = {}
    local xi, yi, xf, yf = x1 or 0, y1 or 0, x2 or 10, y2 or 10 -- treatement for params
    local nv, nh, spce = n_sq_v or 1, n_sq_h or 1, espace or 1
    local w, h = ((xf - xi)/nh) - spce, ((yf - yi)/nv) - spce -- width and height for each rectangle
    local obj = nil
    for i=1,n_sq_h do
        collection[i] = {}
        for j=1, n_sq_v do
            obj = Rectangle:new(self.x, self.y, self.line_width, self.color_default, self.__opacity)
            -- obj = Rectangle:new()
            obj:xy(xi,yi); obj:width(w);obj:height(h)
            xi, yi = obj:xy(); yi = yi + obj:height() + spce;
            collection[i][j] = obj
        end
        xi = xi + obj:width() + spce;
        yi = y1
        
    end
    return collection --, w, h," | ", x1, y1," | ", x2, y2
end

function Rectangle:drawGridWH( x1, y1, width, height, n_sq_h, n_sq_v, espace )

    local collection = {}
    local xi, yi, xf, yf = x1 or 0, y1 or 0, (x1 + width) or 10, (y1 + height) or 10 -- treatement for params
    local nv, nh, spce = n_sq_v or 1, n_sq_h or 1, espace or 1
    local w, h = ((xf - xi)/nh) - spce, ((yf - yi)/nv) - spce -- width and height for each rectangle
    -- collection = self:drawGrid( x1, y1, x2, y2, n_sq_h, n_sq_v, espace )
    local obj = nil
    for i=1,n_sq_h do
        collection[i] = {}
        for j=1, n_sq_v do
            obj = Rectangle:new(self.x, self.y, self.line_width, self.color_default, self.__opacity)
            -- obj = Rectangle:new()
            obj:xy(xi,yi); obj:width(w);obj:height(h)
            xi, yi = obj:xy(); yi = yi + obj:height() + spce;
            collection[i][j] = obj
        end
        xi = xi + obj:width() + spce;
        yi = y1
        
    end   
    return collection 
end
 --=================== End of class Rectangle =======================

-- ==================================================================
--               Rectangle with rounded edge
-- ==================================================================

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
    cairo_set_line_width (self.__cr, self.line_width)
    cairo_set_source_rgba (self.__cr, gc.hex(self.color_default, self.__opacity))
    --""" draws rectangles with rounded (circular arc) corners """
    -- # an area with coordinates of
    -- # (top, bottom, left, right) edges in absolute coordinates:
    local a,b,c,d, radius = self.x, self.__height, self.y, self.__width, self.radius_edge
    cairo_arc(self.__cr, a + radius, c + radius, radius, 2*(math.pi/2), 3*(math.pi/2))
    cairo_arc(self.__cr, b - radius, c + radius, radius, 3*(math.pi/2), 4*(math.pi/2))
    cairo_arc(self.__cr, b - radius, d - radius, radius, 0*(math.pi/2), 1*(math.pi/2)) 
    cairo_arc(self.__cr, a + radius, d - radius, radius, 1*(math.pi/2), 2*(math.pi/2))
    cairo_close_path(self.__cr)
    cairo_stroke(self.__cr)
    
    -- returning axis points
    return a + radius, c + radius, b - radius, d - radius
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

    -- print( self.__opacity)
    cairo_set_line_width (self.__cr, self.line_width)
    cairo_set_source_rgba (self.__cr, gc.hex(self.color_default, self.__opacity))

    cairo_move_to(self.__cr,self.x+r,self.y)                      -- # Move to A
    cairo_line_to(self.__cr,self.x+self.__width-r,self.y)                    -- # Straight line to B
    cairo_curve_to(self.__cr,self.x+self.__width,self.y,self.x+self.__width,self.y,self.x+self.__width,self.y+r)       -- # Curve to C, Control points are both at Q
    cairo_line_to(self.__cr,self.x+self.__width,self.y+self.__height-r)                  -- # Move to D
    cairo_curve_to(self.__cr,self.x+self.__width,self.y+self.__height,self.x+self.__width,self.y+self.__height,self.x+self.__width-r,self.y+self.__height) -- # Curve to E
    cairo_line_to(self.__cr,self.x+r,self.y+self.__height)                    -- # Line to F
    cairo_curve_to(self.__cr,self.x,self.y+self.__height,self.x,self.y+self.__height,self.x,self.y+self.__height-r)       -- # Curve to G
    cairo_line_to(self.__cr,self.x,self.y+r)                      -- # Line to H
    cairo_curve_to(self.__cr,self.x,self.y,self.x,self.y,self.x+r,self.y)             -- # Curve to A
    cairo_stroke(self.__cr)
end



--==============  Finishing the classes ===============

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
-- ==============================================================================
-- ==============================================================================
    -- self.x = (op.xc or op[1] or 0); self.y = (op.yc or op[2] or 0)
    -- self.line_width = op.ln or op[5] or 2 
    -- self.color_default = op.cl or op[6] or 'ffffff'
    -- self.__opacity = op.op or op[7] or 1.        

-- ==============================================================================

-- function Rectangle:opacity(value_opacity) -- setter line_width
--     if value_opacity then self.__opacity = value_opacity end
--     return self.__opacity
-- end
-- function Rectangle:color(color) -- setter line_width
--     if color then self.color_default = color end
--     return self.color_default
-- end
-- function Rectangle:lineWidth(ln) -- setter line_width
--     if ln then self.line_width = ln end
--     return self.line_width
-- end
-- function Rectangle:xy(x, y) -- setter x and y
--     if x then self.x = x end
--     if y then self.y = y end
--     return self.x, self.y
-- end
-- function Rectangle:radiusEdge(radius) -- setter line_width
--     if radius then self.rd = radius end
--     return self.rd
-- end





        
    ]]