--[[
    http://www.brawnexercicios.com.br/2012/03/exercicio-resolvido-geometria-plana.html
    {
             p1[a1,a2]
             +
           /   \
          /     \
p2[b1,b2]+       +p6[f1,f2] 
         |       |
         |   +p0 |     p0[d*cos(30°),d]
p3[c1,c2]+       +p5[e1,e2]  
          \     /
           \   / 
             + p4[d1,d2]
    
    d = comprimento de um dos lados do hexágono (√[(a1 - b1)² + (a2 - b2)²])
    (p1) a1 = fornecido              a1 = fornecido
    (p2) b1 = a1 - d*cos(30°)        b2 = a2 - d*sen(30°)
    (p3) c1 = b1                     c2 = b2 - d
    (p4) d1 = b1 + d*cos(30°)        d2 = b2 - d*(1+sen(30°))
    (p5) e1 = b1 + 2d*cos(30°)       e2 = b2 - d 
    (p6) f1 = b1 + 2d*cos(30°)       f2 = b2
    ----------------------------
    cos(30°) = (√3)/2 = 0.866
    sen(30°) = 1/2
    
    }

]]


-- require 'cairo'

-- local hexagon = {}

local gc = require("getColor")
local fn = require("auxFunctions")
local class = require('middleclass')
local Figure = require("figureObj")

-- ==================================================================
--               Hexagon normal x, y, width, <height(calculated)>
-- ==================================================================

Hexagon = class('Hexagon', Figure)

function Hexagon:initialize( ... )
    Figure.initialize(self, ...)
    local op = { ... }
    -- x, y, ln, cl, op, w,
    self.__width = op.w or op[6] or 1; 
    self.__height = (op.w or op[6] or 1)/(2*math.sqrt(3))
    self.__d = (self.__width or 1)/(2*math.cos(math.pi/6))
    self.__rotation = op[7] or 0
    self.__pi = {x = op[1] or 0,  y = op[2] or 0, z = 0}  

    self.__p0 = {x = self.__d*(math.sqrt(3)/2) , y = self.__d, z = 0}
    self.__p1 = {x = (self.__width or 1)/(2), y = 0, z = 0}
    self.__p2 = {x = 0, y = self.__height, z = 0}
    self.__p3 = {x = self.__p2.x, y = self.__d + self.__height, z = 0}
    self.__p4 = {x = self.__width/2, y = self.__d * 2 , z = 0}
    self.__p5 = {x = self.__width, y = self.__d + self.__height, z = 0}
    self.__p6 = {x = self.__width, y = self.__height, z = 0}
    
    self.__pc = {x = self.__d*(math.sqrt(3)/2) , y = self.__d, z = 0}    
end
-- ===========  getters/setters ====================
function Hexagon:width(value_width) -- setter width
    if value_width then self.__width = value_width end
    return self.__width
end
function Hexagon:height(value_height) -- setter height
    -- if value_height then self.__height = value_height end
    return self.__height
end
 function Hexagon:rotation(value_rotation) -- setter width
    if value_rotation then self.__rotation = value_rotation end
    return self.__rotation
end
function Hexagon:p0() return self.__p0 end
function Hexagon:p1() return self.__p1 end
function Hexagon:p2() return self.__p2 end
function Hexagon:p3() return self.__p3 end
function Hexagon:p4() return self.__p4 end
function Hexagon:p5() return self.__p5 end
function Hexagon:p6() return self.__p6 end
function Hexagon:pi() return self.__pi end
function Hexagon:centerPoint() return self.__pc end

-- ===========  methods  ===================

