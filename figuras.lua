
-- require 'cairo'

local figura = {}

function figura:new()
        nova = {nome = "figura"}

    function nova:square()
        return {
            desenhar = function(self)
                return "square"
            end
        }
    end

    function nova:circulo()
        return {
                mensagem = "circulo",
                desenhar = function()
                    return "circulo"
                end
            }     
    end
    return nova
end

return figura