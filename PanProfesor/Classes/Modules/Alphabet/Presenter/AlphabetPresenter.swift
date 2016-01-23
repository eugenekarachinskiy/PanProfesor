//
//  AlphabetPresenter.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class AlphabetPresenter {
    var view: AlphabetViewInput?
    var router: AlphabetRouterInput?
    var interactor: AlphabetInteractorInput?
}

extension AlphabetPresenter: AlphabetModuleInput {
    
}

extension AlphabetPresenter: AlphabetViewOutput {
    func setupView() {
        interactor?.getAlphabet()
    }
    
    func alphabetCharacterDidSelect(character: AlphabetCharacter) {
        interactor?.pronounceAlphabetCharacter(character)
    }
}

extension AlphabetPresenter: AlphabetInteractorOutput {
    func receivedAlphabet(alphabet: [AlphabetCharacter]) {
        view?.showAlphabet(alphabet)
    }
}