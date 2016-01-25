//
//  ExamsViewInput.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

protocol ExamsViewInput: class {

    /**
        @author Eugene 
        Setup initial state of the view
    */

    func setupInitialState()
    func showExams(exams:[ExamItem])
}
