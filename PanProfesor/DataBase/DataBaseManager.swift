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
        
//        context.persistentStoreCoordinator?.performBlockAndWait({ () -> Void in
            do {
                try context.save()
            } catch let error {
                print("save context error \(error)")
            }
//        })
    }
    
    func rollBack() {
        self.manangedObjectContext?.rollback()
    }
    
    func cleanDataBase() {
        
    }
    
    //MARK: Additional Methods
    
    func insertNewEntityForClass(classEntityName: String) -> NSManagedObject? {
        guard let context = self.manangedObjectContext else {
            return nil
        }
        
        return NSEntityDescription.insertNewObjectForEntityForName(classEntityName, inManagedObjectContext: context)
    }
    
    func entitiesForClass(classEntityName: String, fetchLimit: Int, predicate: NSPredicate?, sortDescriptors:[NSSortDescriptor]?) -> [AnyObject]? {
        
        guard let context = self.manangedObjectContext else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest(entityName: classEntityName)
        fetchRequest.fetchLimit = fetchLimit
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.resultType = .ManagedObjectResultType

        do {
            let resultEntities = try context.executeFetchRequest(fetchRequest)
            return resultEntities as [AnyObject]?
        } catch let error {
            print("entitiesForClass \(error)")
            return nil
        }
    }
    
    func entitiesForClass(classEntityName: String, predicate: NSPredicate?) -> [AnyObject]? {
        return entitiesForClass(classEntityName, fetchLimit: 0, predicate: predicate, sortDescriptors: nil)
    }
    
    func addNewSectionWithWords(json: NSDictionary) {
        parseJSON(json, classEntityName: "Section")
        saveContext()
    }
    
    func parseJSON(json: NSDictionary, classEntityName: String) -> NSManagedObject? {
        guard let entity = insertNewEntityForClass(classEntityName) else {
            return nil
        }
        
        for attributeKey in entity.entity.attributesByName.keys {
            if let attributeDescription = entity.entity.attributesByName[attributeKey] {
                entity.setValue(json.valueForKey(attributeDescription.name), forKey: attributeDescription.name)
            }
        }
        
        for relationKey in entity.entity.relationshipsByName.keys {
            if let relationDescription: NSRelationshipDescription = entity.entity.relationshipsByName[relationKey] {
                if relationDescription.toMany {
                    if let jsonRelationsArray = json.valueForKey(relationDescription.name) as? NSArray {
                        
                        let relativeObjectsSet: NSMutableSet = NSMutableSet()
                
                        for jsonRelation in jsonRelationsArray where jsonRelation is NSDictionary  {
                            if let relationClassName = relationDescription.destinationEntity?.managedObjectClassName.componentsSeparatedByString(".").last {
                                if let relativeObject = parseJSON(jsonRelation as! NSDictionary, classEntityName:relationClassName) {
                                   relativeObjectsSet.addObject(relativeObject)
                                }
                            }
                        }
                        
                        entity.setValue(relativeObjectsSet, forKey: relationDescription.name)
                    }
                    
                } else {
                    if let jsonRelation = json.valueForKey(relationDescription.name) as? NSDictionary,
                       let relationClassName = relationDescription.destinationEntity?.managedObjectClassName.componentsSeparatedByString(".").last {
    
                        if let relativeObject = parseJSON(jsonRelation, classEntityName: relationClassName) {
                            entity.setValue(relativeObject, forKey: relationDescription.name)
                        }
                    }
                }
            }
        }
        
        return entity
    }
    
}
