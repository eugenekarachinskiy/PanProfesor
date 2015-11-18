//
//  ContentManager.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/2/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class ContentManager {
    
    let contentVersionKey = "contentVersionKey"
    let contentSubDirectoryTitle = "ContentData"
    let contentFilesExtension = "txt"
    let dataBaseManager = DataBaseManager.defaultManager
    
    class var defaultManager: ContentManager {
        struct Static {
            static let instance = ContentManager()
        }
        
        return Static.instance
    }
    
    func checkContent() {
        let contentLoaded = checkIsAlreadyLoaded()
        if contentLoaded == false {
            let dbManager = DataBaseManager.defaultManager
            dbManager.cleanDataBase()
            loadContent()
        }
    }
    
    func checkIsAlreadyLoaded() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let currentContentVersion = userDefaults.stringForKey(contentVersionKey)
        let appVersion = ContentManager.appVersion()
        return currentContentVersion == appVersion
    }
    
    func setContententIsLoaded() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(ContentManager.appVersion(), forKey: contentVersionKey)
        userDefaults.synchronize()
    }
    
    func loadContent() {
        guard let contentUrls = NSBundle.mainBundle().URLsForResourcesWithExtension("json", subdirectory: nil) else {
            return
        }
        
        for url in contentUrls {
            if let data = NSData(contentsOfURL: url) {
                do {
                    if let json = try NSJSONSerialization .JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        dataBaseManager.addNewSectionWithWords(json)
                    }
                } catch let error {
                    print("error loadContent \(error)")
                }
            }
        }
        
        setContententIsLoaded()
    }
    
    
    class func appVersion() -> String? {
        return NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String
    }
}

