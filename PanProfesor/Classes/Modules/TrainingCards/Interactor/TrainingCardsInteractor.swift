//
//  TrainingCardsInteractor.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class TrainingCardsInteractor: TrainingCardsInteractorInput {
    
    //Presenter
    weak var output: TrainingCardsInteractorOutput!
    let wordsService = WordsService()
    
    
    func fetchWordsForTrainingCardsForSection(section: SectionDto) {
        let words = wordsService.fetchAllWordsForSection(section)
        output.foundWordsForTrainingCards(words)
    }
    
}
