
require 'cairo'

local fe = require("figures")
-- fg = require("figuras")
-- require("settings")




-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_main()
    if conky_window == nil then 
        return
    end
    -- print("ok...")
    -- ds = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    -- dr = cairo_create(ds)
    local fe1 = fe.new()
    local fe2 = fe.new()
    local fe3 = fe.new()
    local fe4 = fe.new()

    fe1:retangulo(25, 50 ,25 ,10)
    fe2:retangulo(25, 75 ,30 ,10)
    fe3:circulo(20, 150 ,100 ,100)
    fe3:circulo(20, 150 ,110 ,110)
    -- fe3:circuloGradiente(15 ,250 , 100, 50)
    -- fe3:imagem("/home/kobb/Imagens/wwoman01.png",0, 410,100,100)


    fe4:circulo(15 ,250 , 10, 50)
    fe4:circulo(25 ,250 , 10, 50)
    fe4:circulo(35 ,250 , 10, 50)
    fe4:circulo(45 ,250 , 10, 50)
    fe4:circulo(55 ,250 , 10, 50, 2, "aa000f",0.5)
    fe4:retangulo(15 ,250 , 100, 50,1,"220000",0.3)


    -- cairo_surface_destroy(ds)
    -- cairo_destroy(dr)
end

