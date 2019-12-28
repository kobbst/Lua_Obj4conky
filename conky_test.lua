-- This script draws history graphs.

require 'cairo'

function conky_main ()
	if conky_window == nil then return end
	local cs = cairo_xlib_surface_create (conky_window.display,
		conky_window.drawable, conky_window.visual, conky_window.width,
				conky_window.height)
	cr = cairo_create (cs)


	cairo_set_line_width (cr, 0.1);
	cairo_set_source_rgb (cr, 0, 0, 0);
	cairo_rectangle (cr, 0.25, 0.25, 0.5, 0.5);
	cairo_stroke (cr);



	cairo_destroy (cr)
	cairo_surface_destroy (cs)
	cr = nil
end

function draw_graph (data, table_length)
    for i = 1, table_length do
		print (data[i])
    end
end