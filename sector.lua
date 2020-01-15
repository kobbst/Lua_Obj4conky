local gc = require("getColor")
local ax = require("auxFunctions")
local class = require('middleclass')
local Figure = require("figureObj")


Sector = class('Sector', Figure)

function Sector:initialize( ... )
    Figure.initialize(self, ...)
    local op = { ... }
    -- x, y, ln, cl, op, ang1, ang2, ang_ini
    self.__ang1 = (op.ang1 or op[6] or 0)
    self.__ang2 = (op.ang2 or op[7] or 90) 
    self.__ang_ini = (op.ang_ini or op[8] or 180) 
    self.__radius = (op.rd or op[9] or 50) 
    self.__fill = false
end

-- ===========  getters/setters ====================
function Sector:startAngle(value_ang1) -- setter width
    if value_ang1 then self.__ang1 = value_ang1 end
    return self.__ang1
end
function Sector:endAngle(value_ang2) -- setter height
    if value_ang2 then self.__ang2 = value_ang2 end
    return self.__ang2
end
function Sector:posAngle(value_ang_ini) -- setter height
    if value_ang_ini then self.__ang_ini = value_ang_ini end
    return self.__ang_ini
end
function Sector:radius(value_radius) -- setter height
    if value_radius then self.__radius = value_radius end
    return self.__radius
end
function Sector:fill(value_fill) -- setter height
    if value_fill then self.__fill = value_fill end
    return self.__fill
end
-- ===========      methods     ====================

function Sector:drawSector( xc, yc, rd, ag1, ag2, ang_ini )

    local ldr = self.__cr or cairo_create(ds)
    
    -- local xc, yc, rd, ag1, ag2, ang_ini = {...}
    local agI = ang_ini or self.__ang_ini or 180
    
    cairo_set_line_width (ldr, self.line_width)
    cairo_set_source_rgba (ldr, gc.hex(self.color_default, self.__opacity))

    local ang1 = ax.anglePosition(agI, ag1 or self.__ang1)
    local ang2 = ax.anglePosition(agI, ag2 or self.__ang2)

    cairo_arc(ldr, xc or self.x, yc or self.y, rd or self.__radius, ang1, ang2) 
    cairo_arc_negative(ldr, xc or self.x, yc or self.y, (rd or self.__radius)/2, ang2, ang1)
    if self.__fill then cairo_fill(ldr) end
    cairo_close_path(ldr) 
    cairo_stroke(ldr)
    -- cairo_new_sub_path(ldr)
    -- cairo_destroy(ldr) 
    
end

function Sector:grabbPoint( ... )
    return { pc = {x = self.x, y = self.y},radius = self.__radius}
end

function Sector:drawDelta( ... ) --x, y, rd, ang1, delta
    local op = {...}
    local x, y, rd = op[1] or self.x, op[2] or self.y, op[3] or self.__radius
    local ang1, dta = op[4] or self.__ang1, op[5] or 1
    self:drawSector(x ,y , rd, ang1, ang1 + dta)
end

function Sector:drawSectorOld( xc, yc, rd, ang1, ang2 )
    local ldr = cairo_create(ds)
    
    -- local xc, yc, rd, ang1, ang2 = {...}
    local ag1 = 180
    
    cairo_set_line_width (ldr, self.line_width)
    cairo_set_source_rgba (ldr, gc.hex(self.color_default, self.__opacity))

    local ang1 = ax.anglePosition(ag1, ang1 or self.__ang1); 
    local ang2 = ax.anglePosition(ag1, ang2 or self.__ang2)
    cairo_arc(ldr, xc or self.x, yc or self.y, rd, ang1, ang2) 
    cairo_arc_negative(ldr, xc or self.x, yc or self.y, rd/2, ang2, ang1)
    -- cairo_fill(ldr)
    cairo_close_path(ldr) 
    cairo_stroke(ldr)
    -- cairo_new_sub_path(ldr)
    cairo_destroy(ldr) 
    
end

function Sector:drawSectors(x, y, rd, ang1, ang2, angIntra ,n_angs, ang_ini)
    local x, y, rd,ang1 ,ang2, agIt, ngs, agIn = x, y, rd, ang1, ang2, angIntra ,n_angs, ang_ini
    local dta = ((ang2 - ang1) - (ngs * agIt))/ngs

    local collection = {}
    local obj = Sector:new()
    obj:xy(x,y); obj:startAngle(ang1); obj:endAngle(ang1 + dta); obj:radius(rd)
    table.insert( collection, obj)
    obj = nil
    for i=2, 10 do
        obj = Sector:new()
        ang1 = ang1 + dta + agIt
        obj:xy(x,y); obj:startAngle(ang1); obj:endAngle(ang1 + dta); obj:radius(rd)
        table.insert( collection, obj)
        obj = nil
    end
     return #collection, collection, dta
end

function Sector:test01( ... )
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

return Sector