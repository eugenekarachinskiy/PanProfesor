//
//  ExamsRouterInput.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import Foundation

protocol ExamsRouterInput {
    func presentExamController(section: SectionDto?, exam: ExamItem)
}
