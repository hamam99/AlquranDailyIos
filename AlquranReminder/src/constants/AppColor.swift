import SwiftUI

extension Color {
    /// Initialize Color from hex string (e.g., "#064E3B" or "064E3B")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

// MARK: - Material Design 3 Color Tokens

extension Color {
    // Surface colors
    static let surface = Color(hex: "#f8f9ff")
    static let surfaceDim = Color(hex: "#d0dbed")
    static let surfaceBright = Color(hex: "#f8f9ff")
    static let surfaceContainerLowest = Color(hex: "#ffffff")
    static let surfaceContainerLow = Color(hex: "#eff4ff")
    static let surfaceContainer = Color(hex: "#e6eeff")
    static let surfaceContainerHigh = Color(hex: "#dee9fc")
    static let surfaceContainerHighest = Color(hex: "#d9e3f6")
    static let onSurface = Color(hex: "#121c2a")
    static let onSurfaceVariant = Color(hex: "#404944")
    static let inverseSurface = Color(hex: "#27313f")
    static let inverseOnSurface = Color(hex: "#eaf1ff")

    // Outline colors
    static let outline = Color(hex: "#707974")
    static let outlineVariant = Color(hex: "#bfc9c3")
    static let surfaceTint = Color(hex: "#2b6954")

    // Primary colors
    static let primary = Color(hex: "#003527")
    static let onPrimary = Color(hex: "#ffffff")
    static let primaryContainer = Color(hex: "#064e3b")
    static let onPrimaryContainer = Color(hex: "#80bea6")
    static let inversePrimary = Color(hex: "#95d3ba")
    static let primaryFixed = Color(hex: "#b0f0d6")
    static let primaryFixedDim = Color(hex: "#95d3ba")
    static let onPrimaryFixed = Color(hex: "#002117")
    static let onPrimaryFixedVariant = Color(hex: "#0b513d")

    // Secondary colors
    static let secondary = Color(hex: "#5e5e5c")
    static let onSecondary = Color(hex: "#ffffff")
    static let secondaryContainer = Color(hex: "#e1dfdc")
    static let onSecondaryContainer = Color(hex: "#636360")
    static let secondaryFixed = Color(hex: "#e4e2de")
    static let secondaryFixedDim = Color(hex: "#c8c6c3")
    static let onSecondaryFixed = Color(hex: "#1b1c1a")
    static let onSecondaryFixedVariant = Color(hex: "#474744")

    // Tertiary colors
    static let tertiary = Color(hex: "#3e2b00")
    static let onTertiary = Color(hex: "#ffffff")
    static let tertiaryContainer = Color(hex: "#5a4000")
    static let onTertiaryContainer = Color(hex: "#d3ac64")
    static let tertiaryFixed = Color(hex: "#ffdea5")
    static let tertiaryFixedDim = Color(hex: "#e9c176")
    static let onTertiaryFixed = Color(hex: "#261900")
    static let onTertiaryFixedVariant = Color(hex: "#5d4201")

    // Error colors
    static let error = Color(hex: "#ba1a1a")
    static let onError = Color(hex: "#ffffff")
    static let errorContainer = Color(hex: "#ffdad6")
    static let onErrorContainer = Color(hex: "#93000a")

    // Background
    static let background = Color(hex: "#f8f9ff")
    static let onBackground = Color(hex: "#121c2a")

    // Neutral (legacy alias)
    static let neutral = Color(hex: "#404944")
}
