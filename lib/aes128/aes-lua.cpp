#ifdef __cplusplus
extern "C" {
#endif

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#ifdef __cplusplus
}
#endif

#include "aes.hpp"

#define AES_ENCRYPT_KEY_SIZE        128
#define AES_ENCRYPT_BLOCK_SIZE      160
typedef struct aes_encrypt<AES_ENCRYPT_KEY_SIZE, AES_ENCRYPT_BLOCK_SIZE> aes_encrypt128;

struct aes {
	aes_encrypt128* imp;
};

static int _encrypt(lua_State *L)
{
	luaL_checktype(L, 1, LUA_TUSERDATA);

	struct aes *my = (struct aes*)lua_touserdata(L, 1);
	
	return 1;
}

static int _decrypt(lua_State *L)
{
	luaL_checktype(L, 1, LUA_TUSERDATA);

	struct aes *my = (struct aes*)lua_touserdata(L, 1);

	return 1;
}

static int _gc(lua_State *L)
{
	luaL_checktype(L, 1, LUA_TUSERDATA);

	struct aes *my = (struct aes*)lua_touserdata(L, 1);

	if (my)
	{
		delete my->imp;
		my->imp = 0;
	}
	
	return 1;
}

static int _aes(lua_State *L)
{
	struct aes *my = (struct aes*)lua_newuserdata(L, sizeof(*my));

	my->imp = new aes_encrypt128();

	std::size_t len;
	const char* key = lua_tolstring(L, 1, &len);
	if (key)
	{
		my->imp->set_key(key, len);
	}

	if (luaL_newmetatable(L, "aes128")) {
		luaL_Reg l[] = {
			{ "encrypt", _encrypt },
			{ "decrypt", _decrypt },
			{ "__gc", _gc },
			{ NULL, NULL },
		};
		luaL_newlib(L, l);
		lua_setfield(L, -2, "__index");
		lua_pushcfunction(L, _gc);
		lua_setfield(L, -2, "__gc");
	}

	lua_setmetatable(L, -2);

	lua_pop(L, 1);

	return 1;
}

typedef union
{
	unsigned long long id;
	struct
	{
		// 序号
		unsigned int no_player_index;
		// 类型
		unsigned int type_id:8;
		// 地图id
		unsigned int map_id:16;
		// 服务器id
		unsigned int server_id:8;
	};
} global_type;

static int _global_id(lua_State* L) {

	global_type temp;
	temp.no_player_index = luaL_checkinteger(L, 1);
	temp.type_id = luaL_checkinteger(L, 2);
	temp.map_id = luaL_checkinteger(L, 3);
	temp.server_id = luaL_checkinteger(L, 4);

	lua_pushinteger(L, temp.id);
	return 1;
}

extern "C" {
	LUALIB_API int luaopen_aes128(lua_State* L) {
    luaL_Reg reg[] = {
        {"new", _aes},
		{"global_id", _global_id},
        {NULL, NULL},
    };

    luaL_checkversion(L);
    luaL_newlib(L, reg);

	return 1;
}
}
