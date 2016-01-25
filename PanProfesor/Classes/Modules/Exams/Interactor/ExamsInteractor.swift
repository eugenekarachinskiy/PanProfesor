//
//  ExamsInteractor.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class ExamsInteractor: ExamsInteractorInput {

    weak var output: ExamsInteractorOutput!
    var examsService: ExamsService = ExamsService()
    
    func requestExams() {
        output.receiveExams(examsService.getExamsList())
    }

}
