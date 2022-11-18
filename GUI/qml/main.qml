
import QtQuick.Window 2.1
import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.1
import "components"

ApplicationWindow{
    visible:true
    //visibility: "Maximized"
    width:1280
    height:720
    id: mainWindow    
    color:  "#322F2E"
    flags: Qt.Window | Qt.FramelessWindowHint   

    property int previousX
    property int previousY
    property int windowStatus: 0
    property double _opacity: 0.4

    function basename(str)
    {
        return (str.slice(str.lastIndexOf("/")+1))
    }
    QtObject{
        id:internalMain
        function call_closeApp()
        {
            mainWindow.close()
        }
        function call_maximizeRestore(){
        }
        function call_Minimized(){
        }
    }
    Image{
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: "../resources/black-wolf.png"
        opacity:_opacity
    }

    FileDialog {
        id: open_file_dialog
        width:550
        height:300
        visible:false
        title: "Please choose a file to load"
        folder: "file:///D:/GitHub/Image-Captioning/images"
        nameFilters: [ "Image files (*.png *.jpg *.jpeg)", "All files (*)" ]
        selectFolder :false
        onAccepted: {
            _mainWindowVM.load_img_file(open_file_dialog.fileUrls)                            
        }
        onRejected: {           
        }       
    } 
    Rectangle {
        height: 35
        color:   "#16171B"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin:0
        anchors.topMargin: 0       
        MouseArea {
            anchors.fill: parent
            enabled: true
            onPressed: {
                previousX = mouseX
                previousY = mouseY
            }
            onMouseXChanged: {
                if(windowStatus==2)return
                var dx = mouseX - previousX
                mainWindow.setX(mainWindow.x + dx)
            }
            onMouseYChanged: {
                if(windowStatus==2)return
                var dy = mouseY - previousY
                mainWindow.setY(mainWindow.y + dy)
            }
        }     
        TitleBar{  
            id: titleBar         
            _nameTitleBar:"Vayne Mai"
        }
    }

    Row{
        width: parent.width
        height:parent.height -35
        anchors{
            top :parent.top
            topMargin: 45
            left:parent.left
            leftMargin: 10
            right:parent.right
            rightMargin: 10
            bottom:parent.bottom
            bottomMargin: 10
        }
        Rectangle{
            width: parent.width *0.2
            height:parent.height
            color:"transparent"
            Row{
                width: parent.width
                height:parent.height *0.2
                ButtonCus{
                    width: parent.width *0.45
                    height:parent.height
                    _text:"Load Image \n" 
                    onClicked:{
                        console.log("[qml]: Click to load image")
                        open_file_dialog.open()
                    }
                    Text{
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        text:basename(open_file_dialog.fileUrls.toString())
                        font.weight: Font.Medium
                        font.pointSize:10
                        font.bold: false
                        opacity: enabled ? 1.0 : 0.3
                        color: "aqua"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle{
                    width:parent.width *0.1
                    height: parent.height
                    color: "transparent"
                }
                ButtonCus{
                    width: parent.width *0.45
                    height:parent.height
                    _text:"Gen Caption"
                    onClicked:{
                        console.log("[qml]: Click to gennerate caption")
                        _mainWindowVM.gen_image_caption()      
                    }
                }
            } 
            Text{
                width:parent.width
                height:parent.height *0.7
                anchors.top: parent.top
                anchors.topMargin:parent.height * 0.3

                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.1

                anchors.left:parent.left
                anchors.leftMargin: 10

                anchors.right:parent.right
                anchors.rightMargin: 10

                text:image_caption_text.qml_prop_str
                color:"white"
                font.weight: Font.Medium
                font.pointSize:12
                font.bold: false
                opacity: enabled ? 1.0 : 0.3
                wrapMode: "WordWrap"
            }
        }  
        Rectangle{
            width:parent.width * 0.1
            height:parent.height
            color:"transparent"
        }
        Image{
            width: parent.width *0.7
            height:parent.height
            source: path_image.qml_prop_str
            fillMode: Image.PreserveAspectFit
        }     
    }
    Component.onCompleted: {}
}