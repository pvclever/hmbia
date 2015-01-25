import QtQuick 2.4
import "logic/BSelectorData.js" as BSelectorData;
BracketSelectorForm {
    id: thisItem;
    property int warriors_count;
    property int round;
    property var round_state: new BSelectorData.RoundState();
    property var prev_state: new BSelectorData.RoundState();
    signal newChoice(string choice, int round);
    property var item;

    function checkSingleChoice(){
        if (item!==null){
            item.checked=true;
        }
    }
    function updateMeters(){
		if(!prev_state || !round_state) return;
		warriorsLabel.text = "Warriors: " + round_state.winners.inCount + " :: " + round_state.losers.inCount + " , battles:" + round_state.winners.pairs + "::"+ round_state.losers.pairs;
    }

	onRound_stateChanged: {
		updateMeters();
	}

    onPrev_stateChanged: {
        warriors_count = prev_state.nextCount();
        if (warriors_count<=2){
            roundLabel.text = "FINAL";
            return;
        }
        roundLabel.text = "Round " + round;
        updateMeters();
    }

    function setPrevState(_prev_state){

		round_state.winners =  new BSelectorData.RStateItem(_prev_state.winners.count,0,0);;
		prev_state = _prev_state;
		var bs_group = Qt.createQmlObject(
					'import QtQuick.Controls 1.2; ExclusiveGroup {id: bs_group}',
					choice_list);
		var choices =  BSelectorData.choices;
        var cnt = 0;
        for (var i in choices){
            var ch = choices[i];
            if (!ch.isEnabled(prev_state)){
                continue;
            }

            item = Qt.createQmlObject(
                        'import QtQuick.Controls 1.2; RadioButton {id:\'rbutton' + i + '\'}',
						choice_list);

            item.text = ch.caption;
            item.exclusiveGroup = bs_group;
            item.onCheckedChanged.connect(
                        (function(){
                            var keytmp = i;
							var chtemp = ch;
							var radioButton = item
                            return function(){
								if(!radioButton.checked) return;
								var rstate = thisItem.round_state;
                                thisItem.round_state = chtemp.getState(thisItem.prev_state);
                                newChoice(keytmp, round);
                            }

                        })()
                        );
            cnt++;
        }
        if (cnt!==1){
            item = null;
        }

    }

    Component.onCompleted: {

    }
}

