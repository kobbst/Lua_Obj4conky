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

local gc = require("getColor")

local hexagon = {}

function hexagon.new(width)
    local hex = {

        width = width or 1, height =  (width or 1) /(2*math.sqrt(3)),
        line_width = 1, color_default = 'ffffff', opacity = 1.,
        d = (width or 1)/(2*math.cos(math.pi/6)),
        p0 = {x = 0, y = 0, z = 0},

        p1 = {x = (width or 1)/(2), y = 0, z = 0}
        }
        hex.p2 = {x = 0, y = hex.height, z = 0}
        hex.p6 = {x = hex.width, y = hex.height, z = 0}
        
        hex.p3 = {x = hex.p2.x, y = hex.d + hex.height, z = 0}
        hex.p4 = {x = hex.width/2, y = hex.d * 2 , z = 0}
        hex.p5 = {x = hex.width, y = hex.d + hex.height, z = 0}
        
        hex.pc = {x = hex.height , y = hex.d, z = 0}

    function hex:draw(x, y, ln, cl, op, rt)
        -- local ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local ldr = cairo_create(ds)
        
        cairo_set_line_width (ldr, ln or self.line_width)
        cairo_set_source_rgba (ldr, gc.hex(cl or self.color_default, op or self.opacity))
        
        cairo_translate (ldr, 0, 0)
        cairo_rotate (ldr, (rt or 0)* math.pi/180)
        -- cairo_translate (ldr, x or 0,y or 0)
        
        cairo_translate (ldr, x or 0,y or 0)
        -- cairo_set_source_rgba (dr, 200, 200, 200, 0.5)
        cairo_move_to (ldr, self.p1.x, self.p1.y)
        cairo_line_to (ldr, self.p2.x, self.p2.y)
        cairo_line_to (ldr, self.p3.x, self.p3.y)
        cairo_line_to (ldr, self.p4.x, self.p4.y)
        cairo_line_to (ldr, self.p5.x, self.p5.y)
        cairo_line_to (ldr, self.p6.x, self.p6.y)
        cairo_line_to (ldr, self.p1.x, self.p1.y)
        cairo_stroke(ldr)

        -- cairo_surface_destroy(ds)
        cairo_destroy(ldr) 
    end

    function hex:getCenter( ... )
        return self.pc.x, self.pc.y
    end

    return hex

end
return hexagon

