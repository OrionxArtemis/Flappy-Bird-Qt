# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appflappyBird_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appflappyBird_autogen.dir\\ParseCache.txt"
  "appflappyBird_autogen"
  )
endif()
