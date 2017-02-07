--------------------------------------------------------------------------------
-- proto.lua
--------------------------------------------------------------------------------
local ERROR_MSG = tengine.ERROR_MSG

local parser = require "framework.parser"

local _M = {}

local succ = parser.register("protocol.proto","framework/")

if not succ then
end

function _M.register(filename)
	local file, ret = io.open(filename,"rb")

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
		type = name,
		name = 'tgame.' .. name,
		data = protobuf.encode(name, message)
	}

	return protobuf.encode("tgame.Packet", packet)
end

function _M.decode(data, len)
	local packet, err = protobuf.decode("tgame.Packet" , data, len)
	if not packet then
        ERROR_MSG("proto decode data err: %s ", err)
		return err, nil, nil, nil
	end

	local message, err = protobuf.decode(packet.name, packet.data)
	if err then
		return err, nil, nil, nil
	end

	return nil, ret.type, ret.name, message
end

return _M
