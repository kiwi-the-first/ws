import Quickshell
import QtQuick
import qs.services as Services
import qs.widgets as Widgets
import qs.config

Rectangle {
    id: root

    property color colour: "#ffffff"

    implicitWidth: 44
    implicitHeight: content.implicitHeight + 16
    radius: Appearance.rounding.large
    color: hoverArea.containsMouse ? Qt.alpha(Colours.m3primary, 0.08) : "transparent"

    Behavior on color {
        ColorAnimation {
            duration: 400
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
        }
    }

    Behavior on scale {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    SystemClock {
        id: systemClock
        precision: SystemClock.Minutes
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onPressed: root.scale = 0.95
        onReleased: root.scale = 1.0
        onCanceled: root.scale = 1.0

        // onClicked: {
        //     Services.CalendarManager.toggleCalendar();
        // }
        //
        // onEntered: {
        //     if (Services.CalendarManager.hoverMode) {
        //         Services.CalendarManager.stopHideTimer(); // Cancel any pending hide
        //         Services.CalendarManager.showCalendar();
        //     }
        // }
        //
        // onExited: {
        //     if (Services.CalendarManager.hoverMode) {
        //         Services.CalendarManager.startHideTimer(); // Start delay before hiding
        //     }
        // }
    }

    Column {
        id: content
        anchors.centerIn: parent
        spacing: 4

        Widgets.MaterialIcon {
            id: calendarIcon
            anchors.horizontalCenter: parent.horizontalCenter
            animate: true

            text: "calendar_month"
            color: Colours.m3onSurface
            font.pointSize: Appearance.font.size.larger
            fill: hoverArea.containsMouse ? 1 : 0
            grade: hoverArea.containsMouse ? 0 : -25

            Behavior on grade {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
                }
            }
        }

        // Time display
        Widgets.StyledText {
            id: timeText
            anchors.horizontalCenter: parent.horizontalCenter
            animate: true

            horizontalAlignment: Text.AlignHCenter
            text: Qt.formatDateTime(systemClock.date, "HH\nmm")
            color: Colours.m3onSurfaceVariant
            font.pointSize: Appearance.font.size.medium
            font.family: Appearance.font.family.display
            font.weight: 500

            opacity: hoverArea.containsMouse ? 1.0 : 0.8

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
        }
    }
}
