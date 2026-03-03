//
//  AudioManager.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/2/26.
//
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    private var player: AVAudioPlayer?
    private var fadeTimer: Timer?

    func startBackgroundMusic(
        named fileName: String,
        loop: Bool = true,
        volume: Float = 0.05,
        fadeInDuration: TimeInterval = 2.0
    )
    {
        guard let url = Bundle.main.url(
            forResource: fileName,
            withExtension: nil
        ) else {
            print(
                "Sound file not found: \(fileName)"
            )
            return
        }
        do {
            player = try AVAudioPlayer(
                contentsOf: url
            )
            player?.numberOfLoops = loop ? -1 : 0
            player?.volume = 0   // start silent
            player?.prepareToPlay()
            player?.play()
            fadeIn(to: volume, duration: fadeInDuration)
        } catch {
            print(
                "Error playing sound: \(error.localizedDescription)"
            )
        }
    }
    
    private func fadeIn(to targetVolume: Float,
                            duration: TimeInterval) {

            fadeTimer?.invalidate()

            guard let player else { return }

            let steps: Float = 30
            let interval = duration / Double(steps)
            let volumeStep = targetVolume / steps

            fadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
                guard let self, let player = self.player else {
                    timer.invalidate()
                    return
                }

                if player.volume < targetVolume {
                    player.volume += volumeStep
                } else {
                    player.volume = targetVolume
                    timer.invalidate()
                }
            }
        }

        // MARK: - Fade Out

        func stopBackgroundMusic(fadeOutDuration: TimeInterval = 2.0) {

            guard let player else { return }

            fadeTimer?.invalidate()

            let steps: Float = 30
            let interval = fadeOutDuration / Double(steps)
            let volumeStep = player.volume / steps

            fadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
                guard let self, let player = self.player else {
                    timer.invalidate()
                    return
                }

                if player.volume > 0 {
                    player.volume -= volumeStep
                } else {
                    player.volume = 0
                    player.stop()
                    self.player = nil
                    timer.invalidate()
                }
            }
        }
    }
