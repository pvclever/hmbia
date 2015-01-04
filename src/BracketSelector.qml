import QtQuick 2.4
import "BSelectorData.js" as BSelectorData;
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
        warriorsLabel.text = "Warriors: " + warriors_count + " , battles:" + round_state.getPairs();
    }

    onRound_stateChanged: {updateMeters();}

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
        prev_state = _prev_state;
        if (warriors_count<=2){
            round_state.winners = new BSelectorData.RStateItem(1,1);
            round_state = round_state; // emit onRound_stateChanged

        }
        var bs_group = Qt.createQmlObject(
                    'import QtQuick.Controls 1.2; ExclusiveGroup {id: bs_group}',
                    choice_list);
        var choices =  BSelectorData.choices;
        var cnt = 0;
        for (var i in choices){
            var ch = choices[i];
            if (!ch.isEnabled(warriors_count)){
                continue;
            }

            item = Qt.createQmlObject(
                        'import QtQuick.Controls 1.2; RadioButton {id:\'rbutton' + i + '\'}',
                        choice_list, "radio_errors");

            item.text = ch.caption;
            item.exclusiveGroup = bs_group;
            item.onCheckedChanged.connect(
                        (function(){
                            var keytmp = i;
                            var chtemp = ch;
                            return function(){
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

