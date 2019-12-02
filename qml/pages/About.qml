import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: aboutPage

    Flickable {
        id: flickable
        anchors.fill: parent

        PageHeader {
            id: header;
            title: "About"
        }

        Rectangle {
            anchors {
                left: parent.left;
                right: parent.right;
                top: header.bottom
            }
            height: parent.height
            color: "transparent"
            Image {
                id: appIcon
                fillMode: Image.PreserveAspectFit
                smooth: true
                source: "../img/harbour-SailTRON.png"
                anchors.horizontalCenter: parent.horizontalCenter

            }


            Label {
                id: appName
                text: "SailTRON"
                anchors.top: appIcon.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSizeLarge
            }

            Text {
                id: desc
                anchors {
                    top: appName.bottom;
                    left: parent.left;
                    right: parent.right;
                    margins: Theme.paddingMedium
                }
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.primaryColor
                wrapMode: Text.Wrap
                text: "SailTRON v1.0\nBy szopin\nLicensed under MIT";
            }

            Button {
                id: github
                anchors {
                    top: desc.bottom;
                    horizontalCenter: parent.horizontalCenter;
                    margins: Theme.paddingMedium
                }
                text: "Github"
                onClicked: Qt.openUrlExternally("https://github.com/szopin/harbour-sailTRON");
            }
                        Button {
                id: license
                anchors {
                    top: github.bottom;
                    horizontalCenter: parent.horizontalCenter;
                    margins: Theme.paddingLarge
                }
                text: "License"
                onClicked: Qt.openUrlExternally("https://github.com/szopin/harbour-sailTRON/blob/master/LICENSE");
            }
        }
    }
}
