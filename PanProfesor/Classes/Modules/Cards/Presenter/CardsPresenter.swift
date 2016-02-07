//
//  CardsPresenter.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class CardsPresenter: CardsModuleInput, CardsViewOutput, CardsInteractorOutput{

    weak var view: CardsViewInput!
    var interactor: CardsInteractorInput!
    var router: CardsRouterInput!

    var section: SectionDto!
    
    //MARK: ViewOutput
    func viewIsReady() {
        view.setupInitialState()
        interactor.fetchWordsForCardsForSection(section)
    }
    
    
    //MARK: ModuleInput
    func configureCardsModuleWithSection(section: SectionDto) {
        self.section = section
    }
    
    //MARK: InteractorOutput
    func foundWordsForCards(words: [WordDto]) {
        view.setupDataSourceWithWords(words)
    }
}
