//
//  GuidedSighView.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/5/26.
//
import SwiftUI

struct GuidedSighView: View {
    
    @StateObject private var viewModel = GuidedSighViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.0, green: 0.5, blue: 0.5),   // Teal
                    Color(red: 0.25, green: 0.88, blue: 0.82) // Turquoise
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
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
                .padding(.top, 50)      // Top padding from safe area
                .padding(.leading, 20)   // Leading padding from edge
                
                Spacer()
                
                // Instruction rows at the center
                VStack(alignment: .center, spacing: 18) {
                    InstructionRow(text: "Sit comfortably, relax your shoulders")
                    InstructionRow(text: "Take a deep inhale through your nose")
                    InstructionRow(text: "Take a second short inhale through your nose")
                    InstructionRow(text: "Slowly exhale through your mouth until your lungs feel empty")
                    InstructionRow(text: "Repeat 3 times and notice your body relaxing")
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Main instruction text
//                Text(viewModel.instructionText)
//                    .font(.largeTitle.bold())
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal, 30)
//                    .animation(.easeInOut, value: viewModel.instructionText)
//                
                Spacer()
                
                // Stop Button
                Button("Stop") {
                    viewModel.stopBreathing()
                }
                .foregroundColor(.teal)
                .fontWeight(.heavy)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(14)
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            viewModel.startBreathing()
        }
        .onDisappear {
            viewModel.stopBreathing()
            SpeechManager.shared.stop() // optional: stop speech
        }
    }
}

#Preview {
    GuidedSighView()
}

