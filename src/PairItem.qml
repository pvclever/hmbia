import QtQuick 2.4

PairItemForm {
    id: thisElement;
    function getRightPoint(){
        return Qt.point(x + width, y + height/2);
    }

    function getLeftPoint(){
        return Qt.point(x, y + height/2);
    }

}

