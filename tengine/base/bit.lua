
if jit then
	local bit = require("bit")
	return {
		bnot = bit.bnot,
		band = bit.band,
		bor = bit.bor,
		bxor = bit.bxor,
		lshift = bit.lshift,
		rshift = bit.rshift,
		rol = bit.rol,
	}
else
    return {
        bnot = function(a)
            return ~a
        end,

        band = function(a, b)
            return a & b
        end,

        bor = function(a, b)
            return a | b
        end,

        bxor = function(a, b)
        end,

        lshift = function(a, b)
            return a << b
        end,

        rshift = function(a, b)
            return a >> b
        end,

        rol = function()
        end
    }
end
