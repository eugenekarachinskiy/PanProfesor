//
//  CardsInteractorOutput.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import Foundation

protocol CardsInteractorOutput: class {
    func foundWordsForCards(words: [WordDto])
}
