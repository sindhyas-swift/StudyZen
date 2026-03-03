//
//  GuidedSighView.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/5/26.
//
import SwiftUI

struct GuidedSighView: View {
    
    @ObservedObject var viewModel : GuidedSighViewModel
    @Environment(\.dismiss) var dismiss
    let instructions = [
        "Begin by settling in.",
        "Sit comfortably and relax your shoulders.",
        "Take a deep breath in through your nose.",
        "Gently take another short breath in through your nose.",
        "Slowly exhale through your mouth until your lungs feel empty.",
        "Repeat this three times, noticing your body begin to relax."
    ]
    
    var body: some View {
        ZStack {
            
            // Background Gradient
            viewModel.activity.gradient
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
                .padding(.top, 50)      // Top padding from safe area
                .padding(.leading, 20)   // Leading padding from edge
                
                // Spacer()
                
                // Instruction rows at the center
                VStack(spacing: 16) {
                    ForEach(Array(instructions.enumerated()), id: \.offset) { index, instruction in
                        InstructionRow(text: instruction,
                                       isActive: viewModel.phase == index)
                    }
                    
                    
                    // MARK: - Control Buttons (Start / Pause / Stop)
                    HStack(spacing: 20) {
                        
                        controlButton(title: "Start", action: {
                            viewModel.startBreathing()
                        })
                        
                        controlButton(title: "Pause", action: {
                            viewModel.pauseBreathing()
                        })
                        
                        controlButton(title: "Stop", action: {
                            viewModel.stopBreathing()
                        })
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 40)
                    .padding(.top, 50)
                    
                }
                .padding(.top, 50)
                
                .onDisappear {
                    viewModel.stopBreathing()
                    SpeechManager.shared.stop() // optional: stop speech
                }
            }
        }
    }
    // MARK: - Reusable Capsule Button
    private func controlButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .fill(Color.mint.opacity(0.25)) // matches your instruction capsule tone
                )
                .foregroundColor(.white) // white text
                .shadow(color: .black.opacity(0.50), radius: 8, x: 0, y: 4)
        }
    }
}

#Preview {
    GuidedSighView(viewModel: GuidedSighViewModel(activity: Activity(
        title: "Phicological Sigh",
        description: "Fastest way to calm your nervous system",
        duration: 180,
        type: .sigh,
        iconName: "leaf.fill",
        themeColor: .turquoise,
        category:.body
    )))
}

