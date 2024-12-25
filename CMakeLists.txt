cmake_minimum_required(VERSION 3.16)

project(FlappyBird VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Multimedia )

qt_standard_project_setup()

qt_add_executable(appFlappyBird
    main.cpp
)

qt_add_qml_module(appFlappyBird
    URI FlappyBird
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES backend.h backend.cpp
        SOURCES FontManager.h FontManager.cpp
        QML_FILES CButton.qml
        QML_FILES Bird.qml
        QML_FILES CNumber.qml
        QML_FILES GameScreen.qml
        QML_FILES BackAnimation.qml
        QML_FILES HomeScreen.qml
        QML_FILES Pipe.qml
        QML_FILES PauseScreen.qml
        QML_FILES TemplateButton.qml
        QML_FILES ReadyScreen.qml
        QML_FILES GameOverScreen.qml
        QML_FILES BoardText.qml
        QML_FILES SoundManager.qml
        RESOURCES images/Flappy_Bird_icon.png
        RESOURCES images/bird_move_1.png
        RESOURCES images/bird_move_2.png
        RESOURCES images/bird_move_3.png
        RESOURCES images/base.png
        RESOURCES images/background.png
        RESOURCES images/title.png
        RESOURCES images/startButton.png
        RESOURCES images/pauseButton.png
        RESOURCES images/continueButton.png
        RESOURCES images/GameOver.png
        RESOURCES images/GetReady.png
        RESOURCES images/templateButton.png
        RESOURCES images/squareButton.png
        RESOURCES images/mute.png
        RESOURCES images/unmute.png
        RESOURCES images/instruction.png
        RESOURCES images/scoreboard.png
        RESOURCES sounds/sfx_die.wav
        RESOURCES sounds/sfx_hit.wav
        RESOURCES sounds/sfx_point.wav
        RESOURCES sounds/sfx_swooshing.wav
        RESOURCES sounds/sfx_wing.wav
)

set(FONT_DIR ${CMAKE_SOURCE_DIR}/fonts)

file(COPY ${FONT_DIR}/flappy-font.ttf ${FONT_DIR}/QuinqueFive.ttf DESTINATION ${CMAKE_BINARY_DIR}/fonts)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appFlappyBird PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appFlappyBird
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appFlappyBird
    PRIVATE Qt6::Quick
    Qt6::Multimedia
)

include(GNUInstallDirs)
install(TARGETS appFlappyBird
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
