
import SwiftUI

struct JournalView: View {

    @State private var journalText: String = ""
    @State private var particles: [DustParticle] = []
    @State private var dissolve = false
    @State private var magicGlow = false
    @State private var textBlur: CGFloat = 0
    @State private var textScale: CGFloat = 1
    @ObservedObject var viewModel : JournalViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            
            // MARK: Paper background
            viewModel.activity.gradient
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
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
                // MARK: Notebook Page (FULL SCREEN FEEL)
                ZStack(alignment: .topLeading) {
                    
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .padding(.horizontal, 28)   // outer left/right space
                        .padding(.top, 24)          // space from top
                        .padding(.bottom, 8)
                        .shadow(color: .black.opacity(0.12), radius: 18, y: 6)
                    NotebookLines()
                        .padding(.horizontal, 28) // creates page borders
                    
                    TextEditor(text: $journalText)
                        .foregroundColor(.black) // works sometimes for caret color
                        .tint(.black)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 44)
                        .padding(24)
                        .font(.system(size: 18, design: .serif))
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                        .opacity(dissolve ? 0 : 1)
                        .scaleEffect(textScale)
                        .blur(radius: textBlur)
                        .overlay(
                            magicGlow ?
                            Color.yellow.opacity(0.35)
                                .blendMode(.plusLighter)
                                .blur(radius: 18)
                                .allowsHitTesting(false)
                            : nil
                        )
                        .animation(.easeOut(duration: 0.9), value: textBlur)
                }
                // MARK: Release Button
                Button {
                    startPixieDust()
                } label: {
                    
                    HStack(spacing: 10) {
                        Image(systemName: "sparkles")
                            .foregroundColor(Color.yellow.opacity(0.9)) // warm gold
                            .font(.title2)
                        
                        
                        MagicalGradientText(text: "Release Thoughts")
                    }
                }
                
                // MARK: Pixie Dust Layer
                ForEach(particles) { particle in
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    .white,
                                    .teal.opacity(0.8),
                                    .blue.opacity(0.7)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .frame(width: particle.size,
                               height: particle.size)
                        .position(particle.position)
                        .opacity(particle.opacity)
                        .blur(radius: 1.5)
                }
            }
            .animation(.easeInOut(duration: 0.8), value: dissolve)
        }
                     .onAppear {
                         AudioManager.shared.startBackgroundMusic(named: "lofi.mp3",loop: true,volume: 0.01)
                     }
                     .onDisappear {
                         AudioManager.shared.stopBackgroundMusic()
                     }
    }
    
    struct NotebookLines: View {

        var body: some View {
            GeometryReader { geo in
                Path { path in
                    let spacing: CGFloat = 28

                    for y in stride(from: spacing,
                                    through: geo.size.height,
                                    by: spacing) {
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geo.size.width, y: y))
                    }
                }
                // soft graphite notebook line
                .stroke(Color.black.opacity(0.18), lineWidth: 1)
            }
            .padding(.top, 24)
        }
    }
    
    private func startPixieDust() {
        
        guard !journalText.isEmpty else { return }
        
        // Phase 1 — magical activation
        withAnimation(.easeIn(duration: 0.35)) {
            magicGlow = true
            textScale = 1.03
        }
        
        // Phase 2 — dissolve begins
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            
            dissolve = true
            
            withAnimation(.easeOut(duration: 0.9)) {
                textBlur = 8
                textScale = 0.96
            }
            
            createParticles()
        }
        
        // Phase 3 — clear journal
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            
            journalText = ""
            
            magicGlow = false
            textBlur = 0
            textScale = 1
            dissolve = false
            particles.removeAll()
        }
    }
    private func createParticles() {
        
        particles.removeAll()
        
        for _ in 0..<160 {
            
            let particle = DustParticle(
                position: CGPoint(
                    x: CGFloat.random(in: 40...360),
                    y: CGFloat.random(in: 250...650)
                ),
                size: CGFloat.random(in: 2...6),
                opacity: 1
            )
            
            particles.append(particle)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            
            for i in particles.indices {
                
                particles[i].position.y -= CGFloat.random(in: 180...320)
                particles[i].position.x += CGFloat.random(in: -80...80)
                particles[i].opacity = 0
            }
        }
    }
}

#Preview{
    JournalView(viewModel: JournalViewModel(  activity: Activity(
        title: "Journalling",
        description: "Write what your heart is trying to say.",
        duration: 180,
        type: .journal,
        iconName: "book.fill",
        themeColor: .blue,
        category:.mind
    )))
}
