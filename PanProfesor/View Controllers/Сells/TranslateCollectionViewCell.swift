//
//  TranslateCollectionViewCell.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/18/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class TranslateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
    func updateWithText(text: String, backgroundColor: UIColor) {
        textLabel.text = text
        self.backgroundColor = backgroundColor
    }
}
