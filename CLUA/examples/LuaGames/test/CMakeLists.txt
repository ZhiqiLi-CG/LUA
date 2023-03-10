# Set project_name as the directory name
message(STATUS "test example ${example}")
file(RELATIVE_PATH project_name ${CMAKE_CURRENT_LIST_DIR}/.. ${CMAKE_CURRENT_LIST_DIR})
file(RELATIVE_PATH folder_name ${CMAKE_CURRENT_LIST_DIR}/../.. ${CMAKE_CURRENT_LIST_DIR}/..)
###############################################
# Include deps
###############################################
include(${CMAKE_CURRENT_LIST_DIR}/../../../clua/CLUA.cmake)
CLUA_Deps(${project_name})
###############################################
# Add the project 
###############################################
project(${project_name} LANGUAGES CXX CUDA)
include_directories(${CMAKE_CURRENT_LIST_DIR})
if(CUDA_ENABLE)
	file(GLOB  SOURCES
		"./*.h"
		"./*.cpp"
		"./*.cu"
	)
else()
	file(GLOB  SOURCES
		"./*.h"
		"./*.cpp"
	)
endif()

add_executable(${project_name} ${SOURCES})
###############################################
# Add .user file for Visual Studio to add bin to path
###############################################
message(STATUS "NOTE::::::::${BIN_PATH}")

if(${MSVC}) 
	configure_file(
		"${CLUA_ROOT_DIR}/examples/vs_tmp.vcxproj.user.in" 
		"${PROJECT_BINARY_DIR}/${example}.vcxproj.user"
		@ONLY)
	message(STATUS "created: ${PROJECT_BINARY_DIR}/${example}.vcxproj.user")
endif()

###############################################
# Add this project to corresponding folder
###############################################
set_target_properties(${project_name} PROPERTIES FOLDER ${folder_name})
message(STATUS "added project: ${folder_name}/${project_name}")
