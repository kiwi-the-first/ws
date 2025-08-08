pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland
import qs.config

Rectangle {
    id: root
    width: 36
    height: 36
    radius: 16

    property int currentWorkspace: Hyprland.focusedMonitor?.activeWorkspace?.id ?? 1

    color: Colours.alpha(Colours.m3primary, 0.1)
    border.width: 1
    border.color: Colours.alpha(Colours.m3outline, 0.2)

    Behavior on color {
        ColorAnimation {
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    Text {
        anchors.centerIn: parent
        text: root.currentWorkspace.toString()
        font.family: Appearance.font.family.display
        font.pointSize: Appearance.font.size.body
        font.weight: Font.Medium
        color: Colours.m3primary
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 150
            easing.type: Easing.OutQuad
        }
    }
}

// todo add workspaces overview later
