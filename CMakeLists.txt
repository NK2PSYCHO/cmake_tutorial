# The `cmake_minimum_required` command is a crucial piece of every CMake script. 
# It indicates the minimum version of CMake that is needed to process this script. 
# If the currently running version of CMake is older than the specified version, 
# an error will be reported and the script processing will stop. 
# This is important because different versions of CMake support different sets of commands and features. 
# By specifying the minimum required version, you ensure that CMake will understand all the commands in your script.
cmake_minimum_required(VERSION 3.15)

# The `project` command is used to set the name and version of the project. 
# This command also implicitly defines several variables that hold the specified project name and version, 
# which can be used later in the script. The project name is used in several places, 
# such as in the names of the built-in build and install targets. 
# The version number can be used to control different aspects of the build and install process, 
# such as setting version-specific compile definitions or installing versioned files.
project(Tutorial VERSION 1.0)

# The `set` command is used to define a variable and set its value. 
# In this case, the variable `CMAKE_DEBUG_POSTFIX` is being set to the value `d`. 
# This variable is used by CMake to append a postfix to the output file names when building in debug mode. 
# By setting this variable, you can distinguish the output files of debug builds from those of release builds.
set(CMAKE_DEBUG_POSTFIX d)

# The `add_library` command is used to create a library target. 
# In this case, an INTERFACE library named `tutorial_compiler_flags` is being created. 
# An INTERFACE library is a special kind of target that doesn't produce any build output itself, 
# but can hold usage requirements for other targets, such as include directories and compile options. 
# These usage requirements can be propagated to the consumers of the library when it is linked to them.
add_library(tutorial_compiler_flags INTERFACE)

# The `target_compile_features` command is used to specify the compile features required by a target. 
# In this case, the `cxx_std_11` compile feature is being specified for the `tutorial_compiler_flags` target. 
# This means that the target requires the C++11 standard. 
# When this target is built, CMake will ensure that the compiler uses the C++11 standard.
target_compile_features(tutorial_compiler_flags INTERFACE cxx_std_11)

# The `set` command is used here to define variables that hold generator expressions. 
# Generator expressions are evaluated by CMake during the generation phase, not during the script processing phase. 
# They can be used to specify different values or behaviors depending on the context. 
# In this case, the `gcc_like_cxx` variable holds a generator expression that evaluates to `1` if the language being 
# compiled is CXX and the compiler being used is ARMClang, AppleClang, Clang, GNU, or LCC. 
# Similarly, the `msvc_cxx` variable holds a generator expression that evaluates to `1` if the language 
# being compiled is CXX and the compiler being used is MSVC.
set(gcc_like_cxx "$<COMPILE_LANG_AND_ID:CXX,ARMClang,AppleClang,Clang,GNU,LCC>")
set(msvc_cxx "$<COMPILE_LANG_AND_ID:CXX,MSVC>")

# The `target_compile_options` command is used to add compile options to a target. 
# In this case, different compile options are being added to the `tutorial_compiler_flags` target depending on the compiler being used. 
# The `$<BUILD_INTERFACE:...>` generator expression is used to specify that these compile options should only be used when this target is being built, 
# not when it is being installed.
target_compile_options(tutorial_compiler_flags INTERFACE
  "$<${gcc_like_cxx}:$<BUILD_INTERFACE:-Wall;-Wextra;-Wshadow;-Wformat=2;-Wunused>>"
  "$<${msvc_cxx}:$<BUILD_INTERFACE:-W3>>"
)

# The `set` command is used here to set the directories where the different types of build artifacts 
# (libraries, executables, etc.) will be placed. By default, CMake places all build artifacts in the build directory. 
# However, you can use these variables to specify different output directories for different types of artifacts. 
# This can be useful to organize the build output and to ensure that the build artifacts are placed in a location that is 
# convenient for further processing or packaging.
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}")

# The `option` command is used to declare an option that can be set by the user when configuring the build. 
# In this case, the `BUILD_SHARED_LIBS` option is being declared, with a description and an initial value. 
# If the user sets this option to `ON` when configuring the build, shared libraries will be built instead of static libraries. 
# This can be useful to provide flexibility in how the project is built, as different users may have different requirements or preferences.
option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

