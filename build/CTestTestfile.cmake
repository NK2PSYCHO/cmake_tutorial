# CMake generated Testfile for 
# Source directory: C:/Users/nk2ps/Downloads/cmake_tutorial
# Build directory: C:/Users/nk2ps/Downloads/cmake_tutorial/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(Runs "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe" "25")
set_tests_properties(Runs PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;139;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
add_test(Usage "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe")
set_tests_properties(Usage PROPERTIES  PASS_REGULAR_EXPRESSION "Usage:.*number" _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;140;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
add_test(Comp4 "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe" "4")
set_tests_properties(Comp4 PROPERTIES  PASS_REGULAR_EXPRESSION "4 is 2" _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;154;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;163;do_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
add_test(Comp9 "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe" "9")
set_tests_properties(Comp9 PROPERTIES  PASS_REGULAR_EXPRESSION "9 is 3" _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;154;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;164;do_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
add_test(Comp5 "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe" "5")
set_tests_properties(Comp5 PROPERTIES  PASS_REGULAR_EXPRESSION "5 is 2.236" _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;154;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;165;do_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
add_test(Comp7 "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe" "7")
set_tests_properties(Comp7 PROPERTIES  PASS_REGULAR_EXPRESSION "7 is 2.645" _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;154;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;166;do_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
add_test(Comp25 "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe" "25")
set_tests_properties(Comp25 PROPERTIES  PASS_REGULAR_EXPRESSION "25 is 5" _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;154;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;167;do_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
add_test(Comp-25 "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe" "-25")
set_tests_properties(Comp-25 PROPERTIES  PASS_REGULAR_EXPRESSION "-25 is (-nan|nan|0)" _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;154;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;168;do_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
add_test(Comp0.0001 "C:/Users/nk2ps/Downloads/cmake_tutorial/build/Tutoriald.exe" "0.0001")
set_tests_properties(Comp0.0001 PROPERTIES  PASS_REGULAR_EXPRESSION "0.0001 is 0.01" _BACKTRACE_TRIPLES "C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;154;add_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;169;do_test;C:/Users/nk2ps/Downloads/cmake_tutorial/CMakeLists.txt;0;")
subdirs("MathFunctions")
