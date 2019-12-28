require 'cairo'

local hexagon = {}

function hexagon.new(cs)
    local hex = {x = 0, y = 0, width = 50, height = 50,
                x1 = 2.5, y1 = 0.66, x2 = 7.5, y2 = 0.66, x3 = 10.0, y3 = 5.0,
                x4 = 7.5, y4 = 9.33, x5 = 2.5, y5 = 9.33, x6 = 0.0, y6 = 5.0,
                line_width = 1, color_default = 'ffffff', opacity = 1.
                }
function hex.draw()
    cairo_save (cr)
    cairo_translate (cr, x + w/2, y + h/2)
    cairo_scale (cr, w/2., h/2.)
    cairo_arc(cr, 0., 0., 1., 0,2*math.pi)
    cairo_move_to (dr, x1, y1)
    cairo_line_to (dr, x2, y2)
    cairo_rel_line_to (dr, x2+100, y2-450)
    
    -- cairo_fill(cr)
    cairo_restore (cr)
    
    cairo_stroke (cr)
end


end

