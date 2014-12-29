import QtQuick 2.4
import "BSelectorData.js" as BSelectorData;
BracketSelectorForm {

    property int warriors_count;
    property int round;
    signal newChoice(string choice, int round, int count);

    onRoundChanged: {
        if (warriors_count<=2){
            roundLabel.text = "FINAL";
            return;
        }
        roundLabel.text = "Round " + round;
    }
    onWarriors_countChanged: {
        warriorsLabel.text = "Warriors: " + warriors_count;
    }

    Component.onCompleted: {
        if (warriors_count<=2){
            return;
        }

        var bs_group = Qt.createQmlObject(
                    'import QtQuick.Controls 1.2; ExclusiveGroup {id: bs_group}',
                    choice_list);
        var choices =  BSelectorData.choices;
        for (var i in choices){
            var ch = choices[i];
            if (!ch.isEnabled(warriors_count)){
                continue;
            }

            var item = Qt.createQmlObject(
                        'import QtQuick.Controls 1.2; RadioButton {id:\'rbutton' + i + '\'}',
                        choice_list, "radio_errors");

            item.text = ch.caption;
            item.exclusiveGroup = bs_group;
            item.onClicked.connect(
                        (function(){
                            var keytmp = i;
                            var chtemp = ch;
                            return function(){
                                newChoice(keytmp, round, chtemp.winCount(warriors_count));
                            }

                        })()
                        );
        }

    }
}