# The `if` command is used to conditionally execute other commands based on the result of a condition. 
# In this case, the `APPLE` and `UNIX` variables are being used as conditions. 
# These variables are set by CMake to indicate the operating system being used. 
# The `set` command inside the `if` command is used to set the `CMAKE_INSTALL_RPATH` variable, 
# which specifies the runtime library search path that should be used when installing the project. 
# This can be useful to ensure that the installed executables can find their required libraries at runtime.
if(APPLE)
  set(CMAKE_INSTALL_RPATH "@executable_path/../lib")
elseif(UNIX)
  set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib")
endif()

# The `configure_file` command is used to generate a file from a template. 
# It takes an input file, replaces variables referenced as `@VAR@` or `${VAR}` with their values, 
# and writes the result to an output file. This can be useful to generate a file with specific values that are determined at configure time.
configure_file(TutorialConfig.h.in TutorialConfig.h)

# The `add_subdirectory` command is used to add a subdirectory to the build. 
# CMake will look for a `CMakeLists.txt` file in that directory and process it. 
# This can be useful to organize your project into logical components, each with its own `CMakeLists.txt` file.
add_subdirectory(MathFunctions)

# The `add_executable` command is used to add an executable target to the build. 
# The first argument is the name of the executable, and the rest are source files. 
# This tells CMake that you want to produce an executable file as part of the build, 
# and specifies the source files that should be compiled to produce the executable.
add_executable(Tutorial tutorial.cxx)

# The `set_target_properties` command is used to set properties on a target. 
# In this case, the `DEBUG_POSTFIX` property is being set on the `Tutorial` target. 
# This property specifies a string that will be appended to the output file name when building in debug mode. 
# This can be useful to distinguish the output files of debug builds from those of release builds.
set_target_properties(Tutorial PROPERTIES DEBUG_POSTFIX ${CMAKE_DEBUG_POSTFIX})

# The `target_link_libraries` command is used to specify which libraries a target should be linked with. 
# In this case, the `Tutorial` target is being linked with the `MathFunctions` and `tutorial_compiler_flags` libraries. 
# The `PUBLIC` keyword specifies the scope of the linking. 
# In this case, it means that the `MathFunctions` and `tutorial_compiler_flags` libraries will be linked to any other targets 
# that link to the `Tutorial` target.
target_link_libraries(Tutorial PUBLIC MathFunctions tutorial_compiler_flags)

# The `target_include_directories` command is used to specify the directories that will be added to the compiler's 
# include path when compiling a target. In this case, the `Tutorial` target is being compiled with an additional include directory. 
# The `PUBLIC` keyword specifies the scope of the include directories. 
# In this case, it means that the specified include directory will be added to the include path of any other targets that link to the `Tutorial` target.
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )

# The `install` command is used to specify how a target should be installed. 
# In this case, the `Tutorial` target is being installed into the `bin` directory. 
# When the `install` target is built, the `Tutorial` executable will be copied into the `bin` directory.
install(TARGETS Tutorial DESTINATION bin)

# The `install` command can also be used to install files. 
# In this case, the `TutorialConfig.h` file is being installed into the `include` directory. 
# When the `install` target is built, the `TutorialConfig.h` file will be copied into the `include` directory.
install(FILES "${PROJECT_BINARY_DIR}/TutorialConfig.h"
  DESTINATION include
  )

# The `enable_testing` command is used to enable testing for a directory and its subdirectories. 
# This tells CMake that you want to define tests for your project, which can be run with the `ctest` command or the `test` target.
enable_testing()

# The `add_test` command is used to add a test to the project. 
# In this case, two tests are being added: one named `Runs` that runs the `Tutorial` executable with an argument of `25`, 
# and one named `Usage` that runs the `Tutorial` executable with no arguments. When the `test` target is built, 
# these commands will be run and their results will be checked.
add_test(NAME Runs COMMAND Tutorial 25)
add_test(NAME Usage COMMAND Tutorial)

# The `set_tests_properties` command is used to set properties on tests. 
# In this case, the `PASS_REGULAR_EXPRESSION` property is being set on the `Usage` test. 
# This property specifies a regular expression that the output of the test will be checked against. 
# If the output matches the regular expression, the test is considered to have passed.
set_tests_properties(Usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage:.*number"
)

