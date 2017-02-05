--	负载
local Balance = tengine.class("Balance")

function Balance:ctor()
	self.weights = {}
end

function Balance:add(id)
	table.insert(self.weights, {id, 0})
end

--	增加权重
function Balance:inc(id, weight)
	weight = weight or 1

	for i, t in ipairs(self.weights) do
		if t[1] == id then
			t[2]  = t[2] + weight
			return
		end
	end

	-- 没有 就插入
	self:add(id)
end

--	获取权重最小
function Balance:min()
	local min
	local weight = 2015
	for i, t in ipairs(self.weights) do
		if t[2] < weight then
			min = t[1]
			weight = t[2]
		end
	end

	self:inc(min, 1)

	return min or 0
end

--	随机获取
function Balance:random()
	local index = math.random(#self.weights)

	return self.weights[index][1]
end

return Balance