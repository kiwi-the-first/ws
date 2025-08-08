pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import qs.utils

Singleton {
    id: root

    property string shellName: "ws"
    property string settingsDir: (Quickshell.env("XDG_CONFIG_HOME") || Quickshell.env("HOME") + "/.config") + "/quickshell/"
    property string settingsFile: root.settingsDir + "ws_settings.json"
    property alias settings: settingAdapter

    Item {
        Component.onCompleted: {
            //Ensure settings directory exists
            Quickshell.execDetached(["mkdir", "-p", root.settingsDir]);
        }
    }

    FileView {
        id: settingFileView
        path: root.settingsFile
        watchChanges: true
        onFileChanged: reload()
        onAdapterUpdated: writeAdapter()

        Component.onCompleted: {
            DebugUtils.debug("Settings file path:", root.settingsFile);
            reload();
        }

        onLoaded: {
            DebugUtils.debug("Settings loaded successfully");
        }

        onLoadFailed: function (error) {
            DebugUtils.warn("Settings load failed:", error);
            if (error.toString().includes("No such file") || error === 2) {
                // If the file does not exist, create it with default values
                DebugUtils.debug("Creating settings file with defaults");
                writeAdapter();
            }
        }

        onSaved: {
            DebugUtils.debug("Settings saved successfully");
        }

        onSaveFailed: function (error) {
            DebugUtils.error("Settings save failed:", error);
        }

        adapter: JsonAdapter {
            id: settingAdapter

            // Default setting properties
            property bool debugEnabled: false
            property bool clickToReveal: false
            property bool darkMode: true
        }
    }
}
