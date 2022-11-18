__all__ = []
__doc__ = """
_summary_

-> The class to represent a variable that is two-binded in the Python logic and in QML gui

Returns:
    _type_: _description_
"""

from typing import Union
from PyQt5 import QtCore as qtc
from PyQt5.QtCore import pyqtProperty


class TwoWayBindingParam(qtc.QObject):
    valueChanged = qtc.pyqtSignal()

    def __init__(self, value, parent_=None):
        super().__init__(parent_)
        self.value = value
        return None

    @qtc.pyqtSlot(str)
    @qtc.pyqtSlot(int)
    @qtc.pyqtSlot(bool)
    @qtc.pyqtSlot(list)
    def set(self, value):
        self.value = value
        self.valueChanged.emit()

    def get(self) -> Union[str, int, bool, list]:
        return self.value

    """
    Define type of Property
    """
    qml_prop_int = qtc.pyqtProperty(int, get, set, notify=valueChanged)
    qml_prop_float = qtc.pyqtProperty(float, get, set, notify=valueChanged)
    qml_prop_bool = qtc.pyqtProperty(bool, get, set, notify=valueChanged)
    qml_prop_str = qtc.pyqtProperty(str, get, set, notify=valueChanged)
    qml_prop_list = qtc.pyqtProperty(list, get, set, notify=valueChanged)