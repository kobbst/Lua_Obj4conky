//gcc -o cairo cairo.c $(pkg-config --cflags --libs cairo)
 
#include <cairo.h>
#include <stdlib.h>
 
#define ROWS 400
#define COLS 300
 
typedef unsigned char uchar;
 
int main (int argc, char *argv[])
{
    // cairo_format_t format = CAIRO_FORMAT_RGB24;
    cairo_format_t format = CAIRO_FORMAT_ARGB32;
    int stride = cairo_format_stride_for_width(format, COLS);
    uchar *pix = calloc(stride * ROWS, 1);
 
    for (int r = 0; r < ROWS; r++)
        for (int c = 0; c < COLS; c++)
            if (r / 20 % 2 && c / 20 % 2) {
                uchar *p = &pix[r*stride + c*4];
                p[0] = p[1] = p[2] = 255;
                p[3] = 155;

                // p[3] is the alpha, which is unused with RGB24
            }
 
    cairo_surface_t *surface =
        cairo_image_surface_create_for_data(
            pix, format, COLS, ROWS, stride);
 
    cairo_surface_write_to_png (surface, "grid.png");
    cairo_surface_destroy (surface);
    free(pix);
    return 0;
}