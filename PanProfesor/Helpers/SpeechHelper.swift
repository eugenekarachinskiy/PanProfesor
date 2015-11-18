//
//  SpeechHelper.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/18/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit
import AVFoundation

class SpeechHelper {

    let synthesizer = AVSpeechSynthesizer()
    var rate: Float = 0.4
    
    class var defaultHelper: SpeechHelper {
        struct Static {
            static let instance = SpeechHelper()
        }
        
        return Static.instance
    }
    
    
    func speake(text: String?) {
        if synthesizer.speaking {
            synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        }
        
        if let speechText = text {
            let utterance = AVSpeechUtterance(string: speechText)
            utterance.rate = rate
            utterance.voice = AVSpeechSynthesisVoice(language: "pl-PL")
            synthesizer.speakUtterance(utterance)
        }
    }
    
}
