
import SwiftUI

struct ActivityCard: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: activity.iconName)
                        .font(.title2)
                        .foregroundColor(.white)
                    Spacer()
                    Text(formatDuration(activity.duration))
                        .font(.caption)
                        .padding(6)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Capsule())
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text(activity.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(activity.description)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(2)
            }
            .padding()
        }
        .frame(height: 140)
        .background(activity.gradient)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
    
    // Helper for time formatting
    func formatDuration(_ duration: TimeInterval) -> String {
        let minutes = Int(duration) / 60
        return "\(minutes) min"
    }
}

#Preview {
    ActivityCard(activity: Activity(
        title: "Test Activity",
        description: "This is a test description.",
        duration: 300,
        type: .meditation,
        iconName: "star.fill",
        themeColor: "blue"
    ))
    .padding()
}