# The `function` command is used to define a function. 
# The function can be called later in the script with the specified arguments. 
# This can be useful to avoid repeating code, and to make the script more modular and easier to understand.
function(do_test target arg result)
  add_test(NAME Comp${arg} COMMAND ${target} ${arg})
  set_tests_properties(Comp${arg}
    PROPERTIES PASS_REGULAR_EXPRESSION ${result}
    )
endfunction()

# These commands call the function defined earlier. 
# The arguments are passed to the function. 
# This can be useful to perform the same operation multiple times with different arguments.
do_test(Tutorial 4 "4 is 2")
do_test(Tutorial 9 "9 is 3")
do_test(Tutorial 5 "5 is 2.236")
do_test(Tutorial 7 "7 is 2.645")
do_test(Tutorial 25 "25 is 5")
do_test(Tutorial -25 "-25 is (-nan|nan|0)")
do_test(Tutorial 0.0001 "0.0001 is 0.01")

# The `include` command is used to include a module. 
# A module is a file that contains CMake commands. 
# The commands in the module are executed as if they were written in the place of the `include` command. 
# The `InstallRequiredSystemLibraries` module is included with CMake and provides functionality for finding 
# and installing system libraries that are required by the project.
include(InstallRequiredSystemLibraries)

# The `set` command is used to define a variable and set its value. 
# In this case, the variable `CPACK_RESOURCE_FILE_LICENSE` is being set to the path of the `License.txt` file. 
# This variable is used by CPack to specify the license file that will be included in the package.
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")

# These `set` commands are used to define variables and set their values. 
# In this case, the variables `CPACK_PACKAGE_VERSION_MAJOR` and `CPACK_PACKAGE_VERSION_MINOR` are being set to 
# the major and minor version numbers of the project. These variables are used by CPack to specify the version of the package.
set(CPACK_PACKAGE_VERSION_MAJOR "${Tutorial_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${Tutorial_VERSION_MINOR}")

# The `set` command is used to define a variable and set its value. 
# In this case, the variable `CPACK_SOURCE_GENERATOR` is being set to the value `TGZ`. 
# This variable is used by CPack to specify the generator for the source package. 
# The `TGZ` generator produces a source package in tar.gz format.
set(CPACK_SOURCE_GENERATOR "TGZ")

# The `include` command is used to include a module. 
# In this case, the `CPack` module is being included. 
# This module is included with CMake and provides functionality for creating binary and source packages of the project.
include(CPack)

# The `install` command is used to install targets and files. 
# In this case, an export set is being installed. 
# An export set is a collection of targets that can be exported to other projects. 
# The `EXPORT` option specifies the name of the export set, the `FILE` option specifies the name of the file that will be generated, 
# and the `DESTINATION` option specifies the directory where the file will be installed.
install(EXPORT MathFunctionsTargets
  FILE MathFunctionsTargets.cmake
  DESTINATION lib/cmake/MathFunctions
)

# The `include` command is used to include a module. In this case, the `CMakePackageConfigHelpers` module is being included. 
# This module is included with CMake and provides several helper macros for creating package configuration files.
include(CMakePackageConfigHelpers)

# The `configure_package_config_file` command is used to configure a package configuration file. 
# The input file is processed and written to the output file. 
# This can be useful to generate a configuration file that can be used by other projects to find and use the targets of this project.
configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake"
  INSTALL_DESTINATION "lib/cmake/example"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )

# The `write_basic_package_version_file` command is used to write a package version file. 
# The version file can be used by the `find_package` command to check the version of the package. 
# This can be useful to ensure that the project is used in a compatible version.
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfigVersion.cmake"
  VERSION "${Tutorial_VERSION_MAJOR}.${Tutorial_VERSION_MINOR}"
  COMPATIBILITY AnyNewerVersion
)

# The `install` command is used to install files. 
# In this case, the `MathFunctionsConfig.cmake` file is being installed into the `lib/cmake/MathFunctions` directory. 
# When the `install` target is built, the `MathFunctionsConfig.cmake` file will be copied into the `lib/cmake/MathFunctions` directory.
install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsConfig.cmake
  DESTINATION lib/cmake/MathFunctions
  )

# The `export` command is used to export targets to a file. 
# The file can be included in another project with the `include` command. 
# This can be useful to make the targets of the project available to other projects.
export(EXPORT MathFunctionsTargets
  FILE "${CMAKE_CURRENT_BINARY_DIR}/MathFunctionsTargets.cmake"
)