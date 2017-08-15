# Add more folders to ship with the application, here
folder_01.source = qml/emcalc
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

symbian:TARGET.UID3 = 0xE15E02DC

# Allow network access on Symbian
# symbian:TARGET.CAPABILITY += NetworkServices

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += src/main.cpp \
    src/emathlistmodel.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += GPLv2 LICENSE README winres.rc \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/origo/QtActivity.java \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/res/values-nl/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-ru/strings.xml \
    android/res/drawable/icon.png \
    android/res/drawable/logo.png \
    android/res/drawable-mdpi/icon.png \
    android/res/values/strings.xml \
    android/res/values/libs.xml \
    android/res/values-es/strings.xml \
    android/res/values-et/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-ldpi/icon.png \
    android/res/values-fa/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/values-el/strings.xml \
    android/res/values-nb/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/layout/splash.xml \
    android/res/values-rs/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-de/strings.xml \
    android/AndroidManifest.xml

RC_FILE = winres.rc

RESOURCES += \
    emcalc.qrc

HEADERS += \
    src/emathlistmodel.h

include($$PWD/../emath/emath.pri)

