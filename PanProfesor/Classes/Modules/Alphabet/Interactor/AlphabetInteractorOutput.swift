//
//  AlphabetInteractorOutput.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

protocol AlphabetInteractorOutput {
    func receivedAlphabet(alphabet: [AlphabetCharacter])
}