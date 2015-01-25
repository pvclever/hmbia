import QtQuick 2.4
import QtQuick.Controls 1.2

Item {
    id: item2
    width: 140
    height: 50
	property alias pairName: pairName
	property alias label1: label1
	property alias label2: label2
    Column {
        id: column1
        x: 0
        y: 0
        width: 140
        height: 50
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: rectangle1
            width: 140
            height: 25
            border.width: 1

			Label {
				id: label1
				x: 8
				y: 8
				text: qsTr("0")
			}
		}

        Rectangle {
            id: rectangle2
            y: 0
			width: 140
			height: 25
			color: "#ffffff"
			border.width: 1

			Label {
				id: label2
				x: 8
				y: 8
				text: qsTr("0")
			}
		}
	}

	Text {
		id: pairName
		x: 51
		y: -20
		width: 39
		height: 14
		text: qsTr("pair")
		font.pixelSize: 12
	}
}

