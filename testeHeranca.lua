

local cl = require("maisteste")
local rt = require("rectangle")

local v1 = rt.Rectangle:new()
-- local v2 = roundedRectangle({x=80,y=280})
local v2 = rt.roundedRectangle:new(20,288)
v1:xy(50, 160)
-- v2:xy(60, 250)

print(v1:xy())
print(v2:xy())
print(v2:radiusEdge())
print(v1:xy())



--[[
-- Meta class
Shape = {area = 0}
-- 基础类方法 new
function Shape:new (o,side)
  o = o or {}
  setmetatable(o, self)
  self.__index = selfPerson
  side = side or 0
  self.area = side*side
  return o
end
-- 基础类方法 printArea
function Shape:printArea ()
  print("A área é",self.area)
end

-- 创建对象  ===========================

--===================================================================

myshape = Shape:new(nil,5)
myshape:printArea()
--===================================================================
--===================================================================


Square = Shape:new()
-- 派生类方法 new
function Square:new (o,side)
  o = o or Shape:new(o,side)
  setmetatable(o, self)
  self.__index = self
  return o
end

-- 派生类方法 printArea
function Square:printArea ()
  print("A área quadrada é ",self.area)
end

-- 创建对象  ===================
--===================================================================

mysquare = Square:new(nil,15)
mysquare:printArea()

--===================================================================
--===================================================================

Rectangle = Shape:new()
-- 派生类方法 new
function Rectangle:new (o,length,breadth)
  o = o or Shape:new(o)
  setmetatable(o, self)
  self.__index = self
  self.area = length * breadth
  return o
end

-- 派生类方法 printArea
function Rectangle:printArea (...)

  local arg = {...}
  -- print(#arg)
  print("A área do retângulo é ",self.area)
end

-- local p1 = {x=2,y=3}
-- local p2 = {x=2,y=3}
-- local p3 = {x= p1.x + p2.x, y= p1.y + p2.y}
-- print (p3.x .. ":" .. p3.y)

-- 创建对象
myrectangle = Rectangle:new(nil,10,20)
myrectangle:printArea()
--===================================================================
--===================================================================

print("====-=-=-=-=-=-=-=-=-=-=-=-=-===========")

myshape:printArea()
mysquare:printArea()
myrectangle:printArea()



local p1 = cl.AgedPerson:new('Billy the Kid', 13) -- this is equivalent to AgedPerson('Billy the Kid', 13) - the :new part is implicit
local p2 = cl.AgedPerson:new('Luke Skywalker', 21)
p1:speak()
p2:speak()
p1:grow(22)










]]