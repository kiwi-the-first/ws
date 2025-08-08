pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.utils
import qs.config

Column {
    id: root
    spacing: 8
    width: 40

    // Context menu for system tray items
    PopupWindow {
        id: contextMenu
        implicitWidth: 200
        implicitHeight: Math.max(40, menuListView.contentHeight + 12)
        visible: false
        color: "transparent"

        property var menu: null
        property var anchorItem: null
        property bool menuHovered: false

        anchor.item: anchorItem
        anchor.rect.x: 54
        anchor.rect.y: -4

        function showAt(item) {
            if (!item) {
                DebugUtils.log("SystemTray: Cannot show menu - no anchor item");
                return;
            }
            anchorItem = item;
            visible = true;
            Qt.callLater(() => contextMenu.anchor.updateAnchor());
        }

        function hideMenu() {
            visible = false;
        // menuHovered = false;
        }

        Item {
            anchors.fill: parent
            Keys.onEscapePressed: contextMenu.hideMenu()
        }

        QsMenuOpener {
            id: menuOpener
            menu: contextMenu.menu
        }

        Rectangle {
            anchors.fill: parent
            color: Colours.m3surfaceContainerHigh
            border.color: Colours.alpha(Colours.m3outline, 0.3)
            border.width: 1
            radius: Appearance.rounding.normal
        }

        ListView {
            id: menuListView
            anchors.fill: parent
            anchors.margins: 6
            spacing: 2
            interactive: false
            enabled: contextMenu.visible
            clip: true

            model: ScriptModel {
                values: menuOpener.children ? [...menuOpener.children.values] : []
            }

            delegate: Rectangle {
                id: menuEntry
                required property var modelData

                width: menuListView.width
                height: (menuEntry.modelData?.isSeparator) ? 8 : 32
                color: "transparent"
                radius: Appearance.rounding.smaller

                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width - 8
                    height: 1
                    color: Colours.alpha(Colours.m3outline, 0.4)
                    visible: menuEntry.modelData?.isSeparator ?? false
                }

                Rectangle {
                    anchors.fill: parent
                    color: menuMouseArea.containsMouse ? Colours.alpha(Colours.m3outline, 0.2) : "transparent"
                    radius: Appearance.rounding.smaller
                    visible: !(menuEntry.modelData?.isSeparator ?? false)

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 8

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width - 20
                            color: (menuEntry.modelData?.enabled ?? true) ? Colours.m3onSurface : Colours.m3onSurfaceVariant
                            text: menuEntry.modelData?.text ?? ""
                            font.family: Appearance.font.family.display
                            font.pointSize: Appearance.font.size.small
                            elide: Text.ElideRight
                        }

                        Image {
                            anchors.verticalCenter: parent.verticalCenter
                            width: 16
                            height: 16
                            source: menuEntry.modelData?.icon ?? ""
                            visible: (menuEntry.modelData?.icon ?? "") !== ""
                            smooth: true
                        }
                    }

                    MouseArea {
                        id: menuMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        enabled: (menuEntry.modelData?.enabled ?? true) && !(menuEntry.modelData?.isSeparator ?? false) && contextMenu.visible
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            if (menuEntry.modelData && !menuEntry.modelData.isSeparator) {
                                DebugUtils.log("SystemTray: Menu item clicked:", menuEntry.modelData.text);
                                menuEntry.modelData.triggered();
                                contextMenu.hideMenu();
                            }
                        }
                    }
                }
            }
        }
    }

    // Background container similar to StatusGroup
    Rectangle {
        width: 44
        height: repeater.count > 0 ? (repeater.count * 32 + (repeater.count - 1) * 8 + 16) : 0
        radius: Appearance.rounding.large
        anchors.horizontalCenter: parent.horizontalCenter
        visible: repeater.count > 0

        color: Colours.alpha(Colours.m3primary, 0.05)
        border.width: 1
        border.color: Colours.alpha(Colours.m3outline, 0.08)

        // Subtle background gradient
        Rectangle {
            anchors.fill: parent
            radius: parent.radius
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: Colours.alpha(Colours.m3primary, 0.02)
                }
                GradientStop {
                    position: 1.0
                    color: "transparent"
                }
            }
        }

        Column {
            anchors.centerIn: parent
            spacing: 8

            Repeater {
                id: repeater
                model: SystemTray.items

                Rectangle {
                    required property SystemTrayItem modelData

                    width: 32
                    height: 32
                    radius: Appearance.rounding.normal
                    color: mouseArea.containsMouse ? Colours.alpha(Colours.m3outline, 0.2) : "transparent"
                    // Remove individual borders
                    border.width: 0

                    Image {
                        id: trayIcon
                        anchors.centerIn: parent
                        width: 20
                        height: 20
                        source: {
                            let icon = parent.modelData.icon || "";
                            if (!icon)
                                return "";

                            // Handle special icon path format used by some applications
                            if (icon.includes("?path=")) {
                                const [name, path] = icon.split("?path=");
                                const fileName = name.substring(name.lastIndexOf("/") + 1);
                                return `file://${path}/${fileName}`;
                            }
                            return icon;
                        }
                        smooth: true
                        mipmap: true
                        asynchronous: true

                        // Fallback for missing icons
                        Rectangle {
                            anchors.fill: parent
                            visible: trayIcon.status === Image.Error || !trayIcon.source
                            color: Colours.alpha(Colours.m3outline, 0.3)
                            radius: Appearance.rounding.small

                            Text {
                                anchors.centerIn: parent
                                text: "?"
                                font.family: Appearance.font.family.display
                                font.pointSize: Appearance.font.size.smaller
                                color: Colours.m3onSurface
                            }
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        cursorShape: Qt.PointingHandCursor

                        onClicked: function (mouse) {
                            if (!parent.modelData)
                                return;

                            DebugUtils.log("SystemTray: Click detected, button:", mouse.button);
                            DebugUtils.log("SystemTray: Item title:", parent.modelData.title);
                            DebugUtils.log("SystemTray: Item id:", parent.modelData.id);
                            DebugUtils.log("SystemTray: Item hasMenu:", parent.modelData.hasMenu);
                            DebugUtils.log("SystemTray: Item onlyMenu:", parent.modelData.onlyMenu);

                            if (mouse.button === Qt.LeftButton) {
                                // Close any open context menu first
                                if (contextMenu.visible) {
                                    contextMenu.hideMenu();
                                }

                                DebugUtils.log("SystemTray: Left click - checking onlyMenu flag");
                                if (!parent.modelData.onlyMenu) {
                                    DebugUtils.log("SystemTray: Calling activate() - not menu-only");
                                    parent.modelData.activate();
                                } else {
                                    DebugUtils.log("SystemTray: Skipping activate() - item is menu-only");
                                }
                            } else if (mouse.button === Qt.RightButton) {
                                // Only handle right-click in click mode
                                DebugUtils.log("SystemTray: Right click - checking for context menu");

                                // If menu is already visible, close it
                                if (contextMenu.visible) {
                                    contextMenu.hideMenu();
                                    return;
                                }

                                // Show context menu
                                showContextMenu();
                            }
                        }

                        function showContextMenu() {
                            if (parent.modelData && parent.modelData.hasMenu) {
                                DebugUtils.log("SystemTray: Showing context menu for:", parent.modelData.title);
                                try {
                                    // Safely assign menu with null check
                                    contextMenu.menu = parent.modelData.menu || null;
                                    if (contextMenu.menu) {
                                        contextMenu.showAt(parent);
                                    } else {
                                        throw new Error("Menu is null or undefined");
                                    }
                                } catch (error) {
                                    DebugUtils.log("SystemTray: Error showing context menu:", error);
                                    DebugUtils.log("SystemTray: Falling back to secondaryActivate()");
                                    if (parent.modelData.secondaryActivate) {
                                        parent.modelData.secondaryActivate();
                                    }
                                }
                            } else {
                                DebugUtils.log("SystemTray: No context menu available, calling secondaryActivate()");
                                if (parent.modelData.secondaryActivate) {
                                    parent.modelData.secondaryActivate();
                                } else {
                                    DebugUtils.log("SystemTray: No secondaryActivate method available");
                                }
                            }
                        }
                    }

                    // Simple tooltip using Rectangle
                    Rectangle {
                        property SystemTrayItem item: parent.modelData
                        visible: mouseArea.containsMouse && item.title
                        anchors.bottom: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 8
                        width: tooltipText.width + 16
                        height: tooltipText.height + 8
                        color: Colours.m3onSurface
                        border.color: Colours.alpha(Colours.m3outline, 0.3)
                        border.width: 1
                        radius: Appearance.rounding.smaller
                        z: 100

                        Text {
                            id: tooltipText
                            anchors.centerIn: parent
                            text: parent.item.title || ""
                            font.family: Appearance.font.family.display
                            font.pointSize: Appearance.font.size.small
                            color: Colours.m3onSurface
                        }
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.OutQuad
                        }
                    }
                }
            }
        }
    }
}
