import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.2
import "components"

Item{

    property string _nameTitleBar:"Black Wolf"

    property  url _btnMaximizeRestore:""
    QtObject{
        id:internalTBar
    }
    width:parent.width
    height:parent.height
    Rectangle {
        id: titleBar
        height: parent.height
        color:   "#16171B"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin:0
        anchors.topMargin: 0     
            Image {
                id: iconApp
                width: 22
                height: 22
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                source: ""
                anchors.bottomMargin: 0
                anchors.leftMargin: 5
                anchors.topMargin: 0
                fillMode: Image.PreserveAspectFit
            }
            Label {
                id: label
                color: "white"
                font.family:"Adobe Gothic Std B"  
                text: qsTr(_nameTitleBar)
                anchors.left: iconApp.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                anchors.leftMargin: 5
                font.bold:true
            }            
            Row {
                id: rowBtns
                width: 105
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.rightMargin: 0  
                anchors.bottom: parent.bottom
                anchors.bottomMargin:0
                TopBarButton{       
                    _height: parent.height       
                    btnColorDefault : titleBar.color
                    btnColorOverlay : "dimgrey"
                    btnColorClicked:titleBar.color
                    btnColorMouseOver:"#00000000"
                    btnIconSource:"../resources/minimize_icon.svg"
                    onClicked: {
                        internalMain.call_Minimized()
                    }
                }                                           
                TopBarButton{
                    id:btnMaximizeRestore
                    _height: parent.height
                    btnColorDefault : titleBar.color
                    btnColorOverlay : "dimgrey"
                    btnColorClicked:"#00000000"
                    btnIconSource:"../resources/restore_icon.svg"
                    onClicked: {
                        internalMain.call_maximizeRestore()
                    }                   
                }              
                TopBarButton {
                    _height: parent.height
                    id: btnClose
                    btnColorClicked: "#00000000"
                    btnColorDefault : "transparent"
                    btnColorOverlay : "red"
                    btnIconSource: "../resources/close_icon.svg"
                    onClicked: {
                        internalMain.call_closeApp()
                    }
                }
        }
    }
}