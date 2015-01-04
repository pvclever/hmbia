import QtQuick 2.4
import QtQuick.Controls 1.2

Item {
    id: item2
    width: 140
    height: 50

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
        }

        Rectangle {
            id: rectangle2
            y: 0
            width: 140
            height: 25
            color: "#ffffff"
            border.width: 1
        }
    }
}

