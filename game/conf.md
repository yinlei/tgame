##配置说明

游戏配置: 该配置每个游戏的服务都一样的 这个配置从具体游戏那边过来
    参考
    //服务属性
    struct tagGameServiceAttrib
    {
        //内核属性
        WORD							wKindID;							//名称号码
        WORD							wChairCount;						//椅子数目
        WORD							wSupporType;						//支持类型
        TCHAR							szGameName[LEN_KIND];				//游戏名字

        //功能标志
        BYTE							cbAndroidUser;						//机器标志
        BYTE							cbDynamicJoin;						//动态加入
        BYTE							cbOffLineTrustee;					//断线代打

        //服务属性
        DWORD							dwServerVersion;					//游戏版本
        DWORD							dwClientVersion;					//游戏版本
        TCHAR							szDataBaseName[32];					//游戏库名
        TCHAR							szServerDLLName[LEN_PROCESS];		//进程名字
        TCHAR							szClientEXEName[LEN_PROCESS];		//进程名字
    };

    local gameconf = {
        -- 游戏类型
        type = 302,
        -- 游戏名字
        name = '血战麻将',
        -- 椅子数目
        chair = 4,
        -- 游戏版本
        version = '0.1',
        -- 服务名
        service = 'xuezhan'
    }

游戏选项: 可以同一个游戏的不同服配置不同的选项，这个配置动态过来
    参考
    //服务配置
    struct tagGameServiceOption
    {
        //挂接属性
        WORD							wKindID;							//挂接类型
        WORD							wNodeID;							//挂接节点
        WORD							wSortID;							//排列标识
        WORD							wServerID;							//房间标识

        //税收配置
        LONG							lCellScore;							//单位积分
        WORD							wRevenueRatio;						//税收比例
        SCORE							lServiceScore;						//服务费用

        //房间配置
        SCORE							lRestrictScore;						//限制积分
        SCORE							lMinTableScore;						//最低积分
        SCORE							lMinEnterScore;						//最低积分
        SCORE							lMaxEnterScore;						//最高积分

        //会员限制
        BYTE							cbMinEnterMember;					//最低会员
        BYTE							cbMaxEnterMember;					//最高会员

        //房间配置
        DWORD							dwServerRule;						//房间规则
        DWORD							dwAttachUserRight;					//附加权限

        //房间属性
        WORD							wMaxPlayer;							//最大数目
        WORD							wTableCount;						//桌子数目
        WORD							wServerPort;						//服务端口
        WORD							wServerType;						//房间类型
        TCHAR							szServerName[LEN_SERVER];			//房间名称

        //分组设置
        BYTE							cbDistributeRule;					//分组规则
        WORD							wMinDistributeUser;					//最少人数
        WORD							wMaxDistributeUser;					//最多人数
        WORD							wDistributeTimeSpace;				//分组间隔
        WORD							wDistributeDrawCount;				//分组局数
        WORD							wDistributeStartDelay;				//开始延时

        //连接设置
        TCHAR							szDataBaseAddr[16];					//连接地址
        TCHAR							szDataBaseName[32];					//数据库名

        //自定规则
        BYTE							cbCustomRule[1024];					//自定规则
    };

    local gameoption = {
        
    }