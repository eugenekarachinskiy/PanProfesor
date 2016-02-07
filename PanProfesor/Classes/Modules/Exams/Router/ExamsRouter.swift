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
            if let audioTranslateInput = input as? AudioTranslateModuleInput,
                let sectionDto = section {
                audioTranslateInput.setupSection(sectionDto)
            } else if let translateInput = input as? TranslateModuleInput, let sectionDto = section  {
                translateInput.configureModulWithSection(sectionDto)
            }
            return nil
        })
    }
}
