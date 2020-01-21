
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
--[[
============================================================================
               Inicio da funções de teste graficas
============================================================================
]]

    local function hexTeste( ... )

        local hx1 = hx:new(50,190,5,'ff99ff',0.5,100, math.random( 0,90 ))

        -- body
        -- hx1:draw(70,30,2, "ffffff", 0.3,15)
        -- hx1:fill(true)
        hx1:draw()
        -- print(hx1:getPoints().p1.x)
        cairo_arc(dr, hx1:p0().x + hx1:pi().x, hx1:p0().y + hx1:pi().y, 3., 0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, hx1:getPoints().p1.x, hx1:getPoints().p1.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, hx1:getPoints().p2.x, hx1:getPoints().p2.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, hx1:getPoints().p3.x, hx1:getPoints().p3.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, hx1:getPoints().p4.x, hx1:getPoints().p4.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, hx1:getPoints().p5.x, hx1:getPoints().p5.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, hx1:getPoints().p6.x, hx1:getPoints().p6.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)


        -- cairo_arc(dr, hx1:getPoints().p1.x, hx1:getPoints().p1.y, 5., 0,2*math.pi)
        -- cairo_move_to(dr, 100, 310)
        -- cairo_line_to (dr, 100 , 331)
        -- local a,b = cairo_get_current_point(dr)
        -- cairo_stroke(dr)
        -- print(a.." : " .. b)
        -- fe1:drawLine(hx1:getPoints().p1,hx1:getPoints().p4 ,2,"ff00aa",0.2)
        
        
        
        
        -- hx1:draw(70,150,1,"22ff00",0.4,10)
        -- hx1:draw(70,150,1,"22ff00",0.4,20)
        -- hx1:draw(70,150,1,"22ff00",0.4,30)
        -- hx1:draw(70,150,1,"22ff00",0.4,40)
            
    end


    local function teste_topHex( ... )
        

        local th1 = th:new(25, 350, 2,"ffff00", 0.5, 50,0)

        th1:draw(50, 350, 30)

        -- th1:draw(75, 350, 4, "ffff00", 0.5)
        -- cairo_arc(dr, th1:getPoints().p0.x, th1:getPoints().p0.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)

        
    end

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
        -- local points = sc1:pointsMark(0, math.pi, 10, 20)
        cairo_set_line_width (dr, 2)
        cairo_set_source_rgba (dr, 0.5,0.5,0.5, 0.8)

        cairo_move_to(dr,po.x,po.y)
        cairo_arc(dr,po.x, po.y,0.1,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr,po.x, po.y,50, 30 * math.pi/180, 180 * math.pi/180); cairo_new_sub_path(dr)

        local ag1, ag2, ag3 = 90, 0, 45
        local ang1 = ax.anglePosition(ag1, ag2 ); 
        local ang2 = ax.anglePosition(ag1, ag3 )
        
        local pg, pl = ax.pointOfAngleGrad(po.x, po.y,50 , 30), ax.pointOfAngleGrad(po.x, po.y,50 , 180)
        cairo_arc(dr,pg.x, pg.y,3,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr,pl.x, pl.y,3,0,2*math.pi); cairo_new_sub_path(dr)

        local p = ax.pointsArcGrad(po.x,po.y,70,0,360,11)
        for k,v in pairs(p) do
            cairo_arc(dr,v.x, v.y ,2,0,2*math.pi); cairo_new_sub_path(dr)
            -- cairo_arc(dr,v.x + 30 , v.y ,2,0,2*math.pi); cairo_new_sub_path(dr)
        end
        cairo_move_to(dr, po.x, po.y)
        local ix = math.random( 1, 11 )
        cairo_line_to(dr, p[ix].x, p[ix].y)

        cairo_stroke(dr)

        cairo_set_line_width (dr, 4)
        cairo_set_source_rgba (dr, 0.5,0.5,0.0, 0.8)
        cairo_new_sub_path(dr)

        cairo_arc(dr, po.x, po.y, 45, ang1, ang2) 
        cairo_new_sub_path(dr)

        cairo_stroke(dr)
    end

    local function testePoint( ... )
        local po = {x=100, y=250}

        local pv = ax.pointOfAngleGrad(po.x, po.y,50,-100)
        local pt = ax.pointOfAngleGrad(po.x, po.y,50,270)

        cairo_set_line_width (dr, 2)
        cairo_set_source_rgba (dr, 0.5,0.5,0.5, 0.8)

        cairo_move_to(dr,po.x,po.y)
        cairo_arc(dr,po.x, po.y,0.1,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, pv.x, pv.y,3,0,2*math.pi); cairo_new_sub_path(dr)
        cairo_arc(dr, pt.x, pt.y,3,0,2*math.pi); cairo_new_sub_path(dr)
        

        cairo_stroke(dr)
    end

    local function pointLine( )
        local p1, p2 = {x=100, y=150}, {x=10, y=250}
        -- local p1, p2 = {x=10, y=150}, {x=100, y=250}

        cairo_set_line_width (dr, 0.5)
        cairo_set_source_rgba (dr, 0.01,0.01,0.7, 1)

        local p = ax.pointsOfLine(p1.x,p1.y,p2.x,p2.y,20)
        for k,v in pairs(p) do
            cairo_arc(dr,v.x, v.y ,2,0,2*math.pi); cairo_new_sub_path(dr)
            cairo_arc(dr,v.x + 30 , v.y ,2,0,2*math.pi); cairo_new_sub_path(dr)
        end

        cairo_stroke(dr)

    end

    local function testeGradiencia( x0, y0, raio, angi, angf, npoints )
        
        -- cairo_move_to(dr,100, 350)
        cairo_set_line_width(dr,15)
        local linpat = cairo_pattern_create_linear (10, 50, 100, 350);
        -- cairo_pattern_add_color_stop_rgba (linpat, 0, 0, 0.3, 0.8,0.5);
        -- cairo_pattern_add_color_stop_rgba (linpat, 1, 0, 0.8, 0.3,0.3);

        cairo_pattern_add_color_stop_rgba (linpat, 0.35,  1, 1, 1, 0.5);
        cairo_pattern_add_color_stop_rgba (linpat, 0.44,  0, 1, 0, 0.5);
        cairo_pattern_add_color_stop_rgba (linpat, 0.45,  1, 1, 1, 0.5);
        cairo_pattern_add_color_stop_rgba (linpat, 0.40,  0, 0, 1, 0.5);
        cairo_pattern_add_color_stop_rgba (linpat, 0.40,  1, 0.5, 1, 0.6);

        local radpat = cairo_pattern_create_radial (60, 250, 10, 100, 250, 50);
        cairo_pattern_add_color_stop_rgba (radpat, 0, 1, 1, 0, 0.7);
        cairo_pattern_add_color_stop_rgba (radpat, 0.5, 0, 0, 0, 0);
        -- cairo_set_source (dr, linpat);
        cairo_mask (dr, radpat); 
        -- cairo_rectangle (dr, 10.0, 50.0, 100, 150);
        cairo_set_source (dr, linpat);
        -- cairo_fill (dr);
        cairo_move_to(dr,50, 10)
        cairo_line_to(dr, 100, 250)
        cairo_stroke(dr)
    end