function Hexagon:draw(x, y, rt)

    self.__pi.x, self.__pi.y = x or self.__pi.x, y or self.__pi.y
    if (rt ~= nil) then self.__rotation = rt end

    cairo_set_line_width (self.__cr, self.line_width)
    cairo_set_source_rgba (self.__cr, gc.hex(self.color_default, self.__opacity))    
    
    cairo_translate (self.__cr, x or self.x , y or self.y )

    if (self.__rotation ~= nil or self.__rotation ~= 0) then
        self.__p1.x, self.__p1.y = fn.rotPoint(self.__p1.x, self.__p1.y, self.__p0.x, self.__p0.y, self.__rotation)
        self.__p2.x, self.__p2.y = fn.rotPoint(self.__p2.x, self.__p2.y, self.__p0.x, self.__p0.y, self.__rotation)
        self.__p3.x, self.__p3.y = fn.rotPoint(self.__p3.x, self.__p3.y, self.__p0.x, self.__p0.y, self.__rotation)
        self.__p4.x, self.__p4.y = fn.rotPoint(self.__p4.x, self.__p4.y, self.__p0.x, self.__p0.y, self.__rotation)
        self.__p5.x, self.__p5.y = fn.rotPoint(self.__p5.x, self.__p5.y, self.__p0.x, self.__p0.y, self.__rotation)
        self.__p6.x, self.__p6.y = fn.rotPoint(self.__p6.x, self.__p6.y, self.__p0.x, self.__p0.y, self.__rotation)
    end
    
    -- cairo_device_to_user(ldr, self.__pc.x, self.__pc.y)
    -- cairo_translate (ldr, 0, 0)
    
    -- cairo_set_source_rgba (dr, 200, 200, 200, 0.5)
    cairo_move_to (self.__cr, self.__p1.x, self.__p1.y)
    cairo_line_to (self.__cr, self.__p2.x, self.__p2.y)
    cairo_line_to (self.__cr, self.__p3.x, self.__p3.y)
    cairo_line_to (self.__cr, self.__p4.x, self.__p4.y)
    cairo_line_to (self.__cr, self.__p5.x, self.__p5.y)
    cairo_line_to (self.__cr, self.__p6.x, self.__p6.y)
    cairo_line_to (self.__cr, self.__p1.x, self.__p1.y)
    if self.__fill then cairo_fill(self.__cr) end
    

    cairo_stroke(self.__cr)
    -- show center 
    -- cairo_arc(self.__cr, self.__pc.x, self.pc.__y, 1., 0,2*math.pi)
    -- cairo_stroke(self.__cr)

    -- cairo_surface_destroy(ds)
    -- cairo_destroy(self.__cr) 
end

function Hexagon:anchorPoints( ... )
    return {p0 = {x = self.__p0.x + self.__pi.x, y = self.__p0.y + self.__pi.y}, 
            p1 = {x = self.__p1.x + self.__pi.x, y = self.__p1.y + self.__pi.y},  
            p2 = {x = self.__p2.x + self.__pi.x, y = self.__p2.y + self.__pi.y},  
            p3 = {x = self.__p3.x + self.__pi.x, y = self.__p3.y + self.__pi.y},  
            p4 = {x = self.__p4.x + self.__pi.x, y = self.__p4.y + self.__pi.y},  
            p5 = {x = self.__p5.x + self.__pi.x, y = self.__p5.y + self.__pi.y},  
            p6 = {x = self.__p6.x + self.__pi.x, y = self.__p6.y + self.__pi.y},  
            pi = self.__pi}
end

function Hexagon:ObjGrid( x1, y1, width, height, n_sq_h, n_sq_v, espace )

    local collection = {}
    local xi, yi, xf, yf = x1 or 0, y1 or 0, (x1 + width) or 10, (y1 + height) or 10 -- treatement for params
    local nv, nh, spce = n_sq_v or 1, n_sq_h or 1, espace or 1
    local w, h = ((xf - xi)/nh) - spce, ((yf - yi)/nv) - spce -- width and height for each rectangle
    -- collection = self:drawGrid( x1, y1, x2, y2, n_sq_h, n_sq_v, espace )
    local obj = nil
    for i=1,n_sq_h do
        collection[i] = {}
        for j=1, n_sq_v do
            obj = Hexagon:new(self.x, self.y, self.line_width, self.color_default, self.__opacity)
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

return Hexagon

