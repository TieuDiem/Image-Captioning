import QtQuick 2.6
import QtQuick.Controls 2.1

Button {
    id: control

    width:parent.width
    height:parent.height

    property string _text:""
    property bool _isClick:false
    text: qsTr(_text)
    QtObject{
        id:internalButonCus
        property var _dynamic_color_button: if (_isClick==false){
            return "#333333"
        }else{
            return "#229043"
        }
    }
    onClicked: {
    }
    contentItem: Text {
        text: control.text
        font.weight: Font.Medium
        font.pointSize:12
        font.bold: false
        opacity: enabled ? 1.0 : 0.3
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        color:internalButonCus._dynamic_color_button
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        border.color: control.down ? "#17a81a" : "#21be2b"
        border.width: 1
        radius: 5
    }
}