--[[
    http://www.brawnexercicios.com.br/2012/03/exercicio-resolvido-geometria-plana.html
    
             p0[a1,a2]
             +
           /   \
          /     \
p2[b1,b2]+       +p6[f1,f2] 
         |       |
         |   +pc |     pc[d*cos(30°),d]
p3[c1,c2]+       +p5[e1,e2]  
          \     /
           \   / 
             + p4[d1,d2]
    
    d = comprimento de um dos lados do hexágono (√[(a1 - b1)² + (a2 - b2)²])
    (p1) a1 = fornecido              a2 = fornecido
    (p2) b1 = a1 - d*cos(30°)        b2 = a2 - d*sen(30°)
    (p3) c1 = b1                     c2 = b2 - d
    (p4) d1 = b1 + d*cos(30°)        d2 = b2 - d*(1+sen(30°))
    (p5) e1 = b1 + 2d*cos(30°)       e2 = b2 - d 
    (p6) f1 = b1 + 2d*cos(30°)       f2 = b2
    ----------------------------
    cos(30°) = (√3)/2 = 0.866
    sen(30°) = 1/2
    tg(30°) = (√3)/3 = 0,577350269
    }

]]

local gc = require("getColor")
local fn = require("auxFunctions")
local class = require('middleclass')
local Figure = require("figureObj")

-- ==================================================================
--               Hexagon normal x, y, width, <height(calculated)>
-- ==================================================================

topHexagon = class('topHexagon', Figure)

function topHexagon:initialize( ... )
    Figure.initialize(self, ...)
    local op = { ... }
    -- x, y, ln, cl, op, w,
    self.__width = op.w or op[6] or 1; 
    self.__height = (op.w or op[6] or 1)/(2*math.sqrt(3))
    self.__d = (self.__width or 1)/(2*math.cos(math.pi/6))
    self.__rotation = op[7] or 0
    self.__pi = {x = op[1] or 0,  y = op[2] or 0, z = 0}  

    self.__p0 = {x = (self.__width or 1)/(2), y = 0, z = 0}
    self.__p1 = {x = 0, y = self.__height, z = 0}
    self.__p2 = {x = self.__width, y = self.__height, z = 0}
    
    self.__pc = {x = self.__d*(math.sqrt(3)/2) , y = self.__d, z = 0}    
end
-- ===========  getters/setters ====================
function topHexagon:width(value_width) -- setter width
    if value_width then self.__width = value_width end
    return self.__width
end
function topHexagon:height(value_height) -- setter height
    -- if value_height then self.__height = value_height end
    return self.__height
end
 function topHexagon:rotation(value_rotation) -- setter width
    if value_rotation then self.__rotation = value_rotation end
    return self.__rotation
end
function topHexagon:pi(x, y) 
    if(x ~= nil and y ~= nil) then
        self.__pi.x = x
        self.__pi.y = y
    end
    return self.__pi 
end
function topHexagon:p0() return {x = self.__p0.x + self.__pi.x, x = self.__p0.y + self.__pi.y} end
function topHexagon:p1() return {x = self.__p1.x + self.__pi.x, x = self.__p1.y + self.__pi.y} end
function topHexagon:p2() return {x = self.__p2.x + self.__pi.x, x = self.__p2.y + self.__pi.y} end
-- function topHexagon:pi() return self.__pi end
function topHexagon:centerPoint() return self.__pc end

-- ===========  methods ====================
function topHexagon:recalculate( ... )
    self.__height = self.__width/(2*math.sqrt(3))
    self.__d = (self.__width )/(2*math.cos(math.pi/6))

    self.__p0 = {x = (self.__width or 1)/(2), y = 0, z = 0}
    self.__p1 = {x = 0, y = self.__height, z = 0}
    self.__p2 = {x = self.__width, y = self.__height, z = 0}
    
    self.__pc = {x = self.__d*(math.sqrt(3)/2) , y = self.__d, z = 0}    

end

function topHexagon:draw( x, y, w)

    -- local args = {...}

    -- local ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    -- local self.__cr = cairo_create(ds)

    self.__pi.x = x or self.__pi.x 
    self.__pi.y = y or self.__pi.y
    self.__width = w or self.__width

    self:recalculate()

    if (self.__rotation ~= nil or self.__rotation ~= 0) then
        self.__p0.x, self.__p0.y = fn.rotPoint(self.__p0.x, self.__p0.y, self.__pc.x, self.__pc.y, self.__rotation)
        self.__p1.x, self.__p1.y = fn.rotPoint(self.__p1.x, self.__p1.y, self.__pc.x, self.__pc.y, self.__rotation)
        self.__p2.x, self.__p2.y = fn.rotPoint(self.__p2.x, self.__p2.y, self.__pc.x, self.__pc.y, self.__rotation)
    end

    cairo_set_line_width (self.__cr,self.line_width)
    cairo_set_source_rgba (self.__cr, gc.hex(self.color_default, self.__opacity))
    
    cairo_translate (self.__cr, self.__pi.x, self.__pi.y)
    cairo_move_to (self.__cr, self.__p2.x, self.__p2.y)
    cairo_line_to (self.__cr, self.__p0.x, self.__p0.y)
    cairo_line_to (self.__cr, self.__p1.x, self.__p1.y)
    
    cairo_stroke (self.__cr)
    
end


return topHexagon



--[[ local gc = require("getColor")

local topHex = {}

function topHex.new(width)
    local thex = {
        width = width or 1, height =  (width or 1) /(2*math.sqrt(3)),
        d = (width or 1)/(2*math.cos(math.pi/6)),
        p0 = {x = (width or 1)/(2), y = 0, z = 0},
        p1 = {x = 0, y = (width or 1) /(2*math.sqrt(3)), z = 0},
        p2 = {x = width, y = (width or 1) /(2*math.sqrt(3)), z = 0},
        line_width = 3, color_default = 'ffffff', opacity = 1.
        }
        thex.pi = {x=0,y=0,z=0}
    function thex:getElement()
        return {d = self.d, h = self.height, w = self.width}
        -- return self.p0.x, self.p0.x, self.p1.x, self.p1.y, self.p2.x, self.p2.y

    end

    function thex:getAllvar(...)
        return thex
        -- body
    end
    function thex:draw( x, y, ln, cl, op)

        -- local args = {...}

        -- local ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local ldr = cairo_create(ds)
        self.pi.x, self.pi.y = x , y

        cairo_translate (ldr, x or 0,y or 0)
        cairo_set_line_width (ldr,ln or self.line_width)
        cairo_set_source_rgba (ldr, gc.hex(cl or self.color_default, op or self.opacity))
        
        -- cairo_rotate (ldr, 45* math.pi/180)
        -- cairo_set_line_width (dr, self.line_width);
        -- cairo_set_source_rgba (dr, 200, 200, 200, 0.1)
        cairo_move_to (ldr, self.p2.x, self.p2.y)
        cairo_line_to (ldr, self.p0.x, self.p0.y)
        cairo_line_to (ldr, self.p1.x, self.p1.y)
        
        
        cairo_stroke (ldr)

        -- cairo_surface_destroy(ds)
        cairo_destroy(ldr)        
    end

    function thex:getPoints( ... )
        return {
            p0 = {x = self.p0.x + self.pi.x, y = self.p0.y + self.pi.y}, 
            p1 = {x = self.p1.x + self.pi.x, y = self.p1.y + self.pi.y},  
            p2 = {x = self.p2.x + self.pi.x, y = self.p2.y + self.pi.y}
        }
        
    end

    return thex
end

return topHex
 ]]
