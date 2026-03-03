//
//  TwoPageJournalView.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/22/26.
//

import SwiftUI
import Combine

struct JournalView: View {
    
    @Environment(\.dismiss) var dismiss  // Dismiss screen
    
    var body: some View {
        ZStack {
            // Vintage background gradient
            LinearGradient(
                colors: [Color.zenLavender,Color.zenPurple,Color.zenLavender
                        ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                
                // Close Button at top-left with padding
                HStack {
                    Button(action: {
                        AudioManager.shared.stopBackgroundMusic()
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding()      // Top padding from safe area
                
                VStack(spacing: 50) {
                    // MARK: Header
                    
                    Text("Write what your heart is trying to say.")
                        .font(.custom("Nunito-Regular", size: 18))
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 30)
                    
                }
            }
        }
    }
}

#Preview {
    JournalView(viewModel:VintageJournalViewModel(activity:Activity(Activity(
        title: "Journalling",
        description: "Write what your heart is trying to say.",
        duration: 180,
        type: .journal,
        iconName: "book.fill",
        themeColor: "green",
        category:.mind)))
}
