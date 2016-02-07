//
//  AudioTranslatePresenter.swift
//  PanProfesor
//
//  Created by Eugene  on 26/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class AudioTranslatePresenter: AudioTranslateModuleInput, AudioTranslateViewOutput, AudioTranslateInteractorOutput{

    weak var view: AudioTranslateViewInput!
    var interactor: AudioTranslateInteractorInput!
    var router: AudioTranslateRouterInput!

    let wordsLimit = 6
    var section: SectionDto!
    
    //MARK: View Output
    func viewIsReady() {
        view.setupInitialState()
        interactor.fetchWordsForSection(section, count: wordsLimit, sortedByUsed: true)
    }
    
    func finishedExam() {
        router.goBack()
    }
    
    //MARK: Module Input 
    func setupSection(section: SectionDto) {
        self.section = section
    }
    
    //MARK: Interactor Output
    func foundWords(words: [WordDto]) {
        view.displayWords(words)
    }
}
