//
//  TranslatePresenter.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class TranslatePresenter: TranslateModuleInput, TranslateViewOutput, TranslateInteractorOutput{

    weak var view: TranslateViewInput!
    var interactor: TranslateInteractorInput!
    var router: TranslateRouterInput!
    
    let wordsLimit = 6
    var section: SectionDto!

    //MARK: View Output
    func viewIsReady() {
        view.setupInitialState()
        interactor.fetchWordsForSection(section, count: wordsLimit, sortedByUsed: true)
    }
    
    func finishedTranslateExam() {
        router.goBack()
    }

    //MARK: Module Input 
    func configureModulWithSection(section: SectionDto) {
        self.section = section
    }
    
    //MARK: Interactor Output
    func foundWords(words: [WordDto]) {
        view.setupWordsDataSource(words)
    }
}
