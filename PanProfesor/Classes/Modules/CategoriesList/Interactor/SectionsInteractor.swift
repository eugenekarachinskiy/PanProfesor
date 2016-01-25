//
//  SectionsInteractor.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class SectionsInteractor: ViperInteractor<SectionsPresenter> {
    let sectionsService: SectionsService = SectionsService()
}

extension SectionsInteractor: SectionsInteractorInput {
    func findSections() {
        let sections = sectionsService.allSections()
        var dtoSections: [SectionDto] = [SectionDto]()
        
        if let sectionsArray = sections {
            for section in sectionsArray {
                dtoSections.append(SectionDto(title: section.title, words: section.words))
            }
        }
        
        output?.foundSections(dtoSections)
    }
}