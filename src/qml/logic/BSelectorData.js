var TNothing = 0;
var TSingle = 1;
var TDouble = 2;
var TGroup = 3;
var TRoundRobin = 4;

function ceil_2pow (count){ // ceil warriors count to pow of 2
	return Math.pow(2, Math.ceil(Math.log(count)/Math.log(2)));
};


function group_combinations (count){ // triangle number for count-1
	return count*(count-1)/2;
};


function RoundState(winners, losers, stageType){
	if(typeof(winners)==='undefined') winners = new RStateItem(0, 0, 0);
	if(typeof(losers)==='undefined') losers = new RStateItem(0, 0, 0);
	if(typeof(stageType)==='undefined') stageType = TNothing;

	this.winners = winners;
	this.losers = losers;
	this.stageType = stageType;
	this.nextCount = function (){
		return this.winners.count + this.losers.count;
	}
	this.getPairs = function (){
		return this.winners.pairs + this.losers.pairs;
	}
};

function RStateItem(inCount, outCount, pairs){
	this.inCount = inCount;
	this.count = outCount;
	this.pairs = pairs;
};

var choices = {
	'1_single_elim' : {
		caption : "Single Elimination",
		getState: function(state){
			var count = state.nextCount();

			//var losers_count = state.losers.count===1 ? 1 : 0;
			//var winners_count = Math.ceil(count/2);
			if (state)
				return new RoundState(
							new RStateItem(state.winners.count, Math.ceil(count/2), ceil_2pow(count)/2),
							new RStateItem(0, 0, 0),
							TSingle
							);
		},
		winCount: function(count){
			return Math.round(count/2);
		},
		isEnabled: function(prevState){
			if (prevState.stageType === TDouble){
				return false;
			}
			var count = prevState.nextCount();
			return count>=2;
		}
	},
	'2_double_elim' : {
		caption : "Double Elimination",
		getState: function(prev){
			//var count =state.nextCount();
			var winners = Math.ceil(prev.winners.count/2);
			var losers = prev.winners.count - winners + prev.losers.count;
			var advLosers = Math.ceil(losers/2);
			var losersIn = losers;
			var winnersIn = prev.winners.count;
			if (losersIn === 1 && winnersIn===1){
				advLosers = 0;
				winners  = 1;
				winnersIn = 2;
				losersIn = 0;
			}
			//if (prev.winners.count === 2  && prev.losers.count===0){
			//	winners  = 1;
			//	advLosers= 0
			//}
			return new RoundState(
						new RStateItem(winnersIn, winners, ceil_2pow(winners)),
						new RStateItem(losersIn, advLosers , ceil_2pow(advLosers)),
						TDouble
						);
		},
		isEnabled: function(prevState){
			if (prevState.stageType === TSingle){
				return false;
			}
			var count = prevState.nextCount();
			return count>=2;
		}
	},
	'g1' : {
		caption : "Group 4: ---> 2 wins",
		getState: function(state){
			var count =state.nextCount();
			var ingroup = 4;
			var winPerGroup = 2;
			var groups = Math.ceil(count/ingroup);
			var pairs = group_combinations(ingroup) * groups;
			return new RoundState(
						new RStateItem(0, groups * winPerGroup, pairs),
						new RStateItem(0, 0,0),
						TGroup
						);
		},
		isEnabled: function(prevState){
			if (prevState.stageType === TSingle || prevState.stageType === TDouble){
				return false;
			}
			var count = prevState.nextCount();
			return count>=4;
		}
	}, 'g2' : {
		caption : "Group 6: ---> 3 wins",
		getState: function(state){
			var count = state.nextCount();
			var ingroup = 6;
			var winPerGroup = 3;
			var groups = Math.ceil(count/ingroup);
			var pairs = group_combinations(ingroup) * groups;
			return new RoundState(
						new RStateItem(0, groups * winPerGroup, pairs),
						new RStateItem(0, 0, 0),
						TGroup
						);
		},
		isEnabled: function(prevState){
			if (prevState.stageType === TSingle || prevState.stageType === TDouble){
				return false;
			}
			var count = prevState.nextCount();
			return count>=4;
		}
	}

};


