import QtQuick 2.1
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0
/*
- Available in Rec
- Using as space bettween control follow Vertical direction
*/
Rectangle{
    property int _space:10
    property string  _mode :"vertical"
    property color _colorSpace:"transparent"
    QtObject{
        
    }
    height: _space
    width:1
    color:_colorSpace
}