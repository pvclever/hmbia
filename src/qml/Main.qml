
import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: mainw
    visible: true
    title: "The new hmbia application"

    width: 800
    height: 600

    Component.onCompleted: {
		boxes.bracketComplete.connect (function (){treeBrackets.paintTree(boxes.getRounds())});
    }
    ScrollView{
    anchors.fill: parent
    id: scroll1
    frameVisible :true
    contentItem : boxes
    Item {
        width: childrenRect.width;
        height: childrenRect.height;
        signal newChoice();
        Boxes {
            id: boxes;
        }
        TreeBrackets {
            id: treeBrackets;
            anchors.top: boxes.bottom;
            height: scroll1.height - y - 15;
            width: (boxes.width > scroll1.width ? boxes.width : scroll1.width) - 15;
        }

    }
}

}
