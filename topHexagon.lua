--[[
    http://www.brawnexercicios.com.br/2012/03/exercicio-resolvido-geometria-plana.html
    
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


local topHex = {}

function topHex.new(width)
    local thex = {
        width = width or 1, height =  (width or 1) /(2*math.sqrt(3)),
        d = (width or 1)/(2*math.cos(math.pi/6)),
        p0 = {x = (width or 1)/(2), y = 0, z = 0},
        p1 = {x1 = 0, y1 = height, z = 0},
        p2 = {x2 = width, y2 = height, z = 0},
        line_width = 1, color_default = 'ffffff', opacity = 1.
        }
    function thex:getElement()
        return self.d, self.height, self.width
    end

    function thex:getAllvar(  )
        return thex
        -- body
    end

    return thex
end

return topHex
