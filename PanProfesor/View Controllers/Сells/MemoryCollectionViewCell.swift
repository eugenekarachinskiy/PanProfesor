//
//  MemoryCollectionViewCell.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 10/23/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class MemoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    
    func updateWithText(text: String, backgroundColor: UIColor, textHidden: Bool, alpha: CGFloat) {
        textLabel.text = text
        self.backgroundColor = backgroundColor
        textLabel.hidden = textHidden
        self.alpha = alpha
    }
    
}
