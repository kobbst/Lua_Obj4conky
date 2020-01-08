mt = {texto=""}
-- mt.__index = mt

function mt:new(o,texto)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.texto = texto
    -- texto = texto or "!"
    return o
end
function mt:soma()
    local s = 0
    -- table.foreachi(self, function (i, e)
    --     if type(e) == "number" then
    --         s = s + e
    --     end
    -- end)
    return self.texto
end

nmt = mt:new()

function nmt:produto()
    local p = 1
    table.foreachi(self, function (i, e)
        if type(e) == "number" then
            p = p * e
        end
    end)
    return p
end

var = nmt:new { 2, 4, 6 }
print(var:soma(), var:produto())




