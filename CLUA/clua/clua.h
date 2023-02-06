#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<string>
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

struct lua_State;
#define LuaGlue extern "C" int

extern "C" {
	typedef int (*LuaFunctionType)(struct lua_State* pLuaState);
};

class cLua {
public:
	cLua();
	virtual ~cLua();
	bool  RunScript(const char* pFilename);
	bool  RunString(const char* pCommand);
	const char* GetErrorString(void);
	bool AddFunction(const char* pFunctionName, LuaFunctionType pFUnction);
	const char* GetStringArgument(int num, const char* pDefault = NULL);
	double GetNumberArgument(int num, double dDefault = 0.0);
	void PushString(const char* pString);
	void PushNumber(double value);
private:
	lua_State* m_pScriptContext;
	void(*m_pErrorHandler)(const char* pError);
};

cLua::cLua()
{
	m_pErrorHandler = NULL;

	m_pScriptContext = luaL_newstate();
	luaopen_base(m_pScriptContext);
	luaopen_io(m_pScriptContext);
	luaopen_string(m_pScriptContext);
	luaopen_math(m_pScriptContext);
	luaopen_debug(m_pScriptContext);
	luaopen_table(m_pScriptContext);
}

cLua::~cLua()
{
	if (m_pScriptContext)
		lua_close(m_pScriptContext);
}

static std::string findScript(const char* pFname)
{
	FILE* fTest;

	char drive[_MAX_DRIVE];
	char dir[_MAX_DIR];
	char fname[_MAX_FNAME];
	char ext[_MAX_EXT];

	_splitpath(pFname, drive, dir, fname, ext);

	std::string strTestFile = (std::string)drive + dir + "Scripts\\" + fname + ".LUB";
	fTest = fopen(strTestFile.c_str(), "r");
	if (fTest == NULL)
	{
		//not that one...
		strTestFile = (std::string)drive + dir + "Scripts\\" + fname + ".LUA";
		fTest = fopen(strTestFile.c_str(), "r");
	}

	if (fTest == NULL)
	{
		//not that one...
		strTestFile = (std::string)drive + dir + fname + ".LUB";
		fTest = fopen(strTestFile.c_str(), "r");
	}

	if (fTest == NULL)
	{
		//not that one...
		//not that one...
		strTestFile = (std::string)drive + dir + fname + ".LUA";
		fTest = fopen(strTestFile.c_str(), "r");
	}

	if (fTest != NULL)
	{
		fclose(fTest);
	}

	return strTestFile;
}

bool cLua::RunScript(const char* pFname)
{
	std::string strFilename = findScript(pFname);
	const char* pFilename = strFilename.c_str();

	if (0 != luaL_loadfile(m_pScriptContext, pFilename))
	{
		if (m_pErrorHandler)
		{
			char buf[256];
			sprintf(buf, "Lua Error - Script Load\nScript Name:%s\nError Message:%s\n", pFilename, luaL_checkstring(m_pScriptContext, -1));
			m_pErrorHandler(buf);
		}

		return false;
	}
	if (0 != lua_pcall(m_pScriptContext, 0, LUA_MULTRET, 0))
	{
		if (m_pErrorHandler)
		{
			char buf[256];
			sprintf(buf, "Lua Error - Script Run\nScript Name:%s\nError Message:%s\n", pFilename, luaL_checkstring(m_pScriptContext, -1));
			m_pErrorHandler(buf);
		}

		return false;
	}
	return true;

}

bool cLua::RunString(const char* pCommand)
{
	if (0 != luaL_loadbuffer(m_pScriptContext, pCommand, strlen(pCommand), NULL))
	{
		if (m_pErrorHandler)
		{
			char buf[256];
			sprintf(buf, "Lua Error - String Load\nString:%s\nError Message:%s\n", pCommand, luaL_checkstring(m_pScriptContext, -1));
			m_pErrorHandler(buf);
		}

		return false;
	}
	if (0 != lua_pcall(m_pScriptContext, 0, LUA_MULTRET, 0))
	{
		if (m_pErrorHandler)
		{
			char buf[256];
			sprintf(buf, "Lua Error - String Run\nString:%s\nError Message:%s\n", pCommand, luaL_checkstring(m_pScriptContext, -1));
			m_pErrorHandler(buf);
		}

		return false;
	}
	return true;
}

const char* cLua::GetErrorString(void)
{
	return luaL_checkstring(m_pScriptContext, -1);
}

bool cLua::AddFunction(const char* pFunctionName, LuaFunctionType pFunction)
{
	lua_register(m_pScriptContext, pFunctionName, pFunction);
	return true;
}

const char* cLua::GetStringArgument(int num, const char* pDefault)
{
	return luaL_optstring(m_pScriptContext, num, pDefault);

}

double cLua::GetNumberArgument(int num, double dDefault)
{
	return luaL_optnumber(m_pScriptContext, num, dDefault);
}

void cLua::PushString(const char* pString)
{
	lua_pushstring(m_pScriptContext, pString);
}

void cLua::PushNumber(double value)
{
	lua_pushnumber(m_pScriptContext, value);
}


