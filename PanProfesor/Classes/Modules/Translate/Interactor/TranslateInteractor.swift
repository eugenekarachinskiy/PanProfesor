//
//  TranslateInteractor.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class TranslateInteractor: TranslateInteractorInput {

    //presenter
    weak var output: TranslateInteractorOutput!

    //words service
    let wordsService: WordsService = WordsService()
    
    func fetchWordsForSection(section: SectionDto, count: Int, sortedByUsed: Bool) {
        let wordsDto:Array<WordDto> = wordsService.fetchWordsInSection(section, fetchLimit: count, sortByCorrectAnswers: sortedByUsed)
        output.foundWords(wordsDto)
    }
}
