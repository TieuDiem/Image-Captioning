import QtQuick 2.1
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

Button{
    id: btnTopBar
    // CUSTOM PROPERTIES
    property url btnIconSource: "../../resources/minimize_icon.svg"
    property color btnColorDefault: "#1c1d20"
    property color btnColorMouseOver: "#23272E"
    property color btnColorClicked: "#00a1f1"
    property color btnColorOverlay : "#ffffff"
    property   int _width:35
    property   int _height:35
    QtObject{
        id: internal

        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnTopBar.down){
                                       btnTopBar.down ? btnColorClicked : btnColorDefault                                      
                                   } else {
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }

    width: _width
    height: _height

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor
        radius:5
        
        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: btnTopBar.height-15 >0 ?btnTopBar.height-15:btnTopBar.height
            width: btnTopBar.width-15 >0 ? btnTopBar.width-15:btnTopBar.width
            visible: false
            fillMode: Image.PreserveAspectFit
            antialiasing: false
        }
        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: btnColorOverlay
            antialiasing: false       
        }
    }
}


