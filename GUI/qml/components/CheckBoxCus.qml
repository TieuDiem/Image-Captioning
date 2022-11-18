
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.1
import  QtQuick.Controls 1.4
import QtQuick 2.1

CheckBox {
    width:_width
    height:_height

    property string  _text:""
    property double _width : 0
    property double _height : 0
    
    style: CheckBoxStyle {
        indicator: Rectangle {
            implicitWidth: _width *0.6
            implicitHeight: 35
            radius: 3
            border.color: control.activeFocus ? "darkblue" : "gray"
            border.width: 1
            Rectangle {
                visible: control.checked
                color: "#41CD52"
                border.color: "#333"
                radius: 1
                anchors.margins: 4
                anchors.fill: parent
            }
            Text{
                anchors.left: parent.left
                anchors.leftMargin:_width *0.65
                width: _width *0.35
                height:parent.height
                text:_text
                color:"White"
                font.weight: Font.Medium
                font.pointSize:12
                font.bold: false
                opacity: enabled ? 1.0 : 0.3
                wrapMode: "WordWrap"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}