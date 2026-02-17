//
//  SpeechManager.swift
//  StudyZen
//
//  Created by SINDHYA ANOOP on 2/5/26.
//

import Foundation
import AVFoundation

import AVFoundation

class SpeechManager {
    static let shared = SpeechManager()
    private let synthesizer = AVSpeechSynthesizer()
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        
        // Preferred soft female Siri voice
        if let voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact") {
            utterance.voice = voice
        } else {
            // Fallback
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        }
        
        utterance.rate = 0.42             
        utterance.pitchMultiplier = 0.85
        utterance.postUtteranceDelay = 0.3
        utterance.volume = 0.8
        
        synthesizer.speak(utterance)
    }
    
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
