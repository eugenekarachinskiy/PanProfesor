//
//  SectionsViewOutput.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

protocol SectionsViewOutput: ViperViewOutput {
    func setupView()
    func showAlphabet()
    func selectedSection(section: SectionDto)
}
