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
        thex.teste = thex.p1.y
    function thex:getElement()
        return self.d, self.height, self.width, self.teste
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

    return thex
end

return topHex
