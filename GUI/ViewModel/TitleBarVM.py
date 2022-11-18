from PyQt5.QtCore import QObject
from ViewModel import BaseViewModel

class TitleBarVM(QObject):
    def __init__( self, appEngineer):
        QObject.__init__(self)
        self.eng = appEngineer         
        self.initDefaultParams()
        
    def initDefaultParams(self):  
        pass
 

    # @Slot()
    # def closeApp(self):  
    #     return True   

    def setColor(self, value):
        self.colorStatus.set(value)