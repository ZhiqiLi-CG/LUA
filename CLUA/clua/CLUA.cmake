set(CLUA_DIR ${CMAKE_CURRENT_LIST_DIR})
get_filename_component(CLUA_INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/../ ABSOLUTE)
set(LUA_DIR "${CLUA_DIR}/../../lua-5.4.4/src")
set(CLUA_INCLUDE_DIRS
	${LUA_DIR}
	${CLUA_INCLUDE_DIR}
	${PROJECT_BINARY_DIR})
	
macro(Set_CLUA_Env)
	message(STATUS "now, temp env")
endmacro()

macro(CLUA_Deps project_name)
	set(CMAKE_CXX_STANDARD 17)
	link_directories(${CLUA_DIR}/../deps/lib/win64)	
	link_directories(${CLUA_DIR}/../../lua-5.4.4/lib/win64)	
	
	if(NOT EXISTS ${CLUA_DIR}/../deps/inc)
		message(FATAL_ERROR "deps not found")
	else()
		message(STATUS "CLUADeps found")
		include_directories(${CLUA_DIR}/../deps/inc)
		if(${MSVC}) 
			set(BIN_PATH 
			"${CLUA_DIR}/../deps/bin/win64;${CLUA_DIR}/../deps/bin/win32;${CLUA_DIR}/../../lua-5.4.4/src")
		endif()
	endif()
	if(${MSVC})
		link_directories(${CLUA_DIR}/../deps/lib/win64)
		# we already included OpenGL, so don't need to do anything more
	else()
	
	endif()
endmacro()

	
