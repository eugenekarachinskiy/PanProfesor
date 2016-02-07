//
//  WordsService.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 2/1/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class WordsService {
    private let store: CoreDataStorage = CoreDataStorage()
    
    func fetchWordsInSection(section: SectionDto, fetchLimit: Int, sortByCorrectAnswers: Bool) -> [WordDto] {
        var result: Array<WordDto> = Array<WordDto>()
        var words = section.words.sort { (first, second) -> Bool in
            return first.used > second.used
        }

        result = Array(words[0..<fetchLimit])
        return result
    }
    
}
