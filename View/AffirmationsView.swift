//
//  AffirmationsView.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/3/26.
//

import SwiftUI

struct AffirmationsView: View {
    @StateObject var viewModel = AffirmationsViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var pulse = false  // For pulsing animation
    @State private var rotate = false
    
    var body: some View {
        ZStack {
            // Multi-color gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.teal, Color.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
           
            // Pulsing circle behind affirmation text
            Circle()
                .fill(Color.white.opacity(0.1))
                .scaleEffect(pulse ? 1.2 : 0.9)
                .frame(width: 250, height: 250)
                .blur(radius: 30)
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: pulse)
                .onAppear { pulse = true }
            
            VStack {
                // Header close button
                HStack {
                    Button(action: {
                        viewModel.stopAffirmations()
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
                .padding()
                
               // Spacer()
                
                // Affirmation text + Play button
                VStack(spacing: 50) {
                    Image("yogaSymbol") // PNG with alpha
                                   .resizable()
                                   .scaledToFit()
                                   .clipShape(Circle())
                                   .frame(width: 200, height: 200)
                                   .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                                   .rotationEffect(.degrees(rotate ? 360 : 0)) // full rotation
                                                  .animation(
                                                      Animation.linear(duration: 20) // 8 seconds for full rotation
                                                          .repeatForever(autoreverses: false),
                                       value: rotate
                                   )
                    Text(viewModel.affirmations[viewModel.currentIndex])
                        .font(.largeTitle)
                        .bold()
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                        .opacity(viewModel.fadeIn ? 1 : 0)
                        .animation(.easeInOut(duration: viewModel.animationDuration), value: viewModel.fadeIn)
                    
                    Button(action: {
                        if viewModel.isPlaying {
                            viewModel.stopAffirmations()
                            AudioManager.shared.stopBackgroundMusic()
                        } else {
                            viewModel.startAffirmations()
                            AudioManager.shared.startBackgroundMusic(
                                named: "rain.mp3",
                                loop: true,
                                volume: 0.05
                            )
                        }
                    }) {
                        Text(viewModel.isPlaying ? "Pause" : "Play")
                            .bold()
                            .padding()
                            .frame(width: 140)
                            .background(viewModel.isPlaying ? Color.white.opacity(0.7) : Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .navigationTitle("Affirmations")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            rotate.toggle()
            viewModel.startAffirmations()
            AudioManager.shared.startBackgroundMusic(named: "rain.mp3",loop: true,volume: 0.05)
        }
        .onDisappear {
            viewModel.stopAffirmations()
        }
    }
}


#Preview {
    AffirmationsView()
}
