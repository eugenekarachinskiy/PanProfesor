//
//  SectionDto.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

struct SectionDto {
    
    var title: String!
    var words: Array<WordDto> = Array<WordDto>()
    
    init(section:Section) {
        title = section.title
        
        if let wordsArray = section.words {
            for word in wordsArray {
                if let wordDao = word as? Word {
                    var wordDto = WordDto(word: wordDao)
                    wordDto.section = self
                    words.append(wordDto)
                }
            }
        }
    }
}