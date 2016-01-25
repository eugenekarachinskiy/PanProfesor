//
//  SectionsRouter.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class SectionsRouter {
    let alphabetSegueIdentifier = "alphabetSegueIdentifier"
    let examSegueIdentififier = "chooseExamSegue"
    
    weak var transitionHandler: ViperModuleTransitionHandlerProtocol?
}

extension SectionsRouter: SectionsRouterInput {
    func presentAlphabetController() {
        self.transitionHandler?.openModule(alphabetSegueIdentifier, configurationBlock: { (input) -> (ViperBaseModuleOutput?) in
            return nil
        })
    }
    
    func presentExamViewController(section: SectionDto) {
        self.transitionHandler?.openModule(examSegueIdentififier, configurationBlock: nil)
    }
    
}