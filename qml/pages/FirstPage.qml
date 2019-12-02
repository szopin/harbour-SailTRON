import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: page
    allowedOrientations: Orientation.Portrait
    SilicaFlickable {
        anchors.fill: parent
            PageHeader {
                title: "Choose thickness"
            }
            PullDownMenu {
                MenuItem {
                    text: "About"
                    onClicked: pageStack.push("About.qml");
                }
            }
            Slider{
                id: slider
                y: parent.height/2
                value: 10
                minimumValue: 5
                maximumValue: 20
                stepSize: 5
                enabled: handleVisible
                width: parent.width
                label: "Thickness"
            }
            Button {
                anchors.top: slider.bottom
                x: parent.width/2 - width/2
                text: "Fight!"
                onClicked: pageStack.push("SecondPage.qml", {"thicc": slider.value})
            }
    }
}
