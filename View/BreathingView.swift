
import SwiftUI

struct BreathingView: View {
    
    @ObservedObject var viewModel: SessionViewModel
    @Environment(\.dismiss) var dismiss
    @State private var isOpen = false
    
    var body: some View {
        ZStack {
            
            // MARK: Background Gradient
            viewModel.activity.gradient
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: Top Header: Close Button
                HStack {
                    Button(action: {
                        viewModel.stopSession()
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
                .padding(.top, 50)
                .padding(.leading, 20)
                
                Spacer()
                
                // MARK: Animated Lotus Image
                Image("Lotus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220)
                    .clipShape(Circle())
                    .scaleEffect(scaleValue)
                    .rotationEffect(.degrees(rotationValue))
                    .shadow(color: .purple.opacity(0.6), radius: shadowValue)
                    .animation(currentAnimation, value:  viewModel.breathingPhase)
                
                // MARK: Breathing Phase Text
                Text(viewModel.breathingPhase.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .transition(.opacity)
                    .id("PhaseText" + viewModel.breathingPhase.rawValue)
                
                Spacer()
                
                // MARK: Timer
                Text(viewModel.formatTime())
                    .font(.system(size: 30, design: .monospaced))
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.bottom, 20)
                
                // MARK: Play/Pause Controls
                HStack(spacing: 50) {
                    if viewModel.isActive {
                        Button(action: {
                            viewModel.pauseSession()
                            AudioManager.shared.stopBackgroundMusic()
                        }) {
                            ControlIcon(name: "pause.fill")
                        }
                    } else {
                        Button(action: {
                            isOpen = true
                            viewModel.startSession()
                            AudioManager.shared.startBackgroundMusic(named: "calm.mp3", loop: true, volume: 0.05)
                        }) {
                            ControlIcon(name: "play.fill")
                        }
                    }
                }
                .padding(.bottom, 50)
            }
        }
        // MARK: Haptic feedback on phase change
        .onChange(of: viewModel.breathingPhase) { _ in
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
    
    private var scaleValue: CGFloat {
        switch  viewModel.breathingPhase {
        case .inhale: return 1.05   // bloom
        case .hold:   return 1.05   // stay open
        case .exhale: return 0.85   // close
        }
    }
    
    private var rotationValue: Double {
        switch  viewModel.breathingPhase {
        case .inhale: return 2
        case .hold:   return 2
        case .exhale: return 0
        }
    }
    
    private var shadowValue: CGFloat {
        switch  viewModel.breathingPhase {
        case .inhale: return 30
        case .hold:   return 30
        case .exhale: return 10
        }
    }
    
    private var currentAnimation: Animation {
        switch viewModel.breathingPhase {
        case .inhale:
            return .easeInOut(duration: 4.0)
            
        case .hold:
            return .linear(duration: 2.5)
            
        case .exhale:
            return .easeInOut(duration: 6.0)
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
        themeColor: "teal"
    )))
}
