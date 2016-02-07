//
//  TranslateInteractorInput.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import Foundation

protocol TranslateInteractorInput {
    func fetchWordsForSection(section: SectionDto, count: Int, sortedByUsed: Bool)
}
