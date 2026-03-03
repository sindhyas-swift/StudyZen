
import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    
    init() {
        loadActivities()
    }
    
    private func loadActivities() {
        self.activities = [
            Activity(
                title: "Morning Focus",
                description: "Let your thoughts settle before you begin.",
                duration: 300,
                type: .meditation,
                iconName: "sun.max.fill",
                themeColor: .blue,
                category:.body
            ),
            Activity(
                title: "Deep Breathing",
                description: "Calm your mind in 5 minutes.",
                duration: 300,
                type: .breathing,
                iconName: "wind",
                themeColor: .teal,
                category:.body
            ),
            Activity(
                title: "Affirmations",
                description: "Whispers of Encouragement.",
                duration: 90,
                type: .affirmation,
                iconName: "book.fill",
                themeColor: .purple,
                category:.mind
            ),
            Activity(
                title: "Phicological Sigh",
                description: "Fastest way to calm your nervous system",
                duration: 90,
                type: .sigh,
                iconName: "leaf.fill",
                themeColor: .turquoise,
                category:.body
            ),
            Activity(
                title: "Gratefulness",
                description: "Gratitude grows.",
                duration: 180,
                type: .gratitude,
                iconName: "wind",
                themeColor: .lavender,
                category:.mind
            ),
            Activity(
                title: "Journalling",
                description: "Write what your heart is trying to say.",
                duration: 180,
                type: .journal,
                iconName: "book.fill",
                themeColor: .blue,
                category:.mind
            )
        ]
    }
}
