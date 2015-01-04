	import QtQuick 2.4
	import QtQuick.Layouts 1.0
	import QtQuick.Controls 1.2
	
    Item {
	    id: item1
		property alias choice_list: choice_list
        property alias roundLabel: roundLabel
        property alias warriorsLabel: warriorsLabel
        width: 200
        height: 250
        Rectangle {
            id: rectangle1
            x: 0
            y: 8
            width: 200
            height: 230
            color: "#ffffff"
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.left: parent.left
            border.color: "#000001"
	
	ColumnLayout {
	    id: choice_list
        x: 13
        y: 77
        width: 184
        height: 150
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        anchors.left: parent.left
        transformOrigin: Item.Center
        spacing: 8
    }

 Label {
     id: warriorsLabel
     x: 54
     y: 50
     width: 122
     height: 16
     text: qsTr("Warriors: 0")
     anchors.horizontalCenter: choice_list.horizontalCenter
     anchors.top: roundWraper.bottom
     anchors.topMargin: 6
     font.pointSize: 11
     horizontalAlignment: Text.AlignHCenter
 }

 Rectangle {
     id: roundWraper
     x: 13
     y: 8
     width: 183
     height: 36
     color: "#cccccc"
     anchors.horizontalCenter: parent.horizontalCenter
     anchors.top: parent.top
     anchors.topMargin: 8

     Label {
         id: roundLabel
         x: 0
         y: 8
         width: 147
         height: 13
         text: qsTr("Round 1")
         styleColor: "#f09494"
         font.pointSize: 15
         horizontalAlignment: Text.AlignHCenter
         anchors.horizontalCenter: parent.horizontalCenter
     }
        }











        }
    }
	
	
