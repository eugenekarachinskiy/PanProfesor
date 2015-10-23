//
//  LetterCollectionViewCell.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 10/21/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class LetterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    var editable = true

    func updateWithText(text: String) {
        textLabel.text = text
    }

}
