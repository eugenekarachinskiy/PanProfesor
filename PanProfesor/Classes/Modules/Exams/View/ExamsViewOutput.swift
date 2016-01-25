//
//  ExamsViewOutput.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

protocol ExamsViewOutput {

    /**
        @author Eugene 
        Notify presenter that view is ready
    */

    func viewIsReady()
    func examSelected(exam: ExamItem)
}
