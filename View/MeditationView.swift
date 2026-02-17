
import SwiftUI

struct MeditationView: View {
    @ObservedObject var viewModel: SessionViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
                ZStack {
                    // Background
                    viewModel.activity.gradient
                        .ignoresSafeArea()
                    
                    VStack {
                        // Header
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
                        .padding()
                        
                        Spacer()
                // Title and Icon
                VStack(spacing: 20) {
                    Image(systemName: viewModel.activity.iconName)
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.9))
                    
                    Text(viewModel.activity.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(viewModel.activity.description)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                // Timer
                ZStack {
                    Circle()
                        .stroke(lineWidth: 20)
                        .opacity(0.3)
                        .foregroundColor(.white)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(viewModel.progress))
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.white)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear, value: viewModel.progress)
                    
                    Text(viewModel.formatTime())
                        .font(.system(size: 50, weight: .bold, design: .monospaced))
                        .foregroundColor(.white)
                }
                .frame(width: 250, height: 250)
                .padding()
                
                // Controls
                HStack(spacing: 50) {
                    if viewModel.isActive {
                        Button(action: { viewModel.pauseSession()
                            AudioManager.shared.stopBackgroundMusic()}) {
                            ControlIcon(name: "pause.fill")
                        }
                    } else {
                        Button(action: { viewModel.startSession()
                            AudioManager.shared.startBackgroundMusic(named: "lofi.mp3",loop: true,volume: 0.05)}) {
                            ControlIcon(name: "play.fill")
                        }
                    }
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
        .onAppear {
            // Optional: Start automatically or wait for user
        }
    }
}

struct ControlIcon: View {
    let name: String
    var body: some View {
        Image(systemName: name)
            .font(.largeTitle)
            .foregroundColor(Color.zenPrimary)
            .frame(width: 80, height: 80)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}

#Preview {
    MeditationView(viewModel: SessionViewModel(activity: Activity(
        title: "Test Meditation",
        description: "Focus within.",
        duration: 300,
        type: .meditation,
        iconName: "moon.stars.fill",
        themeColor: "purple"
    )))
}
