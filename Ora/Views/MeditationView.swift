
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
                    
                    Text("Peace begins the moment you choose to be present.")
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
                                Button(action: {
                                    viewModel.pauseSession()    // pauses session
                                    // music is automatically paused in pauseSession()
                                }) {
                                    ControlIcon(name: "pause.fill")
                                }
                            } else {
                                Button(action: {
                                       // resumes session
                                    if viewModel.isPaused {
                                        AudioManager.shared.resumeBackgroundMusic()
                                        // resume music if previously paused
                                    } else {
                                        AudioManager.shared.startBackgroundMusic(
                                            named: "lofi.mp3",
                                            loop: true,
                                            volume: 0.05
                                        )
                                    }
                                    viewModel.startSession()
                                }) {
                                    ControlIcon(name: "play.fill")
                                }
                            }
                        }                .padding(.bottom, 50)
                
                Spacer()
            }
        }
        .onAppear {
            // Optional: Start automatically or wait for user
        }
        .onChange(of: viewModel.isActive) { isActive in
            if !isActive && !viewModel.isPaused {
                AudioManager.shared.stopBackgroundMusic()  // stop only if session ended, not on pause
            }
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
        title: "Meditation",
        description: "Focus within.",
        duration: 300,
        type: .meditation,
        iconName: "moon.stars.fill",
        themeColor: .purple,
        category: .body
    )))
}
