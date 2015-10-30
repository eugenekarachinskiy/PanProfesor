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
    static let kDataBaseName = "PanProfesor"
    
    class var defaultManager: DataBaseManager {
        struct Static {
            static let instance = DataBaseManager()
        }
        
        return Static.instance
    }
    
    lazy var applicationDocumentDirectory: NSURL? = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls.first
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelURL = NSBundle.mainBundle().URLForResource(DataBaseManager.kDataBaseName, withExtension: "momd") else {
            return nil
        }
        
        return NSManagedObjectModel(contentsOfURL: modelURL)
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let objectModel = self.managedObjectModel else {
            return nil
        }

        let url = (self.applicationDocumentDirectory?.URLByAppendingPathComponent(DataBaseManager.kDataBaseName + ".sqlite"))
        var coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        
        do {
           try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch let error {
            print("error persistentStoreCoordinator \(error)")
        }
        
        return coordinator
    }()
    
    lazy var manangedObjectContext: NSManagedObjectContext? = {
       let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        return context
    }()
    
    
    func saveContext() {
        guard let context = self.manangedObjectContext else {
            return
        }
        
        context.persistentStoreCoordinator?.performBlockAndWait({ () -> Void in
            do {
                try context.save()
            } catch let error {
                print("save context error \(error)")
            }
        })
    }
}
