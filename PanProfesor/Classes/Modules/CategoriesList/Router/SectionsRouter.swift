//
//  SectionsRouter.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class SectionsRouter: ViperTransitionRouter {
    let alphabetSegueIdentifier = "alphabetSegueIdentifier"
    let examSegueIdentififier = "chooseExamSegue"
}

extension SectionsRouter: SectionsRouterInput {
    func presentAlphabetController() {
        self.transitionHandler?.openModule(alphabetSegueIdentifier, configurationBlock:nil)
    }
    
    func presentExamViewController(section: SectionDto) {
        self.transitionHandler?.openModule(examSegueIdentififier, configurationBlock: { (input) -> (AnyObject?) in
            if let examsInput = input as? ExamsModuleInput {
                examsInput.configureWithSection(section)
            }
            
            return nil
        })
    }
    
}