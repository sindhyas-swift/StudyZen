
import Foundation
import SwiftUI

enum ActivityType: String, CaseIterable, Codable {
    case meditation
    case breathing
    case affirmation
    case grateful
    case sigh
}

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var duration: TimeInterval // in seconds
    var type: ActivityType
    var iconName: String
    var themeColor: String // "blue", "purple", "teal","turquoise"
    
    // Helper to get helper gradient based on string
    var gradient: LinearGradient {
        switch themeColor {
        case "purple": return ZenTheme.gradientPurple
        case "teal": return ZenTheme.gradientTeal
        case "turquoise": return ZenTheme.gradienetTurquoise
        default: return ZenTheme.gradientMain
        }
    }
}
