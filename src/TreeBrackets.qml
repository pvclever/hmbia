import QtQuick 2.0

Canvas {

    property var roundsObj : [];
    function paintTree(_roundsObj){
        roundsObj = _roundsObj;
        requestPaint();

    }

    id: canvas



    onPaint: {

        var salient = 210;
        var btl_width = salient - 50;
        var ydistance0 = 25;
        var ydistance = 25;
        var pair_dist = 6;
        var ctx = getContext("2d")
       ctx.fillStyle = "white"

//ctx.beginPath();
     //   ctx.clearRect (0, 0, canvas.width, canvas.height);

        //
        ctx.fillRect(0,0,width, height);
       // ctx.closePath();
       // ctx.stroke;
      //  ctx.fill;
        ctx.lineWidth = 1.0
        ctx.strokeStyle = "green"
        var prev = 0;
        var centr = ydistance;
        for (var i=0; i<roundsObj.length; i++){
            // (16 - roundsObj[i].winners.pairs - roundsObj[i].losers.pairs) * ydistance / 2 ;
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

        }

    }

}
