import QtQuick 2.0
import "logic/BNode.js" as BNode;
Canvas {
	id: canvas
	property var roundsObj : [];
	property var tree : null;
	property var lst: [];
	function paintTree(_roundsObj){
		roundsObj = _roundsObj;

		for(var i = 0; i<lst.length; i++){
			var el = lst[i];
			el.destroy();
		}
		lst = [];
		tree  = BNode.createTree(roundsObj);

		requestPaint();

	}


	function paintTreeNew(node, parentNode, parentItem){
		if (!node) return;
		var salient = 210;
		var btl_width = salient - 50;
		var ydistance0 = 25;
		var ydistance = 25;
		var pair_dist = 6;


		var item = Qt.createQmlObject(
					'PairItem {}',
					canvas  , "onNewChoice_Errors");
		item.x = Math.ceil(40 + node.round * salient);

		var n =  node.bracket=== 0 ? roundsObj[node.round].winners.pairs : roundsObj[node.round].losers.pairs;
		if (!n) n =1;
		item.y =  Math.ceil(350/n * (node.ix) + 350/n/2 + node.bracket * 350);
		item.setName(BNode.nodeName(node));
		item.label1.text  = BNode.nodeName(node.in1, node.round);
		item.label2.text  = node.count===1 ? "SKIP" : BNode.nodeName(node.in2, node.round);
		paintTreeNew(node.in1, node, item);
		paintTreeNew(node.in2, node, item);
		lst.push(item);
		drawLink(node, item, parentItem, parentNode )

	}

	function drawLink(node, item, parentItem, parentNode ){
		if (!parentItem || !parentNode) return;
		if (node.bracket !== parentNode.bracket && !parentNode.isFinal) return;

		console.log("draw link");
		var ctx = getContext("2d")
		ctx.lineWidth = 1;
		ctx.strokeStyle = "#000000"
		var l = parentItem.getLeftPoint();
		var r = item.getRightPoint();
		ctx.moveTo(l.x, l.y);
		ctx.lineTo(Math.ceil( l.x + (r.x -l.x)/2), l.y);
		ctx.lineTo(Math.ceil(l.x + (r.x -l.x)/2), r.y);
		ctx.lineTo(r.x, r.y);
		ctx.stroke();

	}

	onPaint: {



		var salient = 210;
		var btl_width = salient - 50;
		var ydistance0 = 25;
		var ydistance = 25;
		var pair_dist = 6;
		var ctx = getContext("2d")
		ctx.fillStyle = "white"

		ctx.beginPath();
		ctx.clearRect(0,0, width, height);
		ctx.closePath();
		ctx.stroke();
		paintTreeNew(tree);
		return;
/*

		ctx.lineWidth = 1.0
		ctx.strokeStyle = "green"
		var prev = 0;
		var centr = ydistance;
		for (var i=0; i<roundsObj.length; i++){
			if (i){
				if ((roundsObj[i].winners.pairs + roundsObj[i].losers.pairs)<(prev.winners.pairs + prev.losers.pairs)){
					centr = Math.round(centr + ydistance/2);
					ydistance = Math.round(ydistance*2);

				} else
				{
					ydistance = ydistance0;

				}

			}


			var c = roundsObj[i].winners.pairs;
			var w = roundsObj[i].winners.count;
			ctx.strokeStyle = "green"
			ctx.beginPath();

			for (var j=0; j<c; j++){

				ctx.moveTo( i*salient, 10 + j * ydistance + centr);
				ctx.lineTo( i*salient + btl_width , 10 + j * ydistance + centr);
				ctx.moveTo( i*salient, 10 + j * ydistance + pair_dist + centr);
				ctx.lineTo( i*salient + btl_width , 10 + j * ydistance + pair_dist + centr);
			}
			ctx.closePath();
			ctx.stroke();

			ctx.strokeStyle = "blue"
			var y_offset = c * ydistance;
			c = roundsObj[i].losers.pairs;
			ctx.beginPath();
			for (var j=0; j<c; ++j){

				ctx.moveTo(  i*salient, 10 + j * ydistance + y_offset + centr);
				ctx.lineTo(  i*salient + btl_width, 10 + j * ydistance +y_offset + centr);
				ctx.moveTo(  i*salient, 10 + j * ydistance + y_offset + pair_dist + centr);
				ctx.lineTo(  i*salient + btl_width, 10 + j * ydistance +y_offset + pair_dist + centr);

			}
			ctx.closePath();
			ctx.stroke();

			prev = roundsObj[i];

		}*/



	}

}
