//
//  BreathingVisualState.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/26/26.
//

import SwiftUI

// MARK: Visual Configuration Model
struct BreathingVisualState {
    let scale: CGFloat
    let rotation: Double
    let shadow: CGFloat
    let animation: Animation
}

// MARK: Phase → Visual Mapping
extension BreathingPhase {

    var visual: BreathingVisualState {

        switch self {

        case .inhale:
            return BreathingVisualState(
                scale: 1.05,
                rotation: 0,
                shadow: 30,
                animation: .easeInOut(duration: 4.0)
            )

        case .hold:
            return BreathingVisualState(
                scale: 1.05,
                rotation: 2,
                shadow: 30,
                animation: .linear(duration: 2.5)
            )

        case .exhale:
            return BreathingVisualState(
                scale: 0.85,
                rotation: 0,
                shadow: 10,
                animation: .easeInOut(duration: 6.0)
            )
        }
    }
}
