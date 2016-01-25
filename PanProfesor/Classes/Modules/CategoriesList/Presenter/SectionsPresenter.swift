//
//  SectionsPresenter.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class SectionsPresenter {
    var view: SectionsViewInput?
    var router: SectionsRouterInput?
    var interactor: SectionsInteractorInput?
}


extension SectionsPresenter: SectionsModuleInput {
    
}


extension SectionsPresenter: SectionsViewOutput {
    
    func setupView() {
        interactor?.findSections()
    }
    
    func showAlphabet() {
        router?.presentAlphabetController()
    }
    
    func selectedSection(section: SectionDto) {
        router?.presentExamViewController(section)
    }
}


extension SectionsPresenter: SectionsInteractorOutput {
    func foundSections(sections: [SectionDto]) {
        view?.showSections(sections)
    }
}

