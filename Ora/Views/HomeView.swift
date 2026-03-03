
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedActivity: Activity?
    @State private var selectedCategory: String = "All"
    
    private var filteredActivities: [Activity] {
        switch selectedCategory {
        case "Somatic awareness":
            return viewModel.activities.filter { $0.category == .body}
        case "Cognitive Awareness":
            return viewModel.activities.filter { $0.category == .mind }
        default:
            return viewModel.activities // "All"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Header
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Calm mind for a Sharper focus.")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .padding(.top)
                    
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(["All", "Somatic awareness","Cognitive Awareness"], id: \.self) { category in
                                CategoryPill(
                                    title: category,
                                    isSelected: selectedCategory == category
                                )
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        selectedCategory = category
                                    }
                                }
                            }
                        }
                    }
                    
                    Text("Recommended for you")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    // Activity List
                    LazyVStack(spacing: 16) {
                        ForEach(filteredActivities) { activity in
                            ActivityCard(activity: activity)
                                .onTapGesture {
                                    selectedActivity = activity
                                }
                        }
                    }
                }
                .padding()
            }
            .background(Color.zenBackground.ignoresSafeArea())
            .navigationTitle("") // Hidden title for custom header look
            .toolbar(.hidden)
            .fullScreenCover(item: $selectedActivity) { activity in
                activity.type.destinationView(activity: activity)
            }        }
    }
}

// Temporary internal component for pills
struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.medium)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(isSelected ? Color.zenPrimary : Color.white)
            .foregroundColor(isSelected ? .white : .gray)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    HomeView()
}
