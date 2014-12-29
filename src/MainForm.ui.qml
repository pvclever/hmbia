import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {
   id: item1

   width: 453
   height: 400
   anchors.fill: parent
   property alias contentarea: scroll_helper
   color: "#00000000"
   ScrollView  {
       width: parent.width
       height: 400
       id: scroll
       frameVisible: true
       visible: true
       anchors.fill: parent

       Rectangle {
           id: scroll_helper
           x: 8
           y: 8
           width: childrenRect.width + 20
           height: 10
           color: "#00000000"
       }


   }


}

