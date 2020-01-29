 #include <cairo.h>

 int main (int argc, char *argv[])
 {
        cairo_surface_t *surface;
        cairo_t *cr;
        int w, h;
        cairo_surface_t *image;

        surface = cairo_image_surface_create (CAIRO_FORMAT_ARGB32, 256, 256);
        cr = cairo_create (surface);

        double M_PI=3.14;

        image = cairo_image_surface_create_from_png ("grid.png");
        w = cairo_image_surface_get_width (image);
        h = cairo_image_surface_get_height (image);

        cairo_translate (cr, 128.0, 128.0);
        cairo_rotate (cr, 20* M_PI/180);
        cairo_scale  (cr, 256.0/w, 256.0/h);
        cairo_translate (cr, -0.5*w, -0.5*h);

        cairo_set_source_surface (cr, image, 0, 0);
        cairo_paint (cr);

        cairo_surface_destroy (image);

        cairo_destroy (cr);
        cairo_surface_write_to_png (surface, "output.png");
        cairo_surface_destroy (surface);

        return 0;
 }

/* int i, j;
unsigned char *data = cairo_image_surface_get_data (surf);
int width = cairo_image_get_width(surf);
int height = cairo_image_get_height(surf);
int stride = cairo_image_get_stride(surf);
for (i = 0; i < height; i++) {
    unsigned char *row = data + i * stride;
    for (int j = 0; j < width; j++) {
       // do something with the pixel at (i, j), which lies at row +
        j * (pixel size),
       // based on the result of cairo_image_get_format and platform endian-ness
    }
} */