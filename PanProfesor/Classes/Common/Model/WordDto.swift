//
//  WordDto.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

struct WordDto {
    var polish: String
    var russian: String
    var used: Int?
    var section: SectionDto?
    
    init(word: Word) {
        self.polish = word.polish
        self.russian = word.russian
        self.used = word.used?.integerValue
    }
}