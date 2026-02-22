//
//  GratefulnessViewModelswift.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/3/26.
//

import Foundation
import SwiftUI
import Combine

class GratefulnessViewModel: ObservableObject {
    @Published var gratitudes: [String] = [
        "🌸 I am thankful for my health and well-being.",
        "🌸 I appreciate my family and friends.",
        "🌸 I am grateful for the opportunities I have today.",
        "🌸 I value the lessons I’ve learned from challenges.",
        "🌸 I notice and appreciate the beauty around me."]
      

    @Published var newGratitudeText: String = ""
    
    
    func addGratitude() {
        let trimmed = newGratitudeText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        withAnimation {
            gratitudes.insert(trimmed, at: 0)
            newGratitudeText = ""
        }
    }
    
    func deleteGratitude(at offsets: IndexSet) {
        withAnimation {
            gratitudes.remove(atOffsets: offsets)
        }
    }
}
