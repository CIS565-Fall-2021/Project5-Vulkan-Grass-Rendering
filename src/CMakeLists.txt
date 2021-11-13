file(GLOB SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp ${CMAKE_CURRENT_SOURCE_DIR}/*.h)

file(GLOB IMAGES
  ${CMAKE_CURRENT_SOURCE_DIR}/images/*.jpg
  ${CMAKE_CURRENT_SOURCE_DIR}/images/*.png
  ${CMAKE_CURRENT_SOURCE_DIR}/images/*.bmp
)

foreach(IMAGE ${IMAGES})
  get_filename_component(fname ${IMAGE} NAME)
  if(WIN32)
    configure_file(${IMAGE} ${CMAKE_CURRENT_BINARY_DIR}/images/${fname} COPYONLY)
  else(WIN32)
    configure_file(${IMAGE} ${CMAKE_BINARY_DIR}/images/${fname} COPYONLY)
  endif(WIN32)
endforeach()

find_program(GLSL_VALIDATOR glslangValidator HINTS /usr/bin /usr/local/bin $ENV{VK_SDK_PATH}/Bin/ $ENV{VK_SDK_PATH}/Bin32/)

file(GLOB_RECURSE SHADER_SOURCES
  ${CMAKE_CURRENT_SOURCE_DIR}/*.vert
  ${CMAKE_CURRENT_SOURCE_DIR}/*.frag
  ${CMAKE_CURRENT_SOURCE_DIR}/*.geom
  ${CMAKE_CURRENT_SOURCE_DIR}/*.comp
  ${CMAKE_CURRENT_SOURCE_DIR}/*.tese
  ${CMAKE_CURRENT_SOURCE_DIR}/*.tesc
)

source_group("Shaders" FILES ${SHADER_SOURCES})

if(WIN32)
  add_executable(vulkan_grass_rendering WIN32 ${SOURCES} ${SHADER_SOURCES})
  target_link_libraries(vulkan_grass_rendering ${WINLIBS})
else(WIN32)
  add_executable(vulkan_grass_rendering ${SOURCES})
  target_link_libraries(vulkan_grass_rendering ${CMAKE_THREAD_LIBS_INIT})
endif(WIN32)

message(STATUS "Compiling shader sources:")

foreach(SHADER_SOURCE ${SHADER_SOURCES})
  message(STATUS "\t${SHADER_SOURCE}")
  
  if (WIN32)
    set(SHADER_DIR ${CMAKE_CURRENT_BINARY_DIR}/shaders)
  else(WIN32)
    set(SHADER_DIR ${CMAKE_BINARY_DIR}/shaders)
  endif(WIN32)

  get_filename_component(fname ${SHADER_SOURCE} NAME)
  add_custom_target(${fname}.spv
      COMMAND ${CMAKE_COMMAND} -E make_directory ${SHADER_DIR} && 
      ${GLSL_VALIDATOR} -V ${SHADER_SOURCE} -o ${SHADER_DIR}/${fname}.spv
      SOURCES ${SHADER_SOURCE}
  )
  ExternalTarget("Shaders" ${fname}.spv)
  add_dependencies(vulkan_grass_rendering ${fname}.spv)
endforeach()

target_link_libraries(vulkan_grass_rendering 
  ${ASSIMP_LIBRARIES} 
  Vulkan::Vulkan 
  glfw
  spdlog::spdlog_header_only
)
target_include_directories(vulkan_grass_rendering PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${GLM_INCLUDE_DIR}
  ${STB_INCLUDE_DIR}
)

InternalTarget("" vulkan_grass_rendering)
