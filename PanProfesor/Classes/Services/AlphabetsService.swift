//
//  AlphabetsService.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

struct AlphabetCharacter {
    var upperCaseCharacter: String
    var lowerCaseCharacter: String
    var pronunciation: String
    var language: String
    
    func title() -> String {
        return upperCaseCharacter + lowerCaseCharacter
    }
    
    init(upperCase: String, lowerCase: String, pronunciation: String, language: String) {
        self.upperCaseCharacter = upperCase
        self.lowerCaseCharacter = lowerCase
        self.pronunciation = pronunciation
        self.language = language
    }
}

class AlphabetsService {
    
    let currentAlphabet = PolishAlphabetService()
    
    func getAlphabet() -> [AlphabetCharacter] {
       return currentAlphabet.alphabet()
    }
    
}