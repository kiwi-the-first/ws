pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick

QtObject {
    id: root

    //todo add PersistentSettings
    // property string currentTheme: PersistentSettings.settings.darkMode ? "dark" : "light" // add dynamic later
    // property bool isDarkMode: currentTheme === "dark" || (currentTheme === "dynamic" && systemIsDark)
    // property bool systemIsDark: true

    property string currentTheme: "dark"
    property bool isDarkMode: true
    property bool systemIsDark: true

    // onCurrentThemeChanged: {
    //     var shouldbeDark = currentTheme === "dark" || (currentTheme === "dynamic" && systemIsDark);
    //     if (PersistentSettings.settings.darkMode !== shouldbeDark) {
    //         PersistentSettings.settings.darkMode = shouldbeDark;
    //     }
    // }

    // helper functions for alpha transparency and interactive states
    function alpha(color, opacity) {
        return Qt.alpha(color, opacity);
    }

    function hoverColor(baseColor, hoverOpacity = 0.12) {
        return Qt.alpha(baseColor, hoverOpacity);
    }

    function pressedColor(baseColor, pressedOpacity = 0.16) {
        return Qt.alpha(baseColor, pressedOpacity);
    }

    function disabledColor(baseColor, disabledOpacity = 0.38) {
        return Qt.alpha(baseColor, disabledOpacity);
    }

    // Light Theme Colors
    readonly property var lightTheme: ({
            m3primary: "#6750a4",
            m3onPrimary: "#ffffff",
            m3primaryContainer: "#eaddff",
            m3onPrimaryContainer: "#21005d",
            m3secondary: "#625b71",
            m3onSecondary: "#ffffff",
            m3secondaryContainer: "#e8def8",
            m3onSecondaryContainer: "#1d192b",
            m3tertiary: "#7d5260",
            m3onTertiary: "#ffffff",
            m3tertiaryContainer: "#ffd8e4",
            m3onTertiaryContainer: "#31111d",
            m3error: "#ba1a1a",
            m3onError: "#ffffff",
            m3errorContainer: "#ffdad6",
            m3onErrorContainer: "#410002",
            m3surface: "#fffbfe",
            m3onSurface: "#1c1b1f",
            m3surfaceVariant: "#e7e0ec",
            m3onSurfaceVariant: "#49454f",
            m3surfaceContainer: "#f3edf7",
            m3surfaceContainerHigh: "#ece6f0",
            m3surfaceContainerHighest: "#e6e0e9",
            m3inverseSurface: "#313033",
            m3inverseOnSurface: "#f4eff4",
            m3outline: "#79747e",
            m3outlineVariant: "#cac4d0",
            m3shadow: "#000000",
            m3scrim: "#000000"
        })

    // Dark Theme Colors (current colors)
    readonly property var darkTheme: ({
            m3primary: "#d0bcff",
            m3onPrimary: "#371e73",
            m3primaryContainer: "#4f378b",
            m3onPrimaryContainer: "#eaddff",
            m3secondary: "#ccc2dc",
            m3onSecondary: "#332d41",
            m3secondaryContainer: "#4a4458",
            m3onSecondaryContainer: "#e8def8",
            m3tertiary: "#efb8c8",
            m3onTertiary: "#492532",
            m3tertiaryContainer: "#633b48",
            m3onTertiaryContainer: "#ffd8e4",
            m3error: "#f2b8b5",
            m3onError: "#601410",
            m3errorContainer: "#8c1d18",
            m3onErrorContainer: "#f9dedc",
            m3surface: "#1c1b1f",
            m3onSurface: "#e6e0e9",
            m3surfaceVariant: "#49454f",
            m3onSurfaceVariant: "#cac4d0",
            m3surfaceContainer: "#211f26",
            m3surfaceContainerHigh: "#2b2930",
            m3surfaceContainerHighest: "#36343b",
            m3inverseSurface: "#e6e0e9",
            m3inverseOnSurface: "#322f35",
            m3outline: "#938f99",
            m3outlineVariant: "#49454f",
            m3shadow: "#000000",
            m3scrim: "#000000"
        })

    // Material Design 3 Color Palette - Theme-aware
    readonly property color m3primary: isDarkMode ? darkTheme.m3primary : lightTheme.m3primary
    readonly property color m3onPrimary: isDarkMode ? darkTheme.m3onPrimary : lightTheme.m3onPrimary
    readonly property color m3primaryContainer: isDarkMode ? darkTheme.m3primaryContainer : lightTheme.m3primaryContainer
    readonly property color m3onPrimaryContainer: isDarkMode ? darkTheme.m3onPrimaryContainer : lightTheme.m3onPrimaryContainer

    readonly property color m3secondary: isDarkMode ? darkTheme.m3secondary : lightTheme.m3secondary
    readonly property color m3onSecondary: isDarkMode ? darkTheme.m3onSecondary : lightTheme.m3onSecondary
    readonly property color m3secondaryContainer: isDarkMode ? darkTheme.m3secondaryContainer : lightTheme.m3secondaryContainer
    readonly property color m3onSecondaryContainer: isDarkMode ? darkTheme.m3onSecondaryContainer : lightTheme.m3onSecondaryContainer

    readonly property color m3tertiary: isDarkMode ? darkTheme.m3tertiary : lightTheme.m3tertiary
    readonly property color m3onTertiary: isDarkMode ? darkTheme.m3onTertiary : lightTheme.m3onTertiary
    readonly property color m3tertiaryContainer: isDarkMode ? darkTheme.m3tertiaryContainer : lightTheme.m3tertiaryContainer
    readonly property color m3onTertiaryContainer: isDarkMode ? darkTheme.m3onTertiaryContainer : lightTheme.m3onTertiaryContainer

    readonly property color m3error: isDarkMode ? darkTheme.m3error : lightTheme.m3error
    readonly property color m3onError: isDarkMode ? darkTheme.m3onError : lightTheme.m3onError
    readonly property color m3errorContainer: isDarkMode ? darkTheme.m3errorContainer : lightTheme.m3errorContainer
    readonly property color m3onErrorContainer: isDarkMode ? darkTheme.m3onErrorContainer : lightTheme.m3onErrorContainer

    readonly property color m3surface: isDarkMode ? darkTheme.m3surface : lightTheme.m3surface
    readonly property color m3onSurface: isDarkMode ? darkTheme.m3onSurface : lightTheme.m3onSurface
    readonly property color m3surfaceVariant: isDarkMode ? darkTheme.m3surfaceVariant : lightTheme.m3surfaceVariant
    readonly property color m3onSurfaceVariant: isDarkMode ? darkTheme.m3onSurfaceVariant : lightTheme.m3onSurfaceVariant

    readonly property color m3surfaceContainer: isDarkMode ? darkTheme.m3surfaceContainer : lightTheme.m3surfaceContainer
    readonly property color m3surfaceContainerHigh: isDarkMode ? darkTheme.m3surfaceContainerHigh : lightTheme.m3surfaceContainerHigh
    readonly property color m3surfaceContainerHighest: isDarkMode ? darkTheme.m3surfaceContainerHighest : lightTheme.m3surfaceContainerHighest

    readonly property color m3inverseSurface: isDarkMode ? darkTheme.m3inverseSurface : lightTheme.m3inverseSurface
    readonly property color m3inverseOnSurface: isDarkMode ? darkTheme.m3inverseOnSurface : lightTheme.m3inverseOnSurface

    readonly property color m3outline: isDarkMode ? darkTheme.m3outline : lightTheme.m3outline
    readonly property color m3outlineVariant: isDarkMode ? darkTheme.m3outlineVariant : lightTheme.m3outlineVariant

    readonly property color m3shadow: isDarkMode ? darkTheme.m3shadow : lightTheme.m3shadow
    readonly property color m3scrim: isDarkMode ? darkTheme.m3scrim : lightTheme.m3scrim

    // Theme switching function for future dynamic color support
    // function setTheme(themeName) {
    //     if (themeName === "light" || themeName === "dark" || themeName === "dynamic") {
    //         root.currentTheme = themeName;
    //     }
    // }

    // Dynamic color source (placeholder for future implementation)
    property var dynamicColorSource: null

    function updateDynamicColors(colorSource) {
        // Future implementation for dynamic colors from wallpaper/image
        // This would use Material Design 3's dynamic color algorithms to:
        // 1. Extract key colors from the source image/wallpaper
        // 2. Generate a complete color scheme using HCT (Hue, Chroma, Tone) color space
        // 3. Create both light and dark variants
        // 4. Update lightTheme and darkTheme objects with new colors
        root.dynamicColorSource = colorSource;

    // Example future implementation:
    // const keyColor = extractDominantColor(colorSource);
    // const scheme = generateMaterialScheme(keyColor);
    // root.lightTheme = scheme.light;
    // root.darkTheme = scheme.dark;
    }

    // System theme detection (placeholder for future implementation)
    function updateSystemTheme() {
    // This would detect system dark/light mode preference
    // root.systemIsDark = getSystemDarkModePreference();
    }
}
