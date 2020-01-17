
require 'cairo'

local fe = require("figures")
-- fg = require("figuras")
-- require("settings")
local ax = require("auxFunctions")
local th = require("topHexagon")
local hx = require("hexagon")
local sector = require("sector")
local circle = require("circle")
local rt = require("rectangle")
local scale = require("scale")

-- local effil = require("effil")


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

    -- print(math.atan(ax.anglePosition(0,30))*180/math.pi)

    -- print(conky_window.height)
    -- print(cairo_surface_get_type(ds))
    local function drwSecCircle( ... )
        -- body
        local sc1 = sector:new(conky_window.width/2,250,2,nil,0.3)
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
        -- sc1:test01(100, 150, 50, 10, 40)

        local sc2 = sector:new(100,150,1,'90f0ff',0.3)
        local res, col, dta = sc2:drawSectors(conky_window.width/2, 250, 100, 0, 360, 2, 9, 180)
        -- print(res)
        local id = math.fmod( update_num, res ) +1
        col[id]:lineWidth(4);col[id]:fill(true);col[id]:color('90f00f')
        -- col[id]:drawDelta(nil,nil,nil,,dta)
        for i=1,res do
            col[i]:drawDelta(nil,nil,nil,nil,dta)
        end

        -- sc1:drawSector(100, 150, 50, 30, 60)
        cc1 = circle:new(); cc1:opacity(0.5); cc1:lineWidth(1)
        cc1:drawEllipse(conky_window.width/2,250,math.fmod( update_num, 25 ) * 2, 50 - (math.fmod( update_num, 25 ) * 2));
        cc1:drawEllipse(conky_window.width/2,250,70 - math.fmod( update_num, 25 ) * 2,(math.fmod( update_num, 25 ) * 2));
        
        cc1:drawEllipse(conky_window.width/2,250,100,100)
    end
    local function grid( ... )
        -- body
        rt1 = rt.Rectangle:new(nil, nil, 0, '0f9002', 0.4);
        rt2 = rt.Rectangle:new(nil, nil, 0, '0090a2', 0.4);
        
        rects = rt1:drawGrid(10, 11, 200, 310, 20, 25, 2)local scale = require("scale")

        local rdx, rdy = math.random( 1,20), math.random( 1,25)

        for k=1,30 do
            rdx, rdy = math.random( 1,20), math.random( 1,25)
            rects[rdx][rdy]:color('ffffff'); rects[rdx][rdy]:opacity(0.5); rects[rdx][rdy]:fill(true);
        end    
        
        for i=1,20 do
            for j=1,25 do
                rects[i][j]:draw()
            end
        end

        local nv, nh, tf = 20, 30, 40
        local rtx = rt2:drawGridWH(10, 310, 200, 310, nv, nh, 2)
        for k=1,tf do
            rdx, rdy = math.random( 1,20), math.random( 1,25)
            rtx[rdx][rdy]:color('ffffff'); rtx[rdx][rdy]:opacity(0.5); rtx[rdx][rdy]:fill(true);
        end
        for i=1,nv do
            for j=1,nh do
                rtx[i][j]:draw()
            end
        end    
    end

    local function circTeste( ... )
        local po = {x=100, y=250}
        local sc1 = scale:new()
        local points = sc1:pointsMark(0, math.pi, 10, 20)
        cairo_set_line_width (dr, 2)
        cairo_set_source_rgba (dr, 0.5,0.5,0.5, 0.8)

        cairo_move_to(dr,po.x,po.y)
        cairo_arc(dr,po.x, po.y,0.1,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr,po.x, po.y,50, 30 * math.pi/180, 180 * math.pi/180); cairo_new_sub_path(dr)

        local ag1, ag2, ag3 = 90, 0, 45
        local ang1 = ax.anglePosition(ag1, ag2 ); 
        local ang2 = ax.anglePosition(ag1, ag3 )
        
        -- print(ax.anglePosGrad(ag1, ag3))
        -- print(ang1 .. ":" .. ang2)
        local pg, pl = ax.pointOfAngleGrad(po.x, po.y,50 , 30), ax.pointOfAngleGrad(po.x, po.y,50 , 180)
        cairo_arc(dr,pg.x, pg.y,3,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr,pl.x, pl.y,3,0,2*math.pi); cairo_new_sub_path(dr)

        -- local pv = pointOf(po.x, po.y, 50,0,2*math.pi/2)
        -- cairo_arc(dr, pv[1].x, pv[1].y,3,0,2*math.pi); cairo_new_sub_path(dr)
        -- cairo_arc(dr, pv[2].x, pv[2].y,2,0,2*math.pi);

        cairo_stroke(dr)

        
        local pg, pl = ax.pointOfAngle 
        cairo_set_line_width (dr, 4)
        cairo_set_source_rgba (dr, 0.5,0.5,0.0, 0.8)
        cairo_new_sub_path(dr)
        cairo_arc(dr, po.x, po.y, 45, ang1, ang2) 
        cairo_new_sub_path(dr)
        cairo_stroke(dr)

        -- local p = pointOf(po.x, po.y, 45, ang1, ang2)
        
        -- cairo_arc(dr, p.p1.x, p.p1.y,1,0,2*math.pi); cairo_new_sub_path(dr)
        -- cairo_arc(dr, p.p2.x, p.p2.y,2,0,2*math.pi);

        cairo_stroke(dr)
    end

    local function testePoint( ... )
        local po = {x=100, y=250}

        local pv = ax.pointOfAngleGrad(po.x, po.y,50,-100)
        local pt = ax.pointOfAngleGrad(po.x, po.y,50,270)

        cairo_set_line_width (dr, 2)
        cairo_set_source_rgba (dr, 0.5,0.5,0.5, 0.8)

        cairo_move_to(dr,po.x,po.y)
        cairo_arc(dr,po.x, po.y,0.1,0,2*math.pi); --cairo_new_sub_path(dr)
        cairo_arc(dr, pv.x, pv.y,3,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, pt.x, pt.y,3,0,2*math.pi); cairo_new_sub_path(dr)
        

        cairo_stroke(dr)
    end

    local function pointLine({x,y} )
        local p1, p2 = {x=100, y=150}, {x=10, y=250}
        local delta = {x = p2.x - p1.x, y = p2.y - p1.y}
        local diag =  (delta.x^2 + delta.y^2)^0.5
        
        -- print(delta.y / delta.x * 10)
        cairo_set_line_width (dr, 2)
        cairo_set_source_rgba (dr, 0.5,0.5,0.5, 0.8)

        cairo_move_to(dr,p1.x,p1.y)
        cairo_arc(dr,p1.x, p1.y,2,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr,p2.x, p2.y,2,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr,p1.x + 10 , p1.y +  (10 * delta.y/delta.x) ,2,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr,p1.x + 30 , p1.y +  (30 * delta.y/delta.x) ,2,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr,p1.x + 50 , p1.y +  (50 * delta.y/delta.x) ,2,0,2*math.pi); cairo_new_sub_path(dr)


        cairo_stroke(dr)

    end
    pointLine()
    -- circTeste()
    -- testePoint()
    cairo_surface_destroy(ds)
    cairo_destroy(dr)
end
