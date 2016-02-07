//
//  SpeechService.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import AVFoundation

class SpeechService {
    let synthesizer = AVSpeechSynthesizer()
    let rate: Float = 0.17
    
    func speake(character: AlphabetCharacter) {
        pronounse(character.pronunciation, language: character.language)
    }
    
    func speak(string: String, languge: String) {
        pronounse(string, language: languge)
    }
    
    private func pronounse(text: String, language: String) {
        if synthesizer.speaking {
            synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        }
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language:language)
        utterance.rate = rate
        
        synthesizer.speakUtterance(utterance)
    }

}