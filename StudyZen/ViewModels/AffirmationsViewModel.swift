//
//  AffirmationsViewModel.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/3/26.
//

import SwiftUI
import Combine

class AffirmationsViewModel: ObservableObject {
    // List of affirmations
    @Published var affirmations: [String] = [
        "I am calm and centered.",
        "Challenges make me stronger and smarter.",
        "I trust my ability to understand and retain knowledge.",
        "Distractions fade away as I concentrate.",
        "I attract positivity into my life.",
        "Each session brings me closer to my goals.",
        "I celebrate every small victory in my progress.",
        "I remain calm even when tasks feel challenging.",
        "My mind is a calm and fertile space for learning."
    ]
    // Current displayed affirmation index
    @Published var currentIndex: Int = 0
    
    // Fade in/out animation state
    @Published var fadeIn: Bool = false
    
    // Play control
    @Published var isPlaying: Bool = false
    
    private var timer: Timer?
    
    // Animation and display timing
    let animationDuration: TimeInterval = 1.0
    let displayDuration: TimeInterval = 2.0
    
    
    // MARK: - Start animation loop
    func startAffirmations() {
        guard !isPlaying else { return }
        isPlaying = true
        fadeIn = true
        
        timer = Timer.scheduledTimer(withTimeInterval: displayDuration + animationDuration * 4, repeats: true) { [weak self] _ in
            self?.nextAffirmation()
        }
    }
    
    // MARK: - Stop animation loop
    func stopAffirmations() {
        isPlaying = false
        timer?.invalidate()
        timer = nil
    }
    
    func nextAffirmation() {
            // Fade out
            withAnimation {
                fadeIn = false
            }
    
    // MARK
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) { [weak self] in
                  guard let self = self else { return }
                  
                  // Increment index, loop back if needed
                  self.currentIndex = (self.currentIndex + 1) % self.affirmations.count
                  
                  // Fade in
                  withAnimation {
                      self.fadeIn = true
                  }
              }
          }
      }
