//
//  SectionsService.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class SectionsService {
    private var coreDataStore: CoreDataStorage = CoreDataStorage()
    
    func allSections() -> [Section]? {
       return coreDataStore.entitiesForClass(CoreDataEntityClassName.Section, predicate: nil) as? [Section]
    }
    
}