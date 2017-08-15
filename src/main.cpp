#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "emathlistmodel.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QmlApplicationViewer viewer;
		
	EmathListModel model;
	qmlRegisterType<EmathListModel>("EmathListModel", 1, 0, "EmathListModel");	
	
	viewer.engine()->rootContext()->setContextProperty("dataModel", &model);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/emcalc/main.qml"));
	viewer.showExpanded();
//	viewer.showFullScreen();

    return app.exec();
}
