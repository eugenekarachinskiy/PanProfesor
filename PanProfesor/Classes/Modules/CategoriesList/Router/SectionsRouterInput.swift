//
//  SectionsRouterInput.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

protocol SectionsRouterInput {
    func presentAlphabetController()
    func presentSectionContollerForSection(section: SectionDto)
}