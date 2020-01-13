
local class = require('middleclass')

local R = {}

Person = class('Person') --this is the same as class('Person', Object) or Object:subclass('Person')
function Person:initialize(name)
  self.name = name
end
function Person:speak()
  print('Hi, I am ' .. self.name ..'.')
end

AgedPerson = class('AgedPerson', Person) -- or Person:subclass('AgedPerson')
AgedPerson.static.ADULT_AGE = 18 --this is a class variable
function AgedPerson:initialize(name, age)
  Person.initialize(self, name) -- this calls the parent's constructor (Person.initialize) on self
  self.age = age
end
function AgedPerson:grow( age )
  self.age = age
  self:speak()
end
function AgedPerson:speak()
  Person.speak(self) -- prints "Hi, I am xx."
  if(self.age < AgedPerson.ADULT_AGE) then --accessing a class variable from an instance method
    print('I am underaged.')
  else
    print('I am an adult.')
  end
end

-- local p1 = AgedPerson:new('Billy the Kid', 13) -- this is equivalent to AgedPerson('Billy the Kid', 13) - the :new part is implicit
-- local p2 = AgedPerson:new('Luke Skywalker', 21)
-- p1:speak()
-- p2:speak()
-- p1:grow(22)

R.Person = Person
R.AgedPerson = AgedPerson

return R

--[[

--===================================================
local Conta = class('Conta')

function Conta:initialize(conta, titular, saldo, limite)
    self.__conta = conta or nil
    self.__titular = titular or nil
    self.__saldo = saldo or nil
    self.__limite = limite or nil
end
function Conta:conta(conta)
    if conta then self.__conta = conta end
    return self.__conta
end
function Conta:titular(titular)
    if titular then self.__titular = titular end
    return self.__titular
end
function Conta:saldo(saldo)
    if saldo then self.__saldo = saldo end
    return self.__saldo
end
function Conta:limite(limite)
    if limite then self.__limite = limite end
    return self.__limite
end

function Conta:extrato( ... )
    print('\nNUM CONTA:\t' .. self.__conta)
    print('TITULAR:\t' .. self.__titular)
    print('SALDO:\t R$' .. self.__saldo)
    print('LIMITE:\tR$' .. self.__limite)
end

local ac1 = Conta:new(001, "Carl", 123.00, 5000.00)
ac1:extrato()

--======================================================

-- mt = {texto=""}
-- -- mt.__index = mt

-- function mt:new(o,texto)
--     o = o or {}
--     setmetatable(o, self)
--     self.__index = self
--     self.texto = texto
--     -- texto = texto or "!"
--     return o
-- end
-- function mt:soma()
--     local s = 0
--     -- table.foreachi(self, function (i, e)
--     --     if type(e) == "number" then
--     --         s = s + e
--     --     end
--     -- end)
--     return self.texto
-- end

-- nmt = mt:new()

-- function nmt:produto()
--     local p = 1
--     table.foreachi(self, function (i, e)
--         if type(e) == "number" then
--             p = p * e
--         end
--     end)
--     return p
-- end

-- var = nmt:new { 2, 4, 6 }
-- print(var:soma(), var:produto())

Conta = function(conta, titular, saldo, limite)
    local init = {
      __conta = conta or nil,
      __titular = titular or nil,
      __saldo = saldo or nil,
      __limite = limite or nil,
    }
    local meta = {
      __index = init,
      __call = function(self) return self.conta end
    }
    
    return setmetatable({},meta)
  end

local ac1 = Conta()
local ac2 = Conta(001)

print(ac1)
print(ac2)
]]