--------------------------------------------------------------------------------
-- account.lua
--------------------------------------------------------------------------------

local store = require("lib.store")

return store.model("Account", {
	attributes = {
		"account", 		-- 账号
		'password',		-- 登录密码
		"name",			-- 昵称
		'gender',		-- 性别
		'face',			-- 头像
		'game',			-- 游戏标志
		'group',		-- 社团
		'groupname',	-- 社团名字
		'custom',		-- 自定义

		'lock',			-- 锁定机器
		'sign',			-- 签名

		'viplevel',		-- 会员等级
		'expire',		-- 会员到期时间

		'exp',		-- 经验

		"score",	-- 分数
	},

	indices = {
		"account"
	},

	uniques = {
		"account"
	},

	tracked = {
	}
})