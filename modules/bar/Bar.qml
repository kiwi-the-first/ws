import Quickshell
import QtQuick
import qs.config

// id: bar - panel
PanelWindow {
    id: statusbar

    anchors {
        left: true
        top: true
        bottom: true
    }

    margins {
        top: 10
        bottom: 10
    }

    implicitWidth: 60
    color: "transparent"

    Rectangle {
        id: background
        anchors.fill: parent
        color: Colours.m3surface
        radius: 20
        topLeftRadius: 0
        bottomLeftRadius: 0

        Workspaces {
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin: 20
            }
        }

        Clock {
            anchors.centerIn: parent
        }

        SystemTray {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: statusColumn.top
                bottomMargin: 16
            }
        }

        Column {
            id: statusColumn
            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin: 20
            }
            spacing: 12

            StatusGroup {}

            Rectangle {
                width: 32
                height: 1
                color: Colours.alpha(Colours.m3outline, 0.3)
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 0.5
            }
        }
    }
}
