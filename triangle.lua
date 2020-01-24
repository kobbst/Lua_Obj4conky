

local gc = require("getColor")
local fn = require("auxFunctions")
local class = require('middleclass')
local Figure = require("figureObj")

-- ==================================================================
--               Rectangle normal x, y, width, height
-- ==================================================================

Triangle = class('Triangle', Figure)

function Triangle:initialize( ... )
    Figure.initialize(self, ...)
    local op = { ... }
    -- x, y, ln, cl, op, w, h
    self.__pi = {x = op[1] or 0,  y = op[2] or 0, z = 0}  
    self.__width = op[6] or 50; 
    self.__alfa = (op[7] or 0) * math.pi / 180
    self.__rotation = op[8] or 0

    self.__p0 = {x = 0, y = 0, z = 0}
    self.__p1 = {x = (self.__width or 1), y = 0, z = 0}
    self.__p2 = {x = self.__width * (math.cos(self.__alfa)), y = self.__width * (math.sin(self.__alfa)), z = 0}    

    self.__pc = {x = (self.__p0.x +  self.__p1.x + self.__p2.x)/3, y = (self.__p0.y +  self.__p1.y + self.__p2.y)/3}
    self.__pr =  self.__pc --{x = self.__p0.x, y = self.__p0.y }
    
end
-- ===========  getters/setters ====================
function Triangle:width(value_width) -- setter width
    if value_width then self.__width = value_width end
    return self.__width
end
function Triangle:alfa(value_teta) -- setter teta
    if value_teta then self.__alfa = value_teta end
    return self.__alfa
end
function Triangle:rotation(value_rotation) -- setter width
    if value_rotation then self.__rotation = value_rotation end
    return self.__rotation
end
function Triangle:rotationPoint(x, y) -- setter width
    if x and y then 
        self.__pr.x = x
        self.__pr.y = y 
        -- self:draw(self.x, self.y, self.__width, self.__alfa, self.__rotation)
    end
    return self.__pr.x, self.__pr.y
end
-- =============     methods    ====================
function Triangle:recalculate( xx, yy, ww, alfa, teta )

    if((xx or yy or ww or alfa or teta) ~= nil) then 
        if(xx~=nil and yy ~= nil) then self.__pi.x = xx; self.__pi.y = yy end
        if(ww ~= nil) then self.__width = ww end
        if (alfa ~= nil) then self.__alfa = (alfa * math.pi / 180) end
        if (teta ~= nil) then self.__rotation = teta end
        
        self.__p0 = {x = 0, y = 0, z = 0}
        self.__p1 = {x = (self.__width or 1), y = 0, z = 0}
        self.__p2 = {x = self.__width * (math.cos(self.__alfa)), y = self.__width * (math.sin(self.__alfa)), z = 0}    

        self.__pc = {x = (self.__p0.x +  self.__p1.x + self.__p2.x)/3, y = (self.__p0.y +  self.__p1.y + self.__p2.y)/3}
        -- self.__pr =  self.__pc --{x = self.__p0.x, y = self.__p0.y }
    end
end
function Triangle:draw(x, y, w, alfa, teta)

    -- self.x, self.y = x or self.__pi.x, y or self.__pi.y
    -- self.__width = w or self.__width
    -- if (alfa ~= nil) then self.__alfa = (alfa * math.pi / 180) end
    
    -- self.__rotation = teta or self.__rotation

    self:recalculate(x, y, w, alfa, teta)

    cairo_set_line_width (self.__cr, self.line_width)
    cairo_set_source_rgba (self.__cr, gc.hex(self.color_default, self.__opacity))    
    
    cairo_save(self.__cr)
    cairo_translate (self.__cr, self.__pi.x ,self.__pi.y )

    if (self.__rotation ~= nil or self.__rotation ~= 0) then
        self.__p0.x, self.__p0.y = fn.rotPoint(self.__p0.x, self.__p0.y, self.__pr.x, self.__pr.y, self.__rotation)
        self.__p1.x, self.__p1.y = fn.rotPoint(self.__p1.x, self.__p1.y, self.__pr.x, self.__pr.y, self.__rotation)
        self.__p2.x, self.__p2.y = fn.rotPoint(self.__p2.x, self.__p2.y, self.__pr.x, self.__pr.y, self.__rotation)
    end
    
    cairo_set_line_cap(self.__cr, CAIRO_LINE_CAP_ROUND)
    cairo_move_to (self.__cr, self.__p0.x, self.__p0.y)
    cairo_line_to (self.__cr, self.__p1.x, self.__p1.y)
    cairo_line_to (self.__cr, self.__p2.x, self.__p2.y)
    cairo_close_path(self.__cr)

    if self.__fill then cairo_fill(self.__cr) end
    

    cairo_restore(self.__cr)
    cairo_stroke(self.__cr)

    -- show center 
    -- cairo_arc(self.__cr, self.__pc.x, self.pc.__y, 1., 0,2*math.pi)
    -- cairo_stroke(self.__cr)

end

function Triangle:anchorPoints( ... )
    return {
        p0 = fn.sumPoints(self.__p0,self.__pi),
        p1 = fn.sumPoints(self.__p1,self.__pi),
        p2 = fn.sumPoints(self.__p2,self.__pi),
        pi = self.__pi,
        pc = fn.sumPoints(self.__pc,self.__pi),
        pr = fn.sumPoints(self.__pr,self.__pi)
    }    
end

return Triangle