local gc = require("getColor")
local fn = require("auxFunctions")
local class = require('middleclass')
local Figure = require("figureObj")

-- ==================================================================
--               Circle normal x, y, width, height
-- ==================================================================

Circle = class('Circle', Figure)

function Circle:initialize( ... )
    Figure.initialize(self, ...)
    local op = { ... }
    -- x, y, ln, cl, op, w, h
    self.__width = op.w or op[6] or 50; 
    self.__height = op.h or op[7] or 50
    self.__radius = op[8] or math.sqrt(math.pow(self.__width/2,2) + math.pow(self.__height/2,2))
end
-- ===========  getters/setters ====================
function Circle:width(value_width) -- setter width
    if value_width then self.__width = value_width end
    return self.__width
end
function Circle:height(value_height) -- setter height
    if value_height then self.__height = value_height end
    return self.__height
end
function Circle:radius(value_radius) -- setter height
    if value_radius then self.__radius = value_radius end
    return self.__radius
end


-- ===========      methods     ====================

function Circle:drawEllipse(x, y, w, h)

    local cr = self.__cr -- or cairo_create(ds)
    
    -- print(gc.hex("ffffff"))
    
    cairo_set_line_width (cr, self.line_width)
    -- -- cairo_set_source_rgba (cr, 1, 1, 1,0.3)
    cairo_set_source_rgba (cr, gc.hex(self.color_default, self.__opacity))
    
    cairo_save (cr)
    cairo_translate (cr, x , y )
    cairo_scale (cr, w/2., h/2.)
    cairo_arc(cr, 0., 0., 1., 0,2*math.pi)
    -- cairo_fill(cr)
    cairo_restore (cr)
    
    cairo_stroke (cr)
    
end
function Circle:drawCircle(x, y, rd)

    local cr = self.__cr -- or cairo_create(ds)
    
    -- print(gc.hex("ffffff"))
    
    cairo_set_line_width (cr, self.line_width)
    -- -- cairo_set_source_rgba (cr, 1, 1, 1,0.3)
    cairo_set_source_rgba (cr, gc.hex(self.color_default, self.__opacity))
    
    cairo_arc(cr, x or self.x, y or self.y, rd or self.__radius, 0,2*math.pi)
    -- cairo_fill(cr)
    
    cairo_stroke (cr)
    
end
function Circle:drawCircleAxis(x, y, w, h)

    local cr = self.__cr -- or cairo_create(ds)
    
    -- print(gc.hex("ffffff"))
    
    cairo_set_line_width (cr, self.line_width)
    -- -- cairo_set_source_rgba (cr, 1, 1, 1,0.3)
    cairo_set_source_rgba (cr, gc.hex(self.color_default, self.__opacity))
    
    cairo_save (cr)
    cairo_translate (cr, x + w/2, y + h/2)
    cairo_scale (cr, w/2., h/2.)
    cairo_arc(cr, 0., 0., 1., 0,2*math.pi)
    -- cairo_fill(cr)
    cairo_restore (cr)
    
    cairo_stroke (cr)
    
end

return Circle