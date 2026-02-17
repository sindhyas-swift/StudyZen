
import SwiftUI

extension Color {
    static let zenPrimary = Color(red: 0.2, green: 0.3, blue: 0.7) // Deep soothing blue
    static let zenBackground = Color(red: 0.96, green: 0.96, blue: 0.98) // Off-white/light gray
    static let zenAccent = Color(red: 0.4, green: 0.6, blue: 0.9) // Lighter blue
static let ZenGreen = Color(red: 0.4, green: 1.0, blue: 0.6)
    static let zenTeal = Color(red: 0.2, green: 0.7, blue: 0.7)
    static let zenPurple = Color(red: 0.5, green: 0.3, blue: 0.8)
    static let zenTurquoise = Color(red: 0.25, green: 0.88, blue: 0.82)

}

struct ZenTheme {
    static let gradientMain = LinearGradient(
        gradient: Gradient(colors: [Color.zenPrimary, Color.zenAccent]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let gradientPurple = LinearGradient(
        gradient: Gradient(colors: [Color.zenPurple, Color.zenPrimary]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let gradientTeal = LinearGradient(
        gradient: Gradient(colors: [Color.zenTeal, Color.zenAccent]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let gradienetTurquoise =  LinearGradient(
        gradient: Gradient(colors: [Color.ZenGreen, Color.zenPrimary]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
