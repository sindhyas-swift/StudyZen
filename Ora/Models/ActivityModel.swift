
import Foundation
import SwiftUI

enum ActivityType: String, CaseIterable, Codable {
    case meditation
    case breathing
    case affirmation
    case gratitude
    case sigh
    case journal

    @ViewBuilder
    func destinationView(activity: Activity) -> some View {
        switch self {

        case .breathing:
            BreathingView(
                viewModel: SessionViewModel(activity: activity)
            )

        case .affirmation:
            AffirmationsView(
                viewModel: AffirmationsViewModel(activity: activity)
            )

        case .gratitude:
            GratitudeView(
                viewModel: GratefulViewModel(activity: activity)
            )

        case .journal:
            JournalView(viewModel: JournalViewModel(activity: activity))
            
            
        case .sigh:
            GuidedSighView(
                viewModel: GuidedSighViewModel(activity: activity)
            )

        case .meditation:
            MeditationView(
                viewModel: SessionViewModel(activity: activity)
            )
        }
    }
}

enum ActivityCategory: String, CaseIterable, Codable {
    case mind
    case body
}

struct Activity: Identifiable, Codable {
    var id = UUID()
    var title: String
    var description: String
    var duration: TimeInterval // in seconds
    var type: ActivityType
    var iconName: String
    var themeColor: ZenGradient
    var category: ActivityCategory
    
    var gradient: LinearGradient {
        themeColor.gradient
    }
}
    
  
