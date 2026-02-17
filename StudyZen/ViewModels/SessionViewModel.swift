
import Foundation
import Combine

class SessionViewModel: ObservableObject {
    @Published var timeRemaining: TimeInterval
    @Published var totalTime: TimeInterval
    @Published var isActive: Bool = false
    @Published var isCompleted: Bool = false
    @Published var activity: Activity
    
    
    // Breathing specific
    enum BreathingPhase: String {
        case inhale = "Inhale"
        case hold = "Hold"
        case exhale = "Exhale"
    }
    @Published var breathingPhase: BreathingPhase = .inhale
    @Published var breathingScale: CGFloat = 1.0
    
    private var timer: AnyCancellable?
    
    init(activity: Activity) {
        self.activity = activity
        self.totalTime = activity.duration
        self.timeRemaining = activity.duration
    }
    
    func startSession() {
        isActive = true
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    func pauseSession() {
        isActive = false
        timer?.cancel()
    }
    
    func stopSession() {
        pauseSession()
        timeRemaining = totalTime
        isCompleted = false
    }
    
    private func tick() {
        guard isActive else { return }
        
        if timeRemaining > 0 {
            timeRemaining -= 1
            
            if activity.type == .breathing {
                updateBreathingPhase()
            }
        } else {
            completeSession()
        }
    }
    
    private func completeSession() {
        isActive = false
        isCompleted = true
        timer?.cancel()
    }
    
    private func updateBreathingPhase() {
        // Realistic breathing cycle (in seconds)
        let inhaleDuration: CGFloat = 4.0      // Inhale ~4s
        let holdDuration: CGFloat = 2.5        // Hold ~1.5s
        let exhaleDuration: CGFloat = 6.0      // Exhale ~6s (longer than inhale)
        let cycle = inhaleDuration + holdDuration + exhaleDuration
        
        // Current time within the cycle
        let elapsed = CGFloat(totalTime - timeRemaining).truncatingRemainder(dividingBy: cycle)
        
        if elapsed < inhaleDuration {
            // Inhale phase
            breathingPhase = .inhale
            let progress = elapsed / inhaleDuration
            breathingScale = 1.0 + progress * 0.5       // Smooth scale from 1.0 → 1.5
        } else if elapsed < inhaleDuration + holdDuration {
            // Hold phase
            breathingPhase = .hold
            breathingScale = 1.5
        } else {
            // Exhale phase
            breathingPhase = .exhale
            let progress = (elapsed - inhaleDuration - holdDuration) / exhaleDuration
            breathingScale = 1.5 - progress * 0.5       // Smooth scale from 1.5 → 1.0
        }
    }
    
    var progress: Double {
        guard totalTime > 0 else { return 0 }
        return 1 - (timeRemaining / totalTime)
    }
    
    func formatTime() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
