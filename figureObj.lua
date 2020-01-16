
require 'cairo'

local figureObj = {}

local gc = require("getColor")
local fn = require("auxFunctions")
local class = require('middleclass')

local Figure = class('Figure')

function Figure:initialize( ... )
    local op = { ... }
    -- x, y, ln, cl, op
    self.x = (op.x or op[1] or 0);  
    self.y = (op.y or op[2] or 0)
    self.line_width = op.ln or op[3] or 2 
    self.color_default = op.cl or op[4] or 'ffffff'
    self.__opacity = op.op or op[5] or 1.
    self.__cr = cairo_create(ds) or nil
    self.__fill = false
    self:applyDefs()
end
function Figure:fill(value_fill) -- setter height
    if value_fill then self.__fill = value_fill end
    return self.__fill
end
function Figure:opacity(value_opacity) -- setter line_width
    if value_opacity then self.__opacity = value_opacity end
    return self.__opacity
end
function Figure:color(color) -- setter line_width
    if color then self.color_default = color end
    return self.color_default
end
function Figure:lineWidth(ln) -- setter line_width
    if ln then self.line_width = ln end
    return self.line_width
end
function Figure:xy(x, y) -- setter x and y
    if x then self.x = x end
    if y then self.y = y end
    return self.x, self.y
end

function Figure:applyDefs( ... )
    cairo_set_line_width (self.__cr, self.line_width)
    -- cairo_set_source_rgba (self.__cr, 1, 1, 1,0.3)
    cairo_set_source_rgba (self.__cr, gc.hex(self.color_default, self.__opacity))    
end

return Figure