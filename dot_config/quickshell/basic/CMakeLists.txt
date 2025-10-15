cmake_minimum_required(VERSION 4.0)
project(untitled VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


qt_add_qml_module(appuntitled
    URI untitled
    VERSION 1.0
    QML_FILES
        shell.qml
)


target_link_libraries(appuntitled
    PRIVATE Qt6::Quick
)
