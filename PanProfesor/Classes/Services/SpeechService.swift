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
        if synthesizer.speaking {
            synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        }
    
        let utterance = AVSpeechUtterance(string: character.pronunciation)
        utterance.voice = AVSpeechSynthesisVoice(language:character.language)
        utterance.rate = rate
        
        synthesizer.speakUtterance(utterance)
    }

}