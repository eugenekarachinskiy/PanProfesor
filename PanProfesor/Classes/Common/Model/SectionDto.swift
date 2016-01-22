//
//  SectionDto.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

struct SectionDto {
    
    var title: String?
    var words: NSSet?
    
    init(title: String?, words: NSSet?) {
        self.title = title
        self.words = words
    }
}