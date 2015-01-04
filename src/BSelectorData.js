
function ceil_2pow (count){ // ceil warriors count to pow of 2
    return Math.pow(2, Math.ceil(Math.log(count)/Math.log(2)));
};


function group_combinations (count){ // triangle number
    return count*(count+1)/2;
};


function RoundState(winners, losers){
    if(typeof(winners)==='undefined') winners = new RStateItem(0,0);
    if(typeof(losers)==='undefined') losers = new RStateItem(0,0);

    this.winners = winners;
    this.losers = losers;
    this.nextCount = function (){
      return this.winners.count + this.losers.count;
    }
    this.getPairs = function (){
      return this.winners.pairs + this.losers.pairs;
    }
};

//function warriors(state){
 //   return state.winners.count + state.losers.count;
//}

///function pairs(state){
//    return state.winners.pairs + state.losers.pairs;
//}

function RStateItem(count, pairs){
    this.count = count;
    this.pairs = pairs;
};

var choices = {
    '1_single_elim' : {
        caption : "Single Elimination",
        getState: function(state){
            var count =state.nextCount();
            return new RoundState(
                new RStateItem(Math.ceil(count/2), ceil_2pow(count)/2),
                new RStateItem(0, 0)
            );
        },
        winCount: function(count){
            return Math.round(count/2);
        },
        isEnabled: function(count){
            return count>=2;
        }
    },
    '2_double_elim' : {
        caption : "Double Elimination",
        getState: function(state){
            var count =state.nextCount();
            return new RoundState(
                new RStateItem(Math.ceil(count/2), ceil_2pow(count)/2),
                new RStateItem(Math.ceil(count/4) , ceil_2pow(count)/4)
            );
        },        
        isEnabled: function(count){
            return count>=4;
        }
    },   
    '0_group3' : {
        caption : "Group 3: ---> 2 wins",
        getState: function(state){
            var count =state.nextCount();
            var ingroup = 3;
            var groups = Math.ceil(count/ingroup);
            var pairs = group_combinations(ingroup) * groups;
            return new RoundState(
                new RStateItem(groups * 2, pairs),
                new RStateItem(0,0)
            );
        },
        isEnabled: function(count){
            return count>=4;
        }
    }, '0_group4' : {
        caption : "Group 4: ---> 2 wins",
        getState: function(state){
            var count =state.nextCount();
            var ingroup = 4;
            var groups = Math.ceil(count/ingroup);
            var pairs = group_combinations(ingroup) * groups;
            return new RoundState(
                new RStateItem(groups * 2, pairs),
                new RStateItem(0,0)
            );
        },
        isEnabled: function(count){
            return count>=4;
        }
    }

};


