
import SwiftUI

import SwiftUI

struct BreathingView: View {

    @ObservedObject var viewModel: SessionViewModel
    @Environment(\.dismiss) var dismiss

    // Single source of animation truth
    private var visual: BreathingVisualState {
        viewModel.breathingPhase.visual
    }
    var body: some View {

        ZStack {

            // MARK: Background
            viewModel.activity.gradient
                .ignoresSafeArea()

            VStack {

                // MARK: Header
                HStack {
                    Button {
                        viewModel.stopSession()
                        AudioManager.shared.stopBackgroundMusic()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }

                    Spacer()
                }
                .padding(.top, 50)
                .padding(.leading, 20)

                Spacer()

                // MARK: Animated Lotus
                Image("chakra")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220)
                    .clipShape(Circle())
                    // Initial resting size → bloom on start
                    .scaleEffect(viewModel.isActive ? visual.scale : 0.6)
                    .rotationEffect(.degrees(visual.rotation))
                    .shadow(color: .purple.opacity(0.6),
                            radius: visual.shadow)
                    // animate session start
                    .animation(.easeInOut(duration: 4.0),
                               value: viewModel.isActive)
                    // animate breathing transitions
                    .animation(visual.animation,
                               value: viewModel.breathingPhase)

                // MARK: Phase Text
                Text(viewModel.breathingPhase.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .transition(.opacity)
                    .id("PhaseText\(viewModel.breathingPhase.rawValue)")

                Spacer()

                // MARK: Timer
                Text(viewModel.formatTime())
                    .font(.system(size: 30, design: .monospaced))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 20)

                // MARK: Controls
                HStack(spacing: 50) {

                    if viewModel.isActive {

                        Button {
                            viewModel.stopSession()
                            AudioManager.shared.stopBackgroundMusic()
                        } label: {
                            ControlIcon(name: "stop.fill")
                        }

                    } else {

                        Button {
                            viewModel.startSession()

                            AudioManager.shared.startBackgroundMusic(
                                named: "breathe.mp3",
                                loop: true,
                                volume: 0.05
                            )
                        } label: {
                            ControlIcon(name: "play.fill")
                        }
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .onChange(of: viewModel.isCompleted) { completed in
            if completed {
                AudioManager.shared.stopBackgroundMusic()
            }
        }
    }
}

   
#Preview {
    BreathingView(viewModel: SessionViewModel(activity: Activity(
        title: "Deep Breathing",
        description: "Focus on your breath.",
        duration: 300,
        type: .breathing,
        iconName: "wind",
        themeColor: .teal,
        category: .body
    )))
}
