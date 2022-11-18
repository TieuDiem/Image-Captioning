import QtQuick 2.1
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

/*
- Available in Rectangle Control
- Using as space bettween control foloow horizontal direction
*/

Rectangle{
    property int _space:10
    property string  _mode :"vertical"
    property  color _colorSpace:"transparent"
    property int    _height:0
    width: _space
    height:_height
    color:_colorSpace
}