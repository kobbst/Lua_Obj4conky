


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
function Scale:pointsMark(start_angle, end_angle, inter_angle )
    local points = {}
    local delta = end_angle - start_angle
    local index = 1
    local ang_arc = delta / inter_angle
    for i= start_angle , end_angle, ang_arc do
        points[index] = {x = math.sin(i), y = math.cos( i )}
        index = index + 1
    end

    return points

end

return Scale
