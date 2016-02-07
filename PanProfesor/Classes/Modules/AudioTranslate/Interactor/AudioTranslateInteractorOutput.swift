//
//  AudioTranslateInteractorOutput.swift
//  PanProfesor
//
//  Created by Eugene  on 26/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import Foundation

protocol AudioTranslateInteractorOutput: class {
    func foundWords(words:[WordDto])
}
