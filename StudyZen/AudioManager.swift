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
    
    func startBackgroundMusic(
        named fileName: String,
        loop: Bool = true,
        volume: Float = 0.05)
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
            player?
                .play()
        } catch {
            print(
                "Error playing sound: \(error.localizedDescription)"
            )
        }
    }
    
    func stopBackgroundMusic() {
        player?
            .stop()
        player = nil
    }
}
