
require 'cairo'

local fe = require("figures")
-- fg = require("figuras")
-- require("settings")

local th = require("topHexagon")
local hx = require("hexagon")

-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_main()
    if conky_window == nil then 
        return
    end
    -- print("ok...")
    ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    dr = cairo_create(ds)
    local fe1 = fe.new()
    local fe2 = fe.new()
    local fe3 = fe.new()
    local fe4 = fe.new()
    local th1 = th.new(50)
    local hx1 = hx.new(100)
    
    local x, y = hx1:getCenter()
    -- print (x .. " : " .. y)
    
    -- print(th1:getElement().d)
    -- print(hx1:getCenter())
    -- print(th1:getAllvar:d())
    th1:draw(25, 350, 2, "ffffff", 0.3)
    -- print(th1:getPoints().p1.y)
    local i, k, j = 0,10,3.2
    -- local kxc, kyc, rd, ang1, ang2 = th1:getPoints().p1.x, th1:getPoints().p1.y, 25., 0., (math.pi/3)
    local kxc, kyc, rd, ang1, ang2 = 80, 250, 75., math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k
    -- print(k)
    cairo_set_line_width(dr, 2)
    cairo_set_source_rgba(dr, 1,1,1, 0.3)

    cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 1*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
    ang1, ang2 = ang2 +0.05 , ang2 + (ang2 - ang1)
    cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 1*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
    -- i = i + 1 ; ang1, ang2 = math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k
    -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 1*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
    -- i = i + 1 ; ang1, ang2 = math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k
    -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 1*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
    -- i = i + 1 ; ang1, ang2 = math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k
    -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 1*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
    -- i = i + 1 ; ang1, ang2 = math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k
    -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 1*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
    -- i = i + 1 ; ang1, ang2 = math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k
    -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 1*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
    -- i = i + 1 ; ang1, ang2 = math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k

    cairo_stroke(dr)
    cairo_new_sub_path(dr)

    cairo_arc(dr, th1:getPoints().p2.x, th1:getPoints().p2.y, th1:getElement().d, ang1,ang2);-- cairo_new_sub_path(dr)
    cairo_arc_negative(dr, th1:getPoints().p2.x, th1:getPoints().p2.y, th1:getElement().d/2, ang2, ang1);-- cairo_new_sub_path(dr)
    cairo_fill(dr)
    cairo_close_path(dr); cairo_new_sub_path(dr)
    cairo_stroke(dr)



    th1:draw(75, 350, 4, "ffff00", 0.5)
    cairo_arc(dr, th1:getPoints().p0.x, th1:getPoints().p0.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)
    
    hx1:draw(70,30,2, "ffffff", 0.3,15)
    -- print(hx1:getPoints().p1.x)
    cairo_arc(dr, hx1:getPoints().p0.x, hx1:getPoints().p0.y, 3., 0,2*math.pi); cairo_new_sub_path(dr)
    cairo_arc(dr, hx1:getPoints().p1.x, hx1:getPoints().p1.y, 3., 0,2*math.pi)
    -- cairo_translate (dr, 70,30)
    cairo_new_sub_path(dr)
    cairo_arc(dr, hx1:getPoints().p2.x, hx1:getPoints().p2.y, 3., 0,2*math.pi)
    cairo_new_sub_path(dr)
    cairo_arc(dr, hx1:getPoints().p3.x, hx1:getPoints().p3.y, 3., 0,2*math.pi)
    cairo_new_sub_path(dr)
    cairo_arc(dr, hx1:getPoints().p4.x, hx1:getPoints().p4.y, 3., 0,2*math.pi)
    cairo_new_sub_path(dr)
    cairo_arc(dr, hx1:getPoints().p5.x, hx1:getPoints().p5.y, 3., 0,2*math.pi)
    cairo_new_sub_path(dr)
    cairo_arc(dr, hx1:getPoints().p6.x, hx1:getPoints().p6.y, 3., 0,2*math.pi)
    cairo_new_sub_path(dr)
    -- cairo_arc(dr, hx1:getPoints().p1.x, hx1:getPoints().p1.y, 5., 0,2*math.pi)
    -- cairo_move_to(dr, 100, 310)
    -- cairo_line_to (dr, 100 , 331)
    -- local a,b = cairo_get_current_point(dr)
    cairo_stroke(dr)
    -- print(a.." : " .. b)
    fe1:drawLine(hx1:getPoints().p1,hx1:getPoints().p4 ,2,"ff00aa",0.2)
    
    
    
    
    hx1:draw(70,150,1,"22ff00",0.4,10)
    hx1:draw(70,150,1,"22ff00",0.4,20)
    hx1:draw(70,150,1,"22ff00",0.4,30)
    hx1:draw(70,150,1,"22ff00",0.4,40)
    
    
    
    -- fe1:drawLine({x=120,y=70},{x=140,y=60},3,"ffffaa",0.4)
    

    -- fe1:retangulo(25, 50 ,25 ,10)
    -- fe2:retangulo(25, 75 ,-30 ,10)
    -- fe1:circulo(70, 20 ,100 ,100)
    -- fe3:circulo(20, 150 ,110 ,110)
    -- fe3:circuloGradiente(15 ,250 , 100, 50)
    -- fe3:imagem("/home/kobb/Imagens/wwoman01.png",0, 410,100,100)


    -- fe4:circulo(15 ,250 , 10, 50)
    -- fe4:circulo(25 ,250 , 10, 50)
    -- fe4:circulo(35 ,250 , 10, 50)
    -- fe4:circulo(45 ,250 , 10, 50)
    -- fe4:circulo(55 ,250 , 10, 50, 2, "aa000f",0.5)
    -- fe4:retangulo(15 ,250 , 100, 50,1,"220000",0.3)


    local function draw_rounded(cr, a, b, c, d, radius)
        -- body
        --""" draws rectangles with rounded (circular arc) corners """
        -- local a,b,c,d=area
        cairo_arc(dr, a + radius, c + radius, radius, 2*(math.pi/2), 3*(math.pi/2))
        cairo_arc(dr, b - radius, c + radius, radius, 3*(math.pi/2), 4*(math.pi/2))
        cairo_arc(dr, b - radius, d - radius, radius, 0*(math.pi/2), 1*(math.pi/2)) 
        cairo_arc(dr, a + radius, d - radius, radius, 1*(math.pi/2), 2*(math.pi/2))
        cairo_close_path(dr)
        cairo_stroke(dr)
    end 
    
    local function roudRec( ... )
        local w,h = 80, 50
        local offset = 5
        local fig_size = {w,h}
    
        --# an area with coordinates of
        --# (top, bottom, left, right) edges in absolute coordinates:
        -- local inside_area = offset, w-offset, offset, h-offset
    
        cairo_set_line_width(dr,2)
        cairo_set_source_rgba(dr, 1,1,1, 0.3)
    
        -- draw_rounded(dr, offset, w-offset, offset, h-offset, 5)
        draw_rounded(dr, 5, 75, 10, 45, 5)
    end
    roudRec()


    cairo_surface_destroy(ds)
    cairo_destroy(dr)
end
