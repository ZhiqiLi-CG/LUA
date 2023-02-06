#include<clua/clua.h>
int example = 2;
cLua* pLua = new cLua;
LuaGlue _SwapExt(lua_State* L) {
	int argNum = 1;
	const char* fileName = pLua->GetStringArgument(argNum++);
	const char* newExt = pLua->GetStringArgument(argNum++);
	char fname[_MAX_FNAME];
	char ext[_MAX_EXT];
	_splitpath(fileName, NULL, NULL, fname, ext);
	std::string sRet = fname;
	if (newExt[0] != '\0') {
		sRet += ".";
		sRet += newExt;
		pLua->PushString(sRet.c_str());
		return 1;
	}
}

int main() {
	if (example == 0) {
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
			if (luaL_loadbuffer(pLuaState, pCommand, strlen(pCommand), NULL) == 0) {
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
	else if (example == 1) {
		puts("LUA COnsole (c) 2004 Chaeles River Media");
		puts("Enter Lua commands at the prompt");
		puts("\"Quit\" to exit \n\n");
		
		pLua->AddFunction("Version", _Version);
		const char* pCommand =GetCommand();
		while (stricmp(pCommand, "QUIT") != 0) {
			if (!pLua->RunString(pCommand)) {
				printf("ERROR:%s\n", pLua->GetErrorString());
			}
			pCommand = GetCommand();
		}
		delete pLua;
	}
	else if (example == 2) {
		puts("LUA COnsole (c) 2004 Chaeles River Media");
		puts("Enter Lua commands at the prompt");
		puts("\"Quit\" to exit \n\n");

		pLua->AddFunction("Version", _Version);
		pLua->AddFunction("SwapExt", _SwapExt);
		const char* pCommand = GetCommand();
		while (stricmp(pCommand, "QUIT") != 0) {
			if (!pLua->RunString(pCommand)) {
				printf("ERROR:%s\n", pLua->GetErrorString());
			}
			pCommand = GetCommand();
		}
		delete pLua;

	}
}