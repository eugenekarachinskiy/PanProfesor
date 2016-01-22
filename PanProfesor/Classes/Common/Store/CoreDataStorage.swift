//
//  CoreDataStorage.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataEntityClassName: String {
    case Section = "Section"
    case Word = "Word"
}

class CoreDataStorage {
    
    private static let dataBaseFileName = "PanProfesorDataBase"
    private static let managedObjectModelFileName = "PanProfesor"
    private static let managedObjectModelExtension = "momd"
    private static let dataBaseFileExtension = ".sqlite"
    
    lazy var manangedObjectContext: NSManagedObjectContext? = {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        return context
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let modelURL = NSBundle.mainBundle().URLForResource(CoreDataStorage.managedObjectModelFileName, withExtension: CoreDataStorage.managedObjectModelExtension) else {
            return nil
        }
        
        return NSManagedObjectModel(contentsOfURL: modelURL)
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let objectModel = self.managedObjectModel else {
            return nil
        }
        
        let url = (self.applicationDocumentDirectory?.URLByAppendingPathComponent(CoreDataStorage.dataBaseFileName + CoreDataStorage.dataBaseFileExtension))
        var coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: objectModel)
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch let error {
            print("error persistentStoreCoordinator \(error)")
        }
        
        return coordinator
    }()
    
    
    lazy var applicationDocumentDirectory: NSURL? = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls.first
    }()
    
    // MARK: Context control
    func saveContext() {
        guard let context = self.manangedObjectContext else {
            return
        }
        
        do {
            try context.save()
        } catch let error {
            print("save context error \(error)")
        }
    }
    
    func rollBack() {
        self.manangedObjectContext?.rollback()
    }
    
    // MARK: Inser methods
    func insertNewEntityForClass(entityClassName: CoreDataEntityClassName) -> NSManagedObject? {
        guard let context = self.manangedObjectContext else {
            return nil
        }
        
        return NSEntityDescription.insertNewObjectForEntityForName(entityClassName.rawValue, inManagedObjectContext: context)
    }

    func entitiesForClass(entityClassName: CoreDataEntityClassName, fetchLimit: Int, predicate: NSPredicate?, sortDescriptors:[NSSortDescriptor]?) -> [AnyObject]? {
        
        guard let context = self.manangedObjectContext else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest(entityName: entityClassName.rawValue)
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
    
    func entitiesForClass(entityClassName: CoreDataEntityClassName, predicate: NSPredicate?) -> [AnyObject]? {
        return entitiesForClass(entityClassName, fetchLimit: 0, predicate: predicate, sortDescriptors: nil)
    }
    
    func addNewSectionWithWords(json: NSDictionary) {
        parseJSON(json, entityClassName: CoreDataEntityClassName.Section)
        saveContext()
    }
    
    func parseJSON(json: NSDictionary, entityClassName: CoreDataEntityClassName) -> NSManagedObject? {
        guard let entity = insertNewEntityForClass(entityClassName) else {
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
                            if let relationClassNameString = relationDescription.destinationEntity?.managedObjectClassName.componentsSeparatedByString(".").last {
                                
                                if let relationClassName = CoreDataEntityClassName(rawValue: relationClassNameString) {
                                    if let relativeObject = parseJSON(jsonRelation as! NSDictionary, entityClassName: relationClassName) {
                                        relativeObjectsSet.addObject(relativeObject)
                                    }
                                }
                            }
                        }
                        
                        entity.setValue(relativeObjectsSet, forKey: relationDescription.name)
                    }
                    
                } else {
                    if let jsonRelation = json.valueForKey(relationDescription.name) as? NSDictionary,
                        let relationClassNameString = relationDescription.destinationEntity?.managedObjectClassName.componentsSeparatedByString(".").last {
                            
                            if let relationClassName = CoreDataEntityClassName(rawValue: relationClassNameString) {
                                
                                if let relativeObject = parseJSON(jsonRelation, entityClassName: relationClassName) {
                                    entity.setValue(relativeObject, forKey: relationDescription.name)
                                }
                            }
                        }
                    }
            }
        }
        
        return entity
    }
}