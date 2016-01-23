//
//  AlphabetInteractor.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class AlphabetInteractor {
    let alphabetService = AlphabetsService()
    let speechService = SpeechService()
    
    var output: AlphabetInteractorOutput?
}

extension AlphabetInteractor: AlphabetInteractorInput {
    func getAlphabet() {
        output?.receivedAlphabet(alphabetService.getAlphabet())
    }
    
    func pronounceAlphabetCharacter(character: AlphabetCharacter) {
        speechService.speake(character)
    }
}