function gradience( ... )
    -- body
    cairo_scale(dr, 120, 120);
    
	radpat = cairo_pattern_create_radial (0.25, 0.25, 0.1,  0.5, 0.5, 0.5);
	cairo_pattern_add_color_stop_rgb (radpat, 0,  1.0, 0.8, 0.8);
	cairo_pattern_add_color_stop_rgb (radpat, 1,  0.9, 0.0, 0.0);
    
	for i=1, 10 do
        for j=1,10 do
            cairo_rectangle (dr, i/10.0 - 0.04, j/10.0 - 0.04, 0.08, 0.08);
        end
    end
    cairo_set_source (dr, radpat);
	cairo_fill (dr);
end

function gradence( ... )
    cr = cairo_create (ds);
	cairo_scale (cr, 120, 120);

	radpat = cairo_pattern_create_radial (0.25, 0.25, 0.1,  0.5, 0.5, 0.5);
	cairo_pattern_add_color_stop_rgb (radpat, 0,  1.0, 0.8, 0.8);
	cairo_pattern_add_color_stop_rgb (radpat, 1,  0.9, 0.0, 0.0);

	for i=1,10 do
		for j=1,10 do
            cairo_rectangle (cr, i/10.0 - 0.04, j/10.0 - 0.04, 0.08, 0.08);
        end
    end
	cairo_set_source (cr, radpat);
	cairo_fill (cr);

	linpat = cairo_pattern_create_linear (0.25, 0.35, 0.75, 0.65);
	cairo_pattern_add_color_stop_rgba (linpat, 0.00,  1, 1, 1, 0);
	cairo_pattern_add_color_stop_rgba (linpat, 0.25,  0, 1, 0, 0.5);
	cairo_pattern_add_color_stop_rgba (linpat, 0.50,  1, 1, 1, 0);
	cairo_pattern_add_color_stop_rgba (linpat, 0.75,  0, 0, 1, 0.5);
	cairo_pattern_add_color_stop_rgba (linpat, 1.00,  1, 1, 1, 0);

	cairo_rectangle (cr, 0.0, 0.0, 1, 1);
	cairo_set_source (cr, linpat);
	cairo_fill (cr);
end


--[[ =================================================================
                          inicio das chamadas
     =================================================================]]  

     hexTeste() -- sucess
     -- grid()
     -- pointLine()
     circTeste()
     -- testePoint()
     -- drwSecCircle()
     -- testeGradiencia()
     -- gradence()
     teste_topHex()



    cairo_surface_destroy(ds)
    cairo_destroy(dr)
end
