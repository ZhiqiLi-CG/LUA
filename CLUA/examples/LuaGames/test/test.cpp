#include<clua/clua.h>
int main() {
	lua_State* pLuaState = luaL_newstate();
	luaopen_base(pLuaState);
	luaopen_io(pLuaState);
	luaopen_string(pLuaState);
	luaopen_math(pLuaState);
	for (int i = 0; ConsoleGlue[i].name; i++) {
		lua_register(
			pLuaState,
			ConsoleGlue[i].name, 
			ConsoleGlue[i].func
		);
	}
	const char* pCommand = GetCommand();
	while (stricmp(pCommand, "QUIT") != 0) {
		/// send command to the Lua Environment
		if (luaL_loadbuffer(pLuaState, pCommand, strlen(pCommand), NULL)==0) {
			if (!lua_pcall(pLuaState, 0, LUA_MULTRET, 0)) {
				// error on running the command
				printf("ERROR:%s\n", luaL_checkstring(pLuaState, -1));
			}
		}
		else {
			/// error load the command
			printf("ERROR:%s\n", luaL_checkstring(pLuaState, -1));
		}
		pCommand = GetCommand();
	}
	lua_close(pLuaState);
}