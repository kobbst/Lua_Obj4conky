-- require 'cairo'

local gc = require("getColor")

local figure = {}

function figure.new(cs)
    local fig = {x = 0, y = 0, width = 50, height = 50,
                line_width = 1, color_default = 'ffffff', opacity = 1.
                }

    function fig:path()
        local ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local dr = cairo_create(ds)

        local x1,y1 = 5,600
        local x2,y2 = 50,600
        cairo_set_line_width (dr, self.line_width);
        cairo_set_source_rgba (dr, 200, 200, 200, 0.1);
        cairo_move_to (dr, x1, y1)
        cairo_line_to (dr, x2, y2)
        cairo_rel_line_to (dr, x2+100, y2-450)
        cairo_stroke (dr)
        cairo_surface_destroy(ds)
        cairo_destroy(dr)
    end
    
    function fig:square()
        local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local cr = cairo_create(cs)
        
        cairo_set_line_width (cr, 10.90)
        cairo_set_source_rgba (cr, 200, 00, 00,0.2)
        -- cairo_scale (cr, 0.5, 1)
        cairo_rectangle (cr, 10.25, 300.25, 200.5, 200.5)
        -- cairo_translate (cr, 1, 0)
        cairo_rectangle (cr, 30.25, 330.25, 200.5, 200.5)
        cairo_stroke (cr)
        
    end
    
    -- excelente função! usa scala para gerar circulo ou elipse.
    function fig:circulo(x, y, w, h,ln, cl, op)
        local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local cr = cairo_create(cs)
        
        -- print(gc.hex("ffffff"))
        
        cairo_set_line_width (cr, ln or self.line_width)
        -- cairo_set_source_rgba (cr, 1, 1, 1,0.3)
        cairo_set_source_rgba (cr, gc.hex(cl or self.color_default, op or self.opacity))
        
        cairo_save (cr)
        cairo_translate (cr, x + w/2, y + h/2)
        cairo_scale (cr, w/2., h/2.)
        cairo_arc(cr, 0., 0., 1., 0,2*math.pi)
        -- cairo_fill(cr)
        cairo_restore (cr)
        
        cairo_stroke (cr)
        
        cairo_surface_destroy(cs)
        cairo_destroy(cr)
    end
    
    function fig:retangulo(x, y, w, h,ln, cl, op)
        local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local cr = cairo_create(cs)
        
        -- print(gc.hex("ffffff"))
        
        cairo_set_line_width (cr, ln or self.line_width)
        -- cairo_set_source_rgba (cr, 1, 1, 1,0.3)
        cairo_set_source_rgba (cr, gc.hex(cl or self.color_default, op or self.opacity))
        
        cairo_save (cr)
        cairo_translate (cr, x , y )
        cairo_scale (cr, w , h)
        cairo_rectangle(cr, 0, 0, 1, 1)
        cairo_restore (cr)
        
        cairo_stroke (cr)
        
        cairo_surface_destroy(cs)
        cairo_destroy(cr)
    end    
    
    function fig:circuloGradiente(x, y, w, h,ln, cl, op)
        local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local cr = cairo_create(cs)
        
        local pat = cairo_pattern_create_radial (115.2, 102.4, 25.6, 102.4, 102.4, 128.0)
        cairo_pattern_add_color_stop_rgba (pat, 0, 1, 1, 1, 1)
        cairo_pattern_add_color_stop_rgba (pat, 1, 0, 0, 0, 1)
        cairo_set_source (cr, pat)
        cairo_save (cr)
        cairo_translate (cr, x + w/2, y + h/2)
        cairo_scale (cr, w/2., h/2.)
        cairo_arc(cr, 0., 0., 1., 0,2*math.pi)
        cairo_fill (cr);
        cairo_restore (cr)
        -- cairo_arc (cr, x, y, w/2, 0, 2 * math.pi)
        -- cairo_fill(cr)
        cairo_pattern_destroy (pat);
        
        cairo_stroke (cr)
        
        cairo_surface_destroy(cs)
        cairo_destroy(cr)    
    end
    
    function fig:imagem(filename,x, y, w, h)
        local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local cr = cairo_create(cs)
        
        local image = cairo_image_surface_create_from_png (filename)
        
        local wi = cairo_image_surface_get_width (image)
        local hi = cairo_image_surface_get_height (image)
        local ar = wi/hi
        -- print(ar)
        --    print(x.."  :  "..y)
        --    cairo_rotate (cr, 45* math.pi/180)
        --    cairo_scale  (cr, w or wi, h or hi)
        --    cairo_translate (cr, x or 0, y or 0)
        --    cairo_translate (cr, -0.5*wi, -0.5*hi)
        
        cairo_translate (cr, (x or 0), (y or 0))
        --    print((x or 0) + w / 2 .." :  " .. (y or 0) + h/2)
        cairo_rotate (cr, 0)
        --    cairo_scale  (cr, 256.0/wi, 256.0/hi)
        --    cairo_scale  (cr, (w or 50)/wi  , (h or 50)/hi)
        cairo_scale  (cr, (w or 50)  ,(w or 50)*ar)
        --    cairo_translate (cr, -0.5*wi, -0.5*hi)
        --    cairo_translate (cr, -0.5*wi, -0.5*hi)
        
        
        cairo_set_source_surface (cr, image, 0, 0)
        cairo_paint (cr)
        cairo_surface_destroy (image); 
        
        cairo_surface_destroy(cs)
        cairo_destroy(cr)        
    end
    
    function fig:drawLine(p1, p2, ln, cl, op)

        local ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
        local ldr = cairo_create(ds)
        cairo_set_line_width (ldr, ln or self.line_width)
        cairo_set_source_rgba (ldr, gc.hex(cl or self.color_default, op or self.opacity))
        -- cairo_user_to_device
        cairo_device_to_user(ldr, 100, 10)
        -- cairo_translate (ldr, p1.x, p1.y)

        cairo_move_to (ldr, p1.x, p1.y)
        cairo_line_to (ldr, p2.x, p2.y)        
        cairo_stroke (ldr)

        cairo_destroy(ldr)
        cairo_surface_destroy(ds) 
    end

    return fig
end

return figure

-- fig.path = path
-- fig.square = square