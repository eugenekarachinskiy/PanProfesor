//
//  PolishAlphabetService.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class PolishAlphabetService {
    private let lowerCaseLetters: [String] = ["a", "ą", "b", "c", "ć", "d", "e", "ę", "f", "g", "h", "i", "j", "k", "l", "ł", "m", "n", "ń", "o", "ó", "p", "r", "s", "ś", "t", "u", "w", "y", "z", "ź", "ż"]
    private let upperCaseLetters: [String] = ["A", "Ą", "B", "C", "Ć", "D", "E", "Ę", "F", "G", "H", "I", "J", "K", "L", "Ł", "M", "N", "Ń", "O", "Ó", "P", "R", "S", "Ś", "T", "U", "W", "Y", "Z", "Ź", "Ż"]
    static let language: String = "pl-PL"
 
    func alphabet() -> [AlphabetCharacter] {
        var result: [AlphabetCharacter] = [AlphabetCharacter]()
        
        for i in 0...lowerCaseLetters.count - 1 {
            result.append(AlphabetCharacter(upperCase: upperCaseLetters[i], lowerCase: lowerCaseLetters[i], pronunciation: lowerCaseLetters[i], language: PolishAlphabetService.language))
        }
        
        return result
    }
}