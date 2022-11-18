import os 
import sys
import numpy as np
import pandas as pd
import ctypes
import PyQt5
from PyQt5.QtCore import pyqtSlot,QObject,QSize
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtGui import QIcon

from ViewModel.MainVM import MainWindowVM


current_dir_working = os.path.dirname(os.path.realpath(__file__))
path_icon_app = os.path.join(current_dir_working,r"resources\black-wolf.ico")

from lib import CWD

if __name__ =="__main__":
    app = QGuiApplication(sys.argv)
    app_icon = QIcon()
    app_icon.addFile(path_icon_app, QSize(16,16))
    engine = QQmlApplicationEngine()

    app.setWindowIcon(app_icon)
    app.setApplicationName("Black Wolf")

    mainWindowVM = MainWindowVM(engine,CWD)
    context = engine.rootContext().setContextProperty('_mainWindowVM', mainWindowVM)
    engine.load(os.path.join(os.path.dirname(__file__), "qml\main.qml"))
            
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
    