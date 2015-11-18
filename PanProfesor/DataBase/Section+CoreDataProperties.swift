//
//  Section+CoreDataProperties.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/17/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Section {

    @NSManaged var title: String?
    @NSManaged var words: NSSet?

}
