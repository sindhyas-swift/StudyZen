import SwiftUI
import Combine

class GuidedSighViewModel: ObservableObject {
    
    @Published var instructionText: String = "Get Ready"
    @Published var scale: CGFloat = 1.0
    @Published var currentRound = 0
    
    private var timer: Timer?
    private var phase = 0
  
    let totalRounds = 3
    
    func startBreathing() {
        AudioManager.shared.startBackgroundMusic(
            named: "calm.mp3",
            loop: true,
            volume: 0.02
        )
        currentRound = 1
        phase = 0
        runPhase()
    }
    
    func stopBreathing() {
        timer?.invalidate()
        AudioManager.shared.stopBackgroundMusic()
    SpeechManager.shared.stop()
        instructionText = "Done 🌿"
        scale = 1.0
    }
    
    
    private func runPhase() {
        timer?.invalidate()
        
        switch phase {
        case 0:
            instructionText =  "Sit comfortably, relax your shoulders"
            animateScale(to: 1.4)
            scheduleNext(after: 6)

        case 1:
            instructionText = "Take a deep inhale through your nose"
            animateScale(to: 1.6)
            scheduleNext(after: 4)

        case 2:
            instructionText = "Take a second short inhale through your nose"
            animateScale(to: 1.0)
            scheduleNext(after: 6)
        case 3:
            instructionText = "Slowly exhale through your mouth until your lungs feel empty"
            animateScale(to: 1.4)
            scheduleNext(after: 6)

        case 4:
            instructionText = "Repeat 3 times and notice your body relaxing"
            animateScale(to: 1.6)
            scheduleNext(after: 4)

        default:
            currentRound += 1
            if currentRound > totalRounds {
                stopBreathing()
                return
            }
            phase = -1
        }
        
        phase += 1
    }
    
    private func scheduleNext(after seconds: TimeInterval) {
        timer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { _ in
            self.runPhase()
        }
    }
    
    private func animateScale(to value: CGFloat) {
        withAnimation(.easeInOut(duration: 2.5)) {
            scale = value
        }
    }
}
