//
//  GratefulnessViewModelswift.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/3/26.
//
import SwiftUI
import Combine

class GratefulViewModel: ObservableObject {
    
    @Published var points: Int = 0
    @Published var logs: [String] = [] // List of gratitude entries
    @Published var activity: Activity
    
    init(activity: Activity) {
           self.activity = activity
       }
    
    // Add a new gratitude entry
    func addGratitude(_ text: String) {
        logs.append(text)
        points += 1  // earn a point per entry
    }

    // Optional: redeem points for a reward
    func redeemPoints(amount: Int) {
        guard points >= amount else { return }
        points -= amount
        // trigger reward, e.g., show animation or badge
    }
}

