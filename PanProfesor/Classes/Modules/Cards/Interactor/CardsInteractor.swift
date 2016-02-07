//
//  CardsInteractor.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class CardsInteractor: CardsInteractorInput {

    //presenter
    weak var output: CardsInteractorOutput!

    func fetchWordsForCardsForSection(section: SectionDto) {
        output.foundWordsForCards(section.words)
    }
    
}
