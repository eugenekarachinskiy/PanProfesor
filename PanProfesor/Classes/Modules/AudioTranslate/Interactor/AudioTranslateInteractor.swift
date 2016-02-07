//
//  AudioTranslateInteractor.swift
//  PanProfesor
//
//  Created by Eugene  on 26/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class AudioTranslateInteractor: AudioTranslateInteractorInput {

    // presenter
    weak var output: AudioTranslateInteractorOutput!
    
    //words service
    let wordsService: WordsService = WordsService()

    func fetchWordsForSection(section: SectionDto, count: Int, sortedByUsed: Bool) {
        let wordsDto:Array<WordDto> = wordsService.fetchWordsInSection(section, fetchLimit: count, sortByCorrectAnswers: sortedByUsed)
        output.foundWords(wordsDto)
    }
}
