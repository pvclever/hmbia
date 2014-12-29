import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
ApplicationWindow {
    visible: true
    title: "The new hmbia application"
    width:Screen.desktopAvailableWidth;
    height: 300;//Screen.desktopAvailableHeight;
    MainForm {
        property var lst;
        Component.onCompleted: {
            lst = [];
            createNewCh(64, 0);
        }
        function createNewCh(count, round) {
            var current_box = Qt.createQmlObject(
                        'BracketSelector {id: br1; warriors_count: ' + count + '}',
                        contentarea   , "onNewChoice_Errors");
            current_box.newChoice.connect(onChoice);
            current_box.x = round * 210;
            current_box.round = round + 1;
            lst[round]=current_box;

        }
        function onChoice(choice, round, count) {
            while(lst.length>round){
                var el = lst[lst.length-1];
                lst.splice(lst.length-1, 1);
                el.destroy();
            }
            if (count>=2){
                createNewCh(count, round);
            }
        }
    }
}
