


local gc = require("getColor")
local fn = require("auxFunctions")
local class = require('middleclass')
local Figure = require("figureObj")

Scale = class('Scale', Figure)

function Scale:initialize( ... )
    Figure.initialize(self, ...)
    local op = { ... }
    -- x, y, ln, cl, op, w, h
    self.__width = op.w or op[6] or 50; 
    self.__height = op.h or op[7] or 50
    self.__interval = op[8] or 1
end
-- ===========  getters/setters ====================
function Scale:width(value_width) -- setter width
    if value_width then self.__width = value_width end
    return self.__width
end
function Scale:height(value_height) -- setter height
    if value_height then self.__height = value_height end
    return self.__height
end

-- ===========  methods ====================
function Scale:pointsMark(start_angle, end_angle, inter_angle, radius )
    local points = {}
    local delta = end_angle - start_angle
    local ang_arc = delta / inter_angle
    local index, raio = 1 , radius or 1
    for i= start_angle , end_angle, ang_arc do
        points[index] = {x = raio * math.sin(i), y = raio * math.cos( i )}
        index = index + 1
    end

    return points

end

return Scale
