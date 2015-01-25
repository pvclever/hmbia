.import "BSelectorData.js" as BSelectorData


function createTree(roundsObj) {

	var rootNode = null;
	var res = {};
	var bId = 1;
	for(var r = 0; r < roundsObj.length; r++)
	{
		var rObj = roundsObj[r];
		res[r] =
				{
			winners: { wLink: 0, loslink: 0, nodes: [] },
			losers: { wLink: 0, loslink: 0, nodes: []}, stageType: 0
		};


		var c = rObj.winners.inCount;
		for(var i = 0; i < rObj.winners.pairs; i++)
		{
			var bcount = 2;
			if (bcount>c){
				bcount = c;
			}
			c -= bcount;

			var node = new BNode();
			node.id = bId;
			node.round = r;
			node.count = bcount;
			node.ix = i;
			//console.log(i + " " + node.ix);
			node.isFinal = (r === roundsObj.length-1);
			if (node.isFinal){
				rootNode = node;
			}
			res[r].winners.nodes.push(node);
			bId++;
		}

		//_genNodes(rObj, res, r, rootNode);

		c = rObj.losers.inCount;
		for(var i = 0; i < rObj.losers.pairs; i++)
		{
			var bcount = isOdd(c) ? 1 : 2;
			if (bcount>c){
				bcount = c;
			}
			c -= bcount;

			var node = new BNode();
			node.id = bId;
			node.round = r;
			node.count = bcount;
			node.bracket = 1;
			node.ix = i;
			res[r].losers.nodes.push(node);
			bId++;
		}
		res[r].stageType = rObj.stageType;
	}


	if (rootNode){
		_buildTree(res, rootNode)
	}

	//console.log("____________________________________________________");
	//printNode(rootNode);

	return rootNode;
}


function _buildTree(res, rootNode)
{
	if (!rootNode) return;
	var r = rootNode.round;
	if (r>=0){
		if (rootNode.count >= 1){
			if  (rootNode.bracket===1){
				rootNode.in1 = findNode(r, res, 2);
			}
			if (!rootNode.in1){
				rootNode.in1 = findNode(r-1, res, rootNode.bracket);
				_buildTree(res, rootNode.in1);
			}


			if (rootNode.count >= 2){
				rootNode.in2 = findNode(r-1, res, (rootNode.isFinal && res[r].stageType===BSelectorData.TDouble) ? 1 : rootNode.bracket);
				if (!rootNode.in2 &&  rootNode.bracket ===1){
					rootNode.in2 = findNode(r, res, 2);
				} else {
					_buildTree(res, rootNode.in2);
				}

			}
		}
	}
}


/*
bracket = 0 - winner in WBracket, 1- winnner in LBracket, 2 - loser in WBracket
*/
function findNode(round, res, bracket){
	if (round<0) return null;
	var arr = (bracket===0 || bracket===2) ? res[round].winners : res[round].losers;
	var linked = (bracket===2) ? arr.loslink : arr.wLink;
	if (linked < arr.nodes.length){
		if (bracket===2){
			if (arr.nodes[linked].count<2){
				return null; // no losers if skip-round
			}
			arr.loslink++;
		} else {
			arr.wLink++;
		}
		return arr.nodes[linked];
	}
	return null;
}


function BNode()
{
	this.id = 0;
	this.in1 = null;
	this.in2 = null;
	this.count = 0;
	this.isFinal = false;
	this.bracket = 0; // 0 - winners; 1 - losers
	this.round = 0;
	this.ix = 0;
}

/*
function _genNodes(rObj, res, r, rootNode){
	var c = rObj.winners.inCount;
	var bId = 1;
	for(var i = 0; i < rObj.winners.pairs; i++)
	{
		var bcount = 2;
		if (bcount>c){
			bcount = c;
		}
		c -= bcount;

		var node = new BNode();
		node.id = bId;
		node.round = r;
		node.count = bcount;
		node.isFinal = (r === roundsObj.length-1);
		if (node.isFinal){
			rootNode = node;
		}
		res[r].winners.nodes.push(node);
		bId++;
	}
}
*/

function printNode(node)
{
	if (!node) return;
	console.log(nodeName(node) + " <--------------------- " + nodeName(node.in1, node.round) + ", " + nodeName(node.in2, node.round ));
	printNode(node.in1);
	printNode(node.in2);
}

function nodeName(node, round){
	if (!node) return "";
	if (node.isFinal) return "FINAL";
	return ((round===node.round ? "Loser of " : "")  + ((node.bracket ===0) ? "W" : "L") + node.id );
}

function isOdd(n)
{
	return (Math.abs(n) % 2 == 1);
}
