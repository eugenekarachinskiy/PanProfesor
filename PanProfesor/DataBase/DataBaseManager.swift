//
//  DataBaseManager.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 9/26/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import CoreData

class DataBaseManager {
    
    var managedObjectModel: NSManagedObjectModel? {
        let url = NSBundle.mainBundle().URLForResource("DataBaseModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: url)
    }
    
    var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        return NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
    }
    
    
    func applicationDocumentDirectory() -> NSURL? {
        let urls = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        return urls.last
    }
    
    
    
}
