#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#ifdef _DEBUG
	#pragma comment(lib, "LuaLibd.lib") 
#else
	#pragma comment(lib, "LuaLib.lib") 
#endif // DEBUG


/**
* Include the Lua header. Note that
*  they are "C" type not C++
*/
extern "C" {
	#include<lua.h>
	#include<lualib.h>
	#include<lauxlib.h>
}

extern "C" int _Version(lua_State * L) {
	puts("This is version 1.0 of the console program");
	puts(LUA_VERSION);
	puts(LUA_COPYRIGHT);
	puts(LUA_AUTHORS);
	return 0;
}

static luaL_Reg ConsoleGlue[] = {
	{"Version", _Version},
	{NULL,NULL}
};

char gpCommandBuffer[254];
const char* GetCommand(void) {
	printf("Ready> ");
	return gets_s(gpCommandBuffer);
	puts("\n");
}