import QtQuick 2.4
import QtQuick.Controls 1.2
import "logic/BSelectorData.js" as BSelectorData;
Item {
    id: thisElem;
    implicitWidth: 210;
    implicitHeight: 250;
    width: childrenRect.width + 20;
    height: childrenRect.height + 5;
	//signal newChoice();
	signal bracketComplete();
    property var lst: [];
    Component.onCompleted: {
      lst = [];
	  var firstbox = createNewCh(0, new BSelectorData.RoundState(new BSelectorData.RStateItem(0, 8, 0), new BSelectorData.RStateItem(0, 0,0)));

	}
	function getRounds(){
        var ret = [];
        for (var i=0; i<lst.length; ++i){
            ret.push(lst[i].round_state);
        }
        return ret;

    }

    function createNewCh(round, prev_state) {
        var current_box = Qt.createQmlObject(
                    'BracketSelector {}',
                    thisElem  , "onNewChoice_Errors");
        lst[round]=current_box;
        current_box.x = round * 210;
        current_box.round = round + 1;
        current_box.newChoice.connect(onChoice);
        if(typeof(state)!=='undefined'){
            current_box.setPrevState(prev_state);
            current_box.checkSingleChoice();
        }

        return current_box;
    }
    function onChoice(choice, round) {
        while(lst.length>round){
            var el = lst[lst.length-1];
            lst.splice(lst.length-1, 1);
            el.destroy();
        }
        var currend_box = lst[lst.length-1];
		var state = currend_box.round_state;
        if (state.nextCount() >=2 ){
            createNewCh(round, lst[lst.length-1].round_state);
		}
		//newChoice();
		//console.log("nextCount " +state.nextCount());
		if (state.nextCount() === 1 ){
			bracketComplete();
			//console.log("complete ");
		}
    }
}

