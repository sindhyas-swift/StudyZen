
import SwiftUI

extension LinearGradient {
    static func zen(_ colors: [Color]) -> LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: colors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

enum ZenGradient: String, CaseIterable, Codable {
    case main
    case purple
    case teal
    case turquoise
    case green
    case lavender
    case blue

    var gradient: LinearGradient {
        switch self {
        case .blue:
            return .zen([Color.zenPrimary, Color.zenAccent])

        case .purple:
            return .zen([Color.zenPurple, Color.zenPrimary])

        case .teal:
            return .zen([Color.zenTeal, Color.zenAccent])

        case .turquoise:
            return .zen([Color.zenGreen, Color.zenPrimary])

        case .green:
            return .zen([Color.mint,Color.zenTeal,Color.zenTurquoise])

        case .lavender:
            return .zen([Color.zenPurple,Color.zenLavender,Color.zenPurple])
        case .main:
            return .zen([Color.zenPrimary, Color.zenAccent])
        }
    }
}
