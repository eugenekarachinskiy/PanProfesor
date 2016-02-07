//
//  Word+CoreDataProperties.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Word {

    @NSManaged var polish: String!
    @NSManaged var russian: String!
    @NSManaged var used: NSNumber?
    @NSManaged var section: Section?

}
