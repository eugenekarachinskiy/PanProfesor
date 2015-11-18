//
//  CardCollectionViewCell.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 10/21/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var originalTextLabel: UILabel!
    @IBOutlet weak var translateTextLabel: UILabel!
    
    func updateWithWord(word: Word?) {
        if let translatedText = word?.polish {
            imageView.image = UIImage(named: translatedText)
        }
        
        originalTextLabel.text = word?.russian
        translateTextLabel.text = word?.polish
    }
    
}
