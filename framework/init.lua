-------------------------------------------------------------------------------
-- framework
-------------------------------------------------------------------------------
local _PACKAGE = string.gsub(...,"%.","/") or ""

--- 游戏开始模式
local _start_mode = {
    START_MODE_ALL_READY = 0,
    START_MODE_FULL_READY = 1,
    START_MODE_PAIR_READY = 3,
    START_MODE_TIME_CONTROL = 4,
    START_MODE_MASTER_CONTROL = 5,
}

--- 玩家状态
local _player_status = {
    PLAYER_STATUS_NULL = 0,
    PLAYER_STATUS_FREE = 1,
    PLAYER_STATUS_SITDOWN = 2,
    PLAYER_STATUS_READY = 3,
    PLAYER_STATUS_LOOKON = 4,
    PLAYER_STATUS_PLAYING = 5,
    PLAYER_STATUS_OFFLINE = 6,
}

return {
    start_mode = _start_mode,
    player_status = _player_status,
}