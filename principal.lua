
require 'cairo'

local fe = require("figures")
-- fg = require("figuras")
-- require("settings")

local th = require("topHexagon")
local hx = require("hexagon")
local sc = require("sector")

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
    
    local sc1 = sc.new()
    sc1:setOptions(3,"0000ff", 0.5)
    sc1:drawSector(100, 150, 50, 10, 40)
    sc1:test01(100, 150, 50, 10, 40)
    
    local x, y = hx1:getCenter()
    -- print (x .. " : " .. y)
    
    -- print(th1:getElement().d)
    -- print(hx1:getCenter())
    -- print(th1:getAllvar:d())
    th1:draw(25, 350, 2, "ffffff", 0.3)
    -- print(th1:getPoints().p1.y)
    
    
    
    
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


    -------------------------------------------------------------------------------
    --                                                            angle_to_position
    -- convert degree to rad and rotate (0 degree is top/north)
    --
    local function angle_to_position(start_angle, current_angle)
        local pos = current_angle + start_angle
        return ( ( pos * (2 * math.pi / 360) ) - (math.pi / 2) )
    end

    local function test01( ... )
        local i, k, j = 0,10,3.2
        -- local kxc, kyc, rd, ang1, ang2 = th1:getPoints().p1.x, th1:getPoints().p1.y, 25., 0., (math.pi/3)
        local kxc, kyc, rd, ang1, ang2 = 80, 250, 50., math.pi + i * math.pi/k, -3 * math.pi / j  + i * math.pi/k
        -- print(k)
        local lgrau = math.pi/180; local ag1 = 180
        cairo_set_line_width(dr, 1)
        cairo_set_source_rgba(dr, 1,1,1, 0.3)
        -- ang1 =  2 * math.pi; ang2 = math.pi - math.pi/6 
        local ai, arco, desl = 0, 15, 3
        
        for i=1,10 do
            ang1 =  angle_to_position(ag1,ai); ang2 = angle_to_position(ag1,ai + arco); ai = ai + arco + desl
            cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
        end

            -- ang1 =  angle_to_position(ag1,35); ang2 = angle_to_position(ag1,60)
            -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
            -- ang1 =  angle_to_position(ag1,65); ang2 = angle_to_position(ag1,90)
            -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
           



        -- ang1 =  angle_to_position(ag1,0 + 5); ang2 = angle_to_position(ag1,i + 5 * lgrau)
        -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
        -- ang1 =  ang2 + 5 * lgrau; ang2 = angle_to_position(ag1,2*i + 5 * lgrau)
        -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
        -- ang1 =  ang2 + 5 * lgrau; ang2 = angle_to_position(ag1,3*i + 5 * lgrau)
        -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
        -- ang1 =  ang2 + 5 * lgrau; ang2 = angle_to_position(ag1,4*i + 5 * lgrau)
        -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
        -- ang1 =  ang2 + 5 * lgrau; ang2 = angle_to_position(ag1,5*i + 5 * lgrau)
        -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
        -- ang1 =  ang2 + 5 * lgrau; ang2 = angle_to_position(ag1,6*i + 5 * lgrau)
        -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
        -- ang1 =  ang2 + 5 * lgrau; ang2 = angle_to_position(ag1,7*i + 5 * lgrau)
        -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)
        -- ang1 =  ang2 + 5 * lgrau; ang2 = angle_to_position(ag1,8*i + 5 * lgrau)
        -- cairo_arc(dr, kxc, kyc, rd, ang1, ang2) ; cairo_arc_negative(dr, kxc, kyc, 3*rd/2, ang2, ang1);cairo_close_path(dr); cairo_new_sub_path(dr)

        
        cairo_stroke(dr)
        cairo_new_sub_path(dr)
        
        -- cairo_arc(dr, th1:getPoints().p2.x, th1:getPoints().p2.y, th1:getElement().d, ang1,ang2);-- cairo_new_sub_path(dr)
        -- cairo_arc_negative(dr, th1:getPoints().p2.x, th1:getPoints().p2.y, th1:getElement().d/2, ang2, ang1);-- cairo_new_sub_path(dr)
        -- cairo_fill(dr)
        -- cairo_close_path(dr); cairo_new_sub_path(dr)
        -- cairo_stroke(dr)
    end
    
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
    -- test01()
    local function gradiente( ... )
        -- body
        npad = cairo_pattern_create_linear();

        -- / * Adicione um patch Coons * /
        cairo_mesh_pattern_begin_patch ( npad );
        cairo_mesh_pattern_move_to ( npad , 0 , 0 );
        cairo_mesh_pattern_curve_to ( npad , 30 , - 30 , 60 , 30 , 100 , 0 );
        cairo_mesh_pattern_curve_to ( npad , 60 , 30 , 130 , 60 , 100 , 100 );
        cairo_mesh_pattern_curve_to ( npad , 60 , 70 , 30 , 130 , 0 , 100 );
        cairo_mesh_pattern_curve_to ( npad , 30 , 70 , - 30 , 30 , 0 , 0 );
        cairo_mesh_pattern_set_corner_color_rgb ( npad , 0 , 1 , 0 , 0 );
        cairo_mesh_pattern_set_corner_color_rgb ( npad , 1 , 0 , 1 , 0 );
        cairo_mesh_pattern_set_corner_color_rgb ( npad , 2 , 0 , 0 , 1 );
        cairo_mesh_pattern_set_corner_color_rgb ( npad , 3 , 1 , 1 , 0 );
        cairo_mesh_pattern_end_patch ( npad );
    
        -- / * Adicione um triângulo sombreado em Gouraud * /
        cairo_mesh_pattern_begin_patch ( npad )
        cairo_mesh_pattern_move_to ( npad , 100 , 100 );
        cairo_mesh_pattern_line_to ( npad , 130 , 130 );
        cairo_mesh_pattern_line_to ( npad , 130 , 70 );
        cairo_mesh_pattern_set_corner_color_rgb ( npad , 0 , 1 , 0 , 0 );
        cairo_mesh_pattern_set_corner_color_rgb ( npad , 1 , 0 , 1 , 0 );
        cairo_mesh_pattern_set_corner_color_rgb ( npad , 2 , 0 , 0 , 1 );
        cairo_mesh_pattern_end_patch ( npad ) 

        cairo_set_source (dr, npat);
        cairo_paint(dr);
    end


    local function gradien2( ... )
        -- body
        alpha=0.4;
        spat = cairo_pattern_create_radial(100, 200, 200,  0, 560, 150);
        -- spat = cairo_pattern_create_linear(0, 20, 50, 200);
        cairo_pattern_add_color_stop_rgba(spat, 0,  0, 0, 0.8, alpha);
        cairo_pattern_add_color_stop_rgba(spat, 0.25,  1, 1, 0, alpha);
        cairo_pattern_add_color_stop_rgba(spat, 0.5,  0.9, 0.0, 0.0, alpha);
        cairo_pattern_add_color_stop_rgba(spat, 0.75,  0.8, 0.12, 0.56, alpha);
        cairo_pattern_add_color_stop_rgba(spat, 1,  0, 0, 0, alpha);
        
        cairo_set_source (dr, spat);
        cairo_paint(dr);
        

    end

    local function function_name( ... )
        -- body
        int i, j; 
        -- cairo_pattern_t *radpat, *linpat; 
        radpat = cairo_pattern_create_radial (0.25, 0.25, 0.1, 0.5, 0.5, 0.5); 
        cairo_pattern_add_color_stop_rgb (radpat, 0, 1.0, 0.8, 0.8); 
        cairo_pattern_add_color_stop_rgb (radpat, 1, 0.9, 0.0, 0.0); 
        for i=1,  i<10, 1 do 
            for j=1, j<10, 1 do
                 cairo_rectangle (dr, i/10.0 - 0.04, j/10.0 - 0.04, 0.08, 0.08); 
            end
        end
            
            cairo_set_source (dr, radpat); 
            cairo_fill (dr); 
            linpat = cairo_pattern_dreate_linear (0.25, 0.35, 0.75, 0.65); 
            cairo_pattern_add_color_stop_rgba (linpat, 0.00, 1, 1, 1, 0); 
            cairo_pattern_add_color_stop_rgba (linpat, 0.25, 0, 1, 0, 0.5); 
            cairo_pattern_add_color_stop_rgba (linpat, 0.50, 1, 1, 1, 0); 
            cairo_pattern_add_color_stop_rgba (linpat, 0.75, 0, 0, 1, 0.5); 
            cairo_pattern_add_color_stop_rgba (linpat, 1.00, 1, 1, 1, 0); 
            cairo_rectangle (dr, 0.0, 0.0, 1, 1); 
            cairo_set_source (dr, linpat); 
            cairo_fill (dr); 
    end
    -- gradien2()

    cairo_surface_destroy(ds)
    cairo_destroy(dr)
end
