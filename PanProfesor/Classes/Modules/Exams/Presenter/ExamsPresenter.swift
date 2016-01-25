//
//  ExamsPresenter.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class ExamsPresenter: ExamsModuleInput, ExamsViewOutput, ExamsInteractorOutput {

    weak var view: ExamsViewInput!
    var interactor: ExamsInteractorInput!
    var router: ExamsRouterInput!
    
    var section: SectionDto?

    func viewIsReady() {
        interactor.requestExams()
    }
    
    //MARK:ExamsModuleInput
    func configureWithSection(section: SectionDto) {
        self.section = section
    }
    
    //MARK:ExamsViewOutput
    func examSelected(exam: ExamItem) {
        router.presentExamController(section, exam: exam)
    }
    
    
    //MARK: ExamsInteractorOutput
    func receiveExams(exams: [ExamItem]) {
        view.showExams(exams)
    }
}
