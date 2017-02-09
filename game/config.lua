-------------------------------------------------------------------------------
-- config.lua
-------------------------------------------------------------------------------
--[[
    //游戏房间列表结构
struct tagGameServer
{
	word							wKindID;							//名称索引
	word							wNodeID;							//节点索引
	word							wSortID;							//排序索引
	word							wServerID;							//房间索引
	//WORD                            wServerKind;                        //房间类型
	word							wServerType;						//房间类型
	word							wServerPort;						//房间端口
	SCORE							lCellScore;							//单元积分
	SCORE							lEnterScore;						//进入积分
	dword							dwServerRule;						//房间规则
	dword							dwOnLineCount;						//在线人数
	dword							dwAndroidCount;						//机器人数
	dword							dwFullCount;						//满员人数
	char							szServerAddr[32];					//房间名称
	char							szServerName[LEN_SERVER];			//房间名称
};
]]
return {
	kind = 302,

}