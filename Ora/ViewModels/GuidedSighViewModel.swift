import SwiftUI
import Combine

class GuidedSighViewModel: ObservableObject {
    
    @Published var instructionText: String = "Get Ready"
    @Published var scale: CGFloat = 1.0
    @Published var currentRound = 0
    @Published var activity: Activity
    
    private var timer: Timer?
    @Published var phase = 0
  
    let totalRounds = 3
    
    init(activity: Activity) {
           self.activity = activity
       }
    
    func startBreathing() {
        AudioManager.shared.startBackgroundMusic(
            named: "calm.mp3",
            loop: true,
            volume: 0.04
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
    func pauseBreathing() {
        timer?.invalidate()
        AudioManager.shared.stopBackgroundMusic()
    SpeechManager.shared.stop()
      //  instructionText = "Done 🌿"
        scale = 1.0
    }
    
    
    private func runPhase() {
        timer?.invalidate()
        
        switch phase {
          
        case 0:
            instructionText =  "Sit comfortably and relax your shoulders"
            SpeechManager.shared.speak(instructionText)
            animateScale(to: 1.4)
            scheduleNext(after: 6)

        case 1:
            instructionText = "Take a deep breath in through your nose"
            SpeechManager.shared.speak(instructionText)
            animateScale(to: 1.6)
            scheduleNext(after: 6)

        case 2:
            instructionText = "Gently take another short breath in through your nose"
            SpeechManager.shared.speak(instructionText)
            animateScale(to: 1.0)
            scheduleNext(after: 6)
        case 3:
            instructionText = "Slowly exhale through your mouth until your lungs feel empty"
           SpeechManager.shared.speak(instructionText)
            animateScale(to: 1.4)
            scheduleNext(after: 6)

        case 4:
            instructionText = "Repeat this three times, noticing your body begin to relax"
           SpeechManager.shared.speak(instructionText)
            animateScale(to: 1.6)
            scheduleNext(after: 6)

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
