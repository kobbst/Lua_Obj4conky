local gc = require("getColor")
local ax = require("auxFunctions")

local sector = {}


-- function sector.new(xc, yc, rd, ang1, ang2, ang_ini)
function sector.new(...)
    local op = { ... }
    local sec = {
        x = (op.xc or op[1] or 0), y = (op.yc or op[2] or 0), width = 50, height = 50,
        rd = (op.rd or op[3] or 1), 
        ang1 = (op.ang1 or op[4] or 0), 
        ang2 = (op.ang2 or op[5] or 90), 
        ang_ini = (op.ang_ini or op[6] or 180) ,
        line_width = 2, color_default = 'ffffff', opacity = 1.
    }
    function sec:setOptions( ... ) -- line = ln , color = cl, opacity = op, fill_color = fl
        local op = {...}
        self.line_width = (op.ln or op[1] or self.line_width)
        self.color_default = (op.cl or op[2] or self.color_default)
        self.opacity = (op.op or op[3] or self.opacity)
        
    end
    function sec:drawSector( xc, yc, rd, ang1, ang2 )
        local ldr = cairo_create(ds)
        
        -- local xc, yc, rd, ang1, ang2 = {...}
        local ag1 = 180
        
        cairo_set_line_width (ldr, self.line_width)
        cairo_set_source_rgba (ldr, gc.hex(self.color_default, self.opacity))

        local ang1 = ax.anglePosition(ag1, ang1); 
        local ang2 = ax.anglePosition(ag1, ang2)
        cairo_arc(ldr, xc, yc, rd, ang1, ang2) 
        cairo_arc_negative(ldr, xc, yc, rd/2, ang2, ang1)
        -- cairo_fill(ldr)
        cairo_close_path(ldr) 
        cairo_stroke(ldr)
        -- cairo_new_sub_path(ldr)
        cairo_destroy(ldr) 
        
    end
    function sec:test01( ... )
        local ldr = cairo_create(ds)

        local i, k, j = 0,10,3.2
        -- local kxc, kyc, rd, ang1, ang2 = th1:getPoints().p1.x, th1:getPoints().p1.y, 25., 0., (math.pi/3)
        local kxc, kyc, rd, ang1, ang2 = 80, 250, 50., math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k

        local lgrau = math.pi/180; local ag1 = 180
        cairo_set_line_width(ldr, 1)
        cairo_set_source_rgba(ldr, 1,1,1, 0.3)
        -- ang1 =  2 * math.pi; ang2 = math.pi - math.pi/6 
        local ai, arco, desl = 0, 15, 3
        
        for i=1,10 do
            ang1 = ax.anglePosition(ag1,ai); ang2 = ax.anglePosition(ag1,ai + arco); ai = ai + arco + desl
            cairo_arc(ldr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(ldr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(ldr); cairo_new_sub_path(ldr)
        end

        cairo_stroke(ldr)
        cairo_new_sub_path(ldr)
        cairo_destroy(ldr) 
    end
    return sec
end
return sector