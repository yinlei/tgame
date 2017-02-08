--------------------------------------------------------------------------------
-- protocol.lua
--------------------------------------------------------------------------------
local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""

local ERROR_MSG = tengine.ERROR_MSG

local p = tengine.p

local parser = require(_PACKAGE .. '/parser')
local protobuf = require(_PACKAGE .. '/protobuf')

local _M = {}

function _M.registerproto(filename, path)
	return parser.register(filename, path)
end

function _M.register(filename, path)
	local file, ret = io.open(path .. filename,"rb")

	if not file then
		ERROR_MSG("proto register file error: %s", ret)
		return
	end

	local buffer = file:read "*a"
	file:close()

	protobuf.register(buffer)
end

function _M.encode(name, message)
	local packet = {
		--type = name,
		name = name,
		data = protobuf.encode('tgame.' .. name, message)
	}
	return protobuf.encode("tgame.Packet", packet)
end

function _M.decode(data, len)
	local packet, err = protobuf.decode("tgame.Packet" , data, len)
	if not packet then
        ERROR_MSG("proto decode data err: %s ", err)
		return err, nil, nil, nil
	end

	local message, err = protobuf.decode('tgame.'..packet.name, packet.data)
	if err then
		return err, nil, nil, nil
	end

	return nil, packet.type, packet.name, message
end

return _M
