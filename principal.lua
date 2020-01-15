
require 'cairo'

local fe = require("figures")
-- fg = require("figuras")
-- require("settings")

local th = require("topHexagon")
local hx = require("hexagon")
local sector = require("sector")
local circle = require("circle")
local rt = require("rectangle")

local effil = require("effil")


-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_main()
    if conky_window == nil then 
        return
    end
    -- print("ok...")
    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)
    
    if update_num > 5 then
        -- go_gauge_rings(display)
    end
    
    -- print(math.fmod( update_num, 100 ))

    ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    dr = cairo_create(ds)

    
    local sc1 = sector:new(100,150)
    sc1:opacity(0.3)
    sc1:radius(50); sc1:fill(true)
    sc1:startAngle(math.fmod( update_num, 45)*8); 
    sc1:endAngle(sc1:startAngle() + 30);
    -- sc1:drawSector(); sc1:fill(false)
    sc1:drawDelta(nil,nil,nil,45 - sc1:startAngle(),15)
    sc1:drawDelta(nil,nil,nil,90 - sc1:startAngle(),20)
    sc1:drawDelta(nil,nil,nil,135 - sc1:startAngle(),15)
    sc1:drawDelta(nil,nil,nil,180 - sc1:startAngle(),20)
    sc1:drawDelta(nil,nil,nil,225 - sc1:startAngle(),15)
    sc1:drawDelta(nil,nil,nil,270 - sc1:startAngle(),20)
    sc1:drawDelta(nil,nil,nil,315 - sc1:startAngle(),15)
    sc1:drawDelta(nil,nil,nil,360 - sc1:startAngle(),20)
    sc1:test01(100, 150, 50, 10, 40)

    local res, col, dta = sc1:drawSectors(100,250, 50, 10, 180, 5, 10, 180)
    
    col[4]:lineWidth(1);col[4]:fill(true)
    col[1]:drawDelta(nil,nil,nil,nil,dta)
    col[2]:drawDelta(nil,nil,nil,nil,dta)
    col[3]:drawDelta(nil,nil,nil,nil,dta)
    col[4]:drawDelta(nil,nil,nil,nil,dta)
    col[5]:drawDelta(nil,nil,nil,nil,dta)
    col[6]:drawDelta(nil,nil,nil,nil,dta)
    col[7]:drawDelta(nil,nil,nil,nil,dta)
    col[8]:drawDelta(nil,nil,nil,nil,dta)
    col[9]:drawDelta(nil,nil,nil,nil,dta)

    -- sc1:drawSector(100, 150, 50, 30, 60)
    cc1 = circle:new(); cc1:opacity(0.5); cc1:lineWidth(1)
    cc1:drawEllipse(100,150,math.fmod( update_num, 25 ) * 2, 50 - (math.fmod( update_num, 25 ) * 2));
    cc1:drawEllipse(100,150,70 - math.fmod( update_num, 25 ) * 2,(math.fmod( update_num, 25 ) * 2));
    
    cc1:drawEllipse(100,150,100,100)
    
    
    cairo_surface_destroy(ds)
    cairo_destroy(dr)
end
