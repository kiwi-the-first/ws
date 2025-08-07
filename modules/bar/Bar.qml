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

        // todo
        // Workspaces {}
    }
}
