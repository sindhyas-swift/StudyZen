
            import SwiftUI

            struct GratitudeView: View {

                @State private var answers: [String] = Array(repeating: "", count: questions.count)
                @State private var currentQuestionIndex = 0
                @State private var showThankYou = false
                @ObservedObject var viewModel : GratefulViewModel
                @Environment(\.dismiss) var dismiss
              

                static let questions = [
                    "What are you grateful for today?",
                    "Who made a positive difference in your day?",
                    "What small joy did you notice today?",
                    "What is one thing you appreciate about yourself today?",
                    "What is something that made you smile?"
                ]

                var body: some View {
                    ZStack {
                        // Calm background
                        viewModel.activity.gradient
                        .ignoresSafeArea()
                        VStack(spacing: 24) {
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
                            .padding()
                            

                            if !showThankYou {
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(Self.questions[currentQuestionIndex])
                                        .font(.title2)
                                        .foregroundColor(.white)
                                        .bold()
                                        .transition(.opacity.combined(with: .slide))

                                    TextEditor(text: $answers[currentQuestionIndex])
                                        .frame(height: 120)
                                        .padding(12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white.opacity(0.9))
                                        )
                                        .font(.system(size: 18, design: .serif))
                                }
                                .padding(.horizontal, 20)

                                Button {
                                    goToNextQuestion()
                                } label: {
                                    Text(currentQuestionIndex < Self.questions.count - 1 ? "Next" : "Finish")
                                    
                                   
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 14)
                                        .frame(width: 140)
                                        .background(
                                            Capsule()
                                                .fill(Color.white.opacity(0.25)) // matches your instruction capsule tone
                                        )
                                        .foregroundColor(.white) // white text
                                        .shadow(color: .black.opacity(0.50), radius: 8, x: 0, y: 4)
                                }
                                .padding(.horizontal, 20)
                                .transition(.opacity)
                            } else {
                                VStack(spacing: 24) {
                                    Text("✨ Thank you for reflecting ✨")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)

                                    Text("Your gratitude can help you feel calmer, happier, and more present today.")
                                        .foregroundColor(.white.opacity(0.9))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 20)
                                }
                                .transition(.opacity)
                            }

                            Spacer()
                        }
                        .animation(.easeInOut, value: currentQuestionIndex)
                    }
                    .onAppear {
                        AudioManager.shared.startBackgroundMusic(named: "lofi.mp3")
                    }
                    .onDisappear {
                        AudioManager.shared.stopBackgroundMusic()
                    }
                }

                private func goToNextQuestion() {
                    if currentQuestionIndex < Self.questions.count - 1 {
                        currentQuestionIndex += 1
                    } else {
                        showThankYou = true
                    }
                }
            }

#Preview {
    GratitudeView(viewModel: GratefulViewModel(activity: Activity(
        title: "Gratefulness",
        description: "Gratitude grows.",
        duration: 180,
        type: .gratitude,
        iconName: "wind",
        themeColor: .purple,
        category:.mind)))
}
