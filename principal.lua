
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

    -- print(th1:getElement())
    -- print(hx1:getCenter())
    -- print(th1:getAllvar:d())
    th1:draw(25, 350, 2, "ffffff", 0.3)
    th1:draw(75, 350, 4, "ffff00", 0.5)
    
    hx1:draw(70,20,2, "ffffff", 0.3,90)
    hx1:draw(70,150,1,"22ff00",0.4,10)
    hx1:draw(70,150,1,"22ff00",0.4,20)
    hx1:draw(70,150,1,"22ff00",0.4,30)
    hx1:draw(70,150,1,"22ff00",0.4,40)
    
    -- print(hx1:getPoints().p1.x)
    
    fe1:drawLine(hx1:getPoints().p1,hx1:getPoints().p4 ,2,"ffffaa",0.2)
    -- fe1:drawLine(hx1:getCenter(),{x=60,y=40},2,"ffffaa",0.2)
    

    -- fe1:retangulo(25, 50 ,25 ,10)
    -- fe2:retangulo(25, 75 ,-30 ,10)
    -- fe3:circulo(20, 150 ,100 ,100)
    -- fe3:circulo(20, 150 ,110 ,110)
    -- fe3:circuloGradiente(15 ,250 , 100, 50)
    -- fe3:imagem("/home/kobb/Imagens/wwoman01.png",0, 410,100,100)


    -- fe4:circulo(15 ,250 , 10, 50)
    -- fe4:circulo(25 ,250 , 10, 50)
    -- fe4:circulo(35 ,250 , 10, 50)
    -- fe4:circulo(45 ,250 , 10, 50)
    -- fe4:circulo(55 ,250 , 10, 50, 2, "aa000f",0.5)
    -- fe4:retangulo(15 ,250 , 100, 50,1,"220000",0.3)


    cairo_surface_destroy(ds)
    cairo_destroy(dr)
end

