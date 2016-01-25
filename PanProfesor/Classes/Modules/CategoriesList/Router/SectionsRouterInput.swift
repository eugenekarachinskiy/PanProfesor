//
//  SectionsRouterInput.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

protocol SectionsRouterInput: ViperRouterInput {
    func presentAlphabetController()
    func presentSectionContollerForSection(section: SectionDto)
}