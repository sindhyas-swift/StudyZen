//
//  AffirmationsView.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/3/26.
//

import SwiftUI

struct AffirmationsView: View {
    @ObservedObject var viewModel : AffirmationsViewModel
    @Environment(\.dismiss) var dismiss
    @State private var pulse = false
    
    var body: some View {
        ZStack {
            viewModel.activity.gradient
                .ignoresSafeArea()
            
            VStack {
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
                
                VStack(spacing: 50) {
                    ZStack {
                        Image("affirm2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .rotationEffect(.degrees(viewModel.isPlaying  ? -360 : 0))
                        Image("affirm1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .rotationEffect(.degrees(viewModel.isPlaying ? 360 : 0))
                    }
                    .frame(width: 200, height: 200, alignment: .center)
                    .animation(
                        viewModel.isPlaying ?
                            .linear(duration: 20)
                            .repeatForever(autoreverses: false):.default,
                        value: viewModel.isPlaying
                    )
                    Text(viewModel.affirmations[viewModel.currentIndex])
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .opacity(viewModel.fadeIn ? 1 : 0)
                        .animation(.easeInOut(duration: viewModel.animationDuration), value: viewModel.fadeIn)
                    
                    Button(action: {
                        if viewModel.isPlaying {
                            viewModel.stopAffirmations()
                            AudioManager.shared.pauseBackgroundMusic()
                        } else {
                            viewModel.startAffirmations()
                            AudioManager.shared.resumeBackgroundMusic()
                        }
                    }) {
                        Text(viewModel.isPlaying ? "Pause" : "Play")
                            .bold()
                            .padding()
                            .frame(width: 140)
                            .background(viewModel.isPlaying ? Color.white.opacity(0.7) :Color(.zenLavender.opacity(0.8)))
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
            viewModel.startAffirmations()
            AudioManager.shared.startBackgroundMusic(named: "rain.mp3",loop: true,volume: 0.05)
        }
        .onDisappear {
            viewModel.stopAffirmations()
        }
    }
}


#Preview {
    AffirmationsView(viewModel: AffirmationsViewModel(activity: Activity(   title: "Affirmations",
        description: "Whispers of Encouragement.",
        duration: 180,
        type: .affirmation,
        iconName: "book.fill",
        themeColor: .purple,
        category:.mind)))
}
