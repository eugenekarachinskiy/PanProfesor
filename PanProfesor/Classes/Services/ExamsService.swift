//
//  ExamsService.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/25/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

struct ExamItem {
    let title: String
    let segueIdentifier: String
    
    init!(title: String, segueIdentifier: String) {
        self.title = title
        self.segueIdentifier = segueIdentifier
    }
}

class ExamsService {
    
    private let examsFileName = "Exams"
    private let examsFileExtension = "plist"
    
    func getExamsList() -> [ExamItem] {
        var result: [ExamItem] = [ExamItem]()
        
        if let resourcePath = NSBundle.mainBundle().pathForResource(examsFileName, ofType: examsFileExtension),
            let dictionary = NSDictionary(contentsOfFile: resourcePath) {
                
            for key in dictionary.allKeys {
                if let title = key as? String, let segue = dictionary[title] as? String {
                    result.append(ExamItem(title: title, segueIdentifier: segue))
                }
            }
        }
        
        return result
    }
    
}
