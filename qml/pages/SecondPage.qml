import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page

    allowedOrientations: Orientation.Portrait
    property var firstrun: 0
    property var thicc

    property var aX
    property var aY
    property var bX
    property var bY
    property var vax
    property var vbx
    property var vay
    property var vby
    Canvas {
        id : canvas
        renderStrategy: Canvas.Threaded
        renderTarget: Canvas.Image
        anchors.fill: parent
        MultiPointTouchArea {
            id: marea
            anchors.fill: parent
            minimumTouchPoints: 1
            maximumTouchPoints: 5
            Label{
                id: creditsblue
                visible: false
                text: "Blue player lives!"
                anchors.centerIn: marea
            }
            Label{
                id: creditsred
                visible: false
                text: "Red player lives!"
                anchors.centerIn: marea
            }
            Button {
                id: resButton
                x: canvas.width/2 - width/2
                visible: false
                text: "Next victim"
                onClicked: {
                    resButton.visible = false
                    creditsred.visible = false
                    creditsblue.visible = false

                    firstrun=0;
                    console.log("button pressed");
                    canvas.requestPaint();
                    timer.start();
                }
            }
            onPressed: {
                for (var i = 0; i < touchPoints.length; ++i) {
                    var touchPoint = touchPoints[i]
                    if (touchPoint.y < canvas.height/2){
                        if (touchPoint.x > canvas.width/2){
                            if (vax !== 0){
                                vay = -vax;
                                vax = 0;
                            } else {
                                vax = vay;
                                vay = 0;
                            }
                        } else {
                            if (vax !== 0){
                                vay = vax;
                                vax = 0;
                            } else {
                                vax = -vay;
                                vay = 0;
                            }
                        }
                    } else if (touchPoint.x < canvas.width/2){
                        if (vbx !== 0){
                            vby = -vbx;
                            vbx = 0;
                        } else {
                            vbx = vby;
                            vby = 0;
                        }
                    } else {
                        if (vbx !== 0){
                            vby = vbx;
                            vbx = 0;
                        } else {
                            vbx = -vby;
                            vby = 0;
                        }
                    }
                }
            }
        }
        onPaint : {
            //console.log("PAINT!")
            var ctx = canvas.getContext("2d")
            if (firstrun ==0){
                if(thicc===undefined){
                    thicc=10;
                }
                ctx.fillStyle = Qt.rgba(1, 1, 1, 1);
                ctx.fillRect(0, 0, canvas.width, canvas.height);
                ctx.clearRect(2,2,(canvas.width /2) - 3, canvas.height/5 -3);
                ctx.clearRect((canvas.width /2) + 1, 2,(canvas.width /2) - 4, canvas.height/5-3);
                ctx.clearRect(2,canvas.height/5+1,canvas.width  - 4,(canvas.height/5)*3-1);
                ctx.clearRect(2,canvas.height/5*4+2,canvas.width/2 - 3,(canvas.height/5)-4);
                ctx.clearRect((canvas.width /2) + 1,canvas.height/5*4+2,canvas.width/2  - 4,(canvas.height/5)-4);
                aX = canvas.width/2-thicc
                aY = canvas.height/5+(4*thicc)
                bX = canvas.width/2+thicc
                bY = canvas.height/5*4-(4*thicc)
                vax = 0
                vbx = 0
                vay = thicc
                vby = -thicc
                firstrun=1;
            } else {
                ctx.fillStyle = Qt.rgba(0.3, 0.7, 1, 1);
                var pixcheck = ctx.getImageData(aX, aY, thicc, thicc);
                var temp = pixcheck.data;
                for (var i = 0; i < temp.length; i++){
                    if(temp[i] != 0){
                        timer.stop();
                        creditsred.visible = true
                        resButton.visible = true
                        resButton.anchors.top = creditsred.bottom
                        console.log("Top player lost")
                        break
                    }
                }
                ctx.fillRect(aX, aY, thicc, thicc);
                ctx.fillStyle = Qt.rgba(1, 0.2, 0.1, 1);
                var pixcheck = ctx.getImageData(bX, bY, thicc, thicc);
                var temp = pixcheck.data;
                for (var i = 0; i < temp.length; i++){
                    if (temp[i] != 0){
                        timer.stop();
                        creditsblue.visible = true
                        resButton.visible = true
                        resButton.anchors.top = creditsblue.bottom
                        console.log("Bottom player lost")
                        break
                    }
                }
                ctx.fillRect(bX, bY, thicc, thicc);
                aX+=vax;
                aY+=vay;
                bX+=vbx;
                bY+=vby;
            }
        }
        Timer {
            id: timer
            interval : 17
            running : true
            repeat : true
            onTriggered : {
                if (firstrun==0){
                    canvas.requestPaint();
                } else {
                    canvas.markDirty(Qt.rect(aX, aY, thicc, thicc));
                    canvas.markDirty(Qt.rect(bX, bY, thicc, thicc));
                }
            }
        }
    }

}
