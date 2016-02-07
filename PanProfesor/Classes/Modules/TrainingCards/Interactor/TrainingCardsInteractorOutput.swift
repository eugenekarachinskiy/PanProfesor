//
//  TrainingCardsInteractorOutput.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import Foundation

protocol TrainingCardsInteractorOutput: class {
    func foundWordsForTrainingCards(words: [WordDto])
}
