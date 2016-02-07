//
//  TrainingCardsPresenter.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class TrainingCardsPresenter: TrainingCardsModuleInput, TrainingCardsViewOutput, TrainingCardsInteractorOutput{

    weak var view: TrainingCardsViewInput!
    var interactor: TrainingCardsInteractorInput!
    var router: TrainingCardsRouterInput!

    var section: SectionDto!
    
    //MARK: ViewOutput
    func viewIsReady() {
        view.setupInitialState()
        interactor.fetchWordsForTrainingCardsForSection(section)
    }

    //MARK: ModuleInput
    func configureModuleWithSection(section: SectionDto) {
        self.section = section
    }
    
    //MARK: InteractorOutput
    func foundWordsForTrainingCards(words: [WordDto]) {
        view.setupViewDataSource(words)
    }
}
