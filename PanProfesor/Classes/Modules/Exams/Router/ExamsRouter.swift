//
//  ExamsRouter.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class ExamsRouter: ViperTransitionRouter, ExamsRouterInput {
    
    func presentExamController(section: SectionDto?, exam: ExamItem) {
        transitionHandler?.openModule(exam.segueIdentifier, configurationBlock: { (input) -> (AnyObject?) in
            if let sectionDto = section {
                if let audioTranslateInput = input as? AudioTranslateModuleInput {
                    audioTranslateInput.setupSection(sectionDto)
                } else if let translateInput = input as? TranslateModuleInput {
                    translateInput.configureModulWithSection(sectionDto)
                } else if let trainingCardsInput = input as? TrainingCardsModuleInput {
                    trainingCardsInput.configureModuleWithSection(sectionDto)
                }
            }
            
            return nil
        })
    }
}
