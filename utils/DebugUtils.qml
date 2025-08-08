pragma Singleton

import QtQuick
import qs.config

QtObject {
    id: root

    // Info messages - only shown when debug mode is enabled
    function log(message, ...args) {
        if (Appearance.debug.enabled) {
            console.log(message, ...args);
        }
    }

    // Debug messages - same as Info
    function debug(message, ...args) {
        if (Appearance.debug.enabled) {
            console.debug(message, ...args);
        }
    }

    // Warning messages - always shown
    function warn(message, ...args) {
        console.warn(message, ...args);
    }

    // Error messsages - always shown
    function error(message, ...args) {
        console.error(message, ...args);
    }
}
