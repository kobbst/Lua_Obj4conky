figure = {}
function figure.new()
    fig = {x = 0, y = 0, width = 50, height = 50}
    function fig:path()
        local ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local dr = cairo_create(ds)

        local x1,y1 = 5,600
        local x2,y2 = 50,600
        cairo_set_line_width (dr, 5);
        cairo_set_source_rgba (dr, 200, 200, 200, 0.1);
        cairo_move_to (dr, x1, y1)
        cairo_line_to (dr, x2, y2)
        cairo_rel_line_to (dr, x2+100, y2-450)
        cairo_stroke (dr);
        cairo_surface_destroy(ds)
        cairo_destroy(dr)
    end

    function fig:square()
        local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local cr = cairo_create(cs)
        
        cairo_set_line_width (cr, 10.90);
        cairo_set_source_rgba (cr, 200, 00, 00,0.2);
        -- cairo_scale (cr, 0.5, 1);
        cairo_rectangle (cr, 10.25, 300.25, 200.5, 200.5);
        -- cairo_translate (cr, 1, 0);
        cairo_rectangle (cr, 30.25, 330.25, 200.5, 200.5);
        cairo_stroke (cr);
            
        cairo_surface_destroy(cs)
        cairo_destroy(cr)
    end
    function fig:circulo(self, x, y, width, height)
        local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local cr = cairo_create(cs)
        self.x = tonumber(x) or 0; 
        self.y = y; self.width = width; self.height = height
        -- local _x,_y,_w,_h = 15, 200,200,200
        cairo_set_line_width (cr, 20)
        cairo_set_source_rgba (cr, 1, 1, 1,0.3)
        cairo_arc (cr, self.x, self.y ,50 , 0, 2 * math.pi)
        cairo_stroke (cr)

        cairo_surface_destroy(cs)
        cairo_destroy(cr)
    end

    return fig
end
function circulo2(x, y, width, height)
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)

    local _x,_y,_w,_h = 15, 200,200,200
    cairo_set_line_width (cr, 20)
    cairo_set_source_rgba (cr, 1, 1, 1,0.3)
    cairo_arc (cr, x + width/2, y + height/2. ,width/2 , 0, 2 * math.pi)
    cairo_stroke (cr)

    cairo_surface_destroy(cs)
    cairo_destroy(cr)
end

-- excelente função! usa scala para gerar circulo ou elipse.
function circulo3(x, y, width, height)
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)

    cairo_set_line_width (cr, 10)
    cairo_set_source_rgba (cr, 1, 1, 1,0.3)

    cairo_save (cr)
    cairo_translate (cr, x + width / 2., y + height / 2.)
    cairo_scale (cr, width / 2., height / 2.)
    cairo_arc_negative (cr, 0., 0., 1., 0,math.pi/2)
    cairo_restore (cr)

    cairo_stroke (cr)

    cairo_surface_destroy(cs)
    cairo_destroy(cr)
end

function retangulo(x, y, width, height)
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)

    cairo_set_line_width (cr, 10)
    cairo_set_source_rgba (cr, 1, 1, 1,0.3)

    cairo_save (cr)
    cairo_translate (cr, x , y )
    cairo_scale (cr, width , height )
    -- cairo_arc_negative (cr, 0., 0., 1., 0,math.pi/2)
    cairo_rectangle(cr, 0, 0, 1, 1)
    cairo_restore (cr)

    cairo_stroke (cr)

    cairo_surface_destroy(cs)
    cairo_destroy(cr)
end

-- fig.path = path
-- fig.square = square





function fig:loadSVG(filename)
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)
    -- print(filename)

    -- rsvg_handle_render_cairo(rsvg_handle_new_from_file(filename),cr)

    cairo_stroke (cr)

    cairo_surface_destroy(cs)
    cairo_destroy(cr)
end
function showPNG(filename)
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    -- local cs = cairo_image_surface_create_from_png (filename)
    local cr = cairo_create(cs)


    cairo_surface_destroy(cs)
    cairo_destroy(cr)        
end