--[[ 

local gc = require("getColor")
local fn = require("auxFunctions")

local hexagon = {}

function hexagon.new(width)
    local hex = {

        width = width or 1, height =  (width or 1) /(2*math.sqrt(3)),
        line_width = 1, color_default = 'ffffff', opacity = 1.,
        d = (width or 1)/(2*math.cos(math.pi/6)),
        pi = {x=0, y=0, z=0}
        
    }
        hex.p0 = {x = hex.d*(math.sqrt(3)/2) , y = hex.d, z = 0}
        hex.p1 = {x = (width or 1)/(2), y = 0, z = 0}
        hex.p2 = {x = 0, y = hex.height, z = 0}
        hex.p3 = {x = hex.p2.x, y = hex.d + hex.height, z = 0}
        hex.p4 = {x = hex.width/2, y = hex.d * 2 , z = 0}
        hex.p5 = {x = hex.width, y = hex.d + hex.height, z = 0}
        hex.p6 = {x = hex.width, y = hex.height, z = 0}
        
        hex.pc = {x = hex.d*(math.sqrt(3)/2) , y = hex.d, z = 0}

    function hex:draw(x, y, ln, cl, op, rt)
        -- local ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local ldr = cairo_create(ds)
        self.pi.x, self.pi.y = x , y
        
        cairo_set_line_width (ldr, ln or self.line_width)
        cairo_set_source_rgba (ldr, gc.hex(cl or self.color_default, op or self.opacity))
        cairo_translate (ldr, x or 0,y or 0)

        if (rt ~= nil or rt ~= 0) then
            self.p1.x, self.p1.y = fn.rotPoint(self.p1.x, self.p1.y, self.p0.x, self.p0.y, rt)
            self.p2.x, self.p2.y = fn.rotPoint(self.p2.x, self.p2.y, self.p0.x, self.p0.y, rt)
            self.p3.x, self.p3.y = fn.rotPoint(self.p3.x, self.p3.y, self.p0.x, self.p0.y, rt)
            self.p4.x, self.p4.y = fn.rotPoint(self.p4.x, self.p4.y, self.p0.x, self.p0.y, rt)
            self.p5.x, self.p5.y = fn.rotPoint(self.p5.x, self.p5.y, self.p0.x, self.p0.y, rt)
            self.p6.x, self.p6.y = fn.rotPoint(self.p6.x, self.p6.y, self.p0.x, self.p0.y, rt)
        end
        
        -- cairo_device_to_user(ldr, self.pc.x, self.pc.y)
        -- cairo_translate (ldr, 0, 0)
        
        -- cairo_set_source_rgba (dr, 200, 200, 200, 0.5)
        cairo_move_to (ldr, self.p1.x, self.p1.y)
        cairo_line_to (ldr, self.p2.x, self.p2.y)
        cairo_line_to (ldr, self.p3.x, self.p3.y)
        cairo_line_to (ldr, self.p4.x, self.p4.y)
        cairo_line_to (ldr, self.p5.x, self.p5.y)
        cairo_line_to (ldr, self.p6.x, self.p6.y)
        cairo_line_to (ldr, self.p1.x, self.p1.y)
        cairo_stroke(ldr)
        -- show center 
        -- cairo_arc(ldr, self.pc.x, self.pc.y, 1., 0,2*math.pi)
        -- cairo_stroke(ldr)

        -- cairo_surface_destroy(ds)
        cairo_destroy(ldr) 
    end

    function hex:getPoints( ... )
        return {p0 = {x = self.p0.x + self.pi.x, y = self.p0.y + self.pi.y}, 
                p1 = {x = self.p1.x + self.pi.x, y = self.p1.y + self.pi.y},  
                p2 = {x = self.p2.x + self.pi.x, y = self.p2.y + self.pi.y},  
                p3 = {x = self.p3.x + self.pi.x, y = self.p3.y + self.pi.y},  
                p4 = {x = self.p4.x + self.pi.x, y = self.p4.y + self.pi.y},  
                p5 = {x = self.p5.x + self.pi.x, y = self.p5.y + self.pi.y},  
                p6 = {x = self.p6.x + self.pi.x, y = self.p6.y + self.pi.y},  
                pi = self.pi}
    end

    function hex:getCenter( ... )
        return self.pc.x, self.pc.y
    end

    return hex

end
return hexagon


 ]]