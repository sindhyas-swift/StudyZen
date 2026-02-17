
import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    
    init() {
        // Load sample data
        loadActivities()
    }
    
    private func loadActivities() {
        self.activities = [
            Activity(
                title: "Morning Focus",
                description: "Let your thoughts settle before you begin.",
                duration: 300, // 10 mins
                type: .meditation,
                iconName: "sun.max.fill",
                themeColor: "blue"
            ),
            Activity(
                title: "Deep Breathing",
                description: "Calm your mind in 5 minutes.",
                duration: 300,
                type: .breathing,
                iconName: "wind",
                themeColor: "teal"
            ),
            Activity(
                title: "Affirmations",
                description: "Whispers of Encouragement.",
                duration: 180,
                type: .affirmation,
                iconName: "book.fill",
                themeColor: "purple"
            ),
            Activity(
                           title: "Phicological Sigh",
                           description: "Fastest ways to calm your nervous system",
                           duration: 180,
                           type: .sigh,
                           iconName: "leaf.fill",
                           themeColor: "turquoise"
                       ),
            Activity(
                title: "Gratefulness",
                description: "Gratitude grows.",
                duration: 180,
                type: .grateful,
                iconName: "wind",
                themeColor: "purple"
            ),
        ]
    }
}
