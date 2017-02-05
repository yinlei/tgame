-------------------------------------------------------------------------------
-- ser.lua
-------------------------------------------------------------------------------
local string_unpack = string.unpack
local string_pack = string.pack

local _M = {}

function _M.begin(self, data, size)
    self.data = data
    self.size = size
    self.pos = 1
end

function _M.begin_write(self)
    self.buff = ""
end

function _M.read_int8(self)
    if self.pos >= self.size then
        return 0
    end

    local value, pos = string_unpack('>b', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_int8(self, value)
    self.buff = self.buff .. string_pack('>b', value)
    return self
end

function _M.read_uint8(self)
    if self.pos >= self.size then
        return 0
    end

    local value, pos = string_unpack('>B', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_uint8(self, value)
    self.buff = self.buff .. string_pack('>B', value)
    return self
end

function _M.read_int16(self)
    if self.pos >= self.size then
        return 0
    end
    local value, pos = string_unpack('>h', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_int16(self, value)
    self.buff = self.buff .. string_pack('>h', value)
    return self
end

function _M.read_uint16(self)
    if self.pos >= self.size then
        return 0
    end
    local value , pos = string_unpack('>H', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_uint16(self, value)
    self.buff = self.buff .. string_pack('>H', value)
    return self
end

function _M.read_int32(self)
    if self.pos >= self.size then
        return 0
    end
    local value, pos = string_unpack('>i', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_int32(self, value)
    self.buff = self.buff .. string_pack('>i', value)
    return self
end

function _M.read_uint32(self)
    if self.pos >= self.size then
        return 0
    end
    local value, pos = string_unpack('>I', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_uint32(self, value)
    self.buff = self.buff .. string_pack('>I', value)
    return self
end

function _M.read_int64(self)
    if self.pos >= self.size then
        return 0
    end
    local value, pos = string_unpack('>j', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_int64(self, value)
    self.buff = self.buff .. string_pack('>j', value)
    return self
end

function _M.read_uint64(self)
    if self.pos >= self.size then
        return 0
    end
    local value, pos = string_unpack('>J', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_uint64(self, value)
    self.buff = self.buff .. string_pack('>J', value)
    return self
end

function _M.read_float(self)
    if self.pos >= self.size then
        return 0
    end
    local value, pos = string_unpack('>f', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_float(self, value)
    self.buff = self.buff .. string_pack('>f', value)
    return self
end

function _M.read_double(self)
    if self.pos >= self.size then
        return 0
    end
    local value, pos = string_unpack('>d', self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_double(self, value)
    self.buff = self.buff .. string_pack('>d', value)
    return self
end

function _M.read_string(self)
    local size = self:read_uint16(self)

    if size == 0 then return "" end

    local value, pos = string_unpack(string.format('>c%d', size),
        self.data, self.pos)
    self.pos = pos
    return value
end

function _M.write_string(self, value)
    local len = string.len(value)
    self:write_uint16(len)
    self.buff = self.buff .. string_pack(string.format('>c%d', len), value)
    return self
end

function _M.over(self)
    self.data = nil
    self.size = 0
    self.pos = 0
end

function _M.over_write(self)
    return self.buff
end

return _M
