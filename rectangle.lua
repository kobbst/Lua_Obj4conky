

local gc = require("getColor")
local fn = require("auxFunctions")

local rectangle = {}

function rectangle.new(width)
    local rec = {

        width = width or 1, height =  (width or 1) /(2*math.sqrt(3)),
        line_width = 1, color_default = 'ffffff', opacity = 1.
        
    }

    function rec:drawRounded(cr, a, b, c, d, radius)
        -- body
        --""" draws rectangles with rounded (circular arc) corners """
        -- # an area with coordinates of
        -- # (top, bottom, left, right) edges in absolute coordinates:
        -- local a,b,c,d=area
        cairo_arc(dr, a + radius, c + radius, radius, 2*(math.pi/2), 3*(math.pi/2))
        cairo_arc(dr, b - radius, c + radius, radius, 3*(math.pi/2), 4*(math.pi/2))
        cairo_arc(dr, b - radius, d - radius, radius, 0*(math.pi/2), 1*(math.pi/2)) 
        cairo_arc(dr, a + radius, d - radius, radius, 1*(math.pi/2), 2*(math.pi/2))
        cairo_close_path(dr)
        cairo_stroke(dr)

    end 
    function rec:draw_Rounded_2(x,y,w,h,r)
        -- def roundedrec(self,context,x,y,w,h,r = 10):
        -- "Draw a rounded rectangle"
        -- #   A****BQ
        -- #  H      C
        -- #  *      *
        -- #  G      D
        -- #   F****E

        cairo_move_to(x+r,y)                      -- # Move to A
        cairo_line_to(x+w-r,y)                    -- # Straight line to B
        cairo_curve_to(x+w,y,x+w,y,x+w,y+r)       -- # Curve to C, Control points are both at Q
        cairo_line_to(x+w,y+h-r)                  -- # Move to D
        cairo_curve_to(x+w,y+h,x+w,y+h,x+w-r,y+h) -- # Curve to E
        cairo_line_to(x+r,y+h)                    -- # Line to F
        cairo_curve_to(x,y+h,x,y+h,x,y+h-r)       -- # Curve to G
        cairo_line_to(x,y+r)                      -- # Line to H
        cairo_curve_to(x,y,x,y,x+r,y)             -- # Curve to A

    end

    return rec

end
return rectangle