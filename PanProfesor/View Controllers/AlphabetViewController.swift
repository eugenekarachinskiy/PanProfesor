//
//  AlphabetViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/19/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class AlphabetViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let lowerCaseLetters: [String] = ["a", "ą", "b", "c", "ć", "d", "e", "ę", "f", "g", "h", "i", "j", "k", "l", "ł", "m", "n", "ń", "o", "ó", "p", "r", "s", "ś", "t", "u", "w", "y", "z", "ź", "ż"]
    let upperCaseLetters: [String] = ["A", "Ą", "B", "C", "Ć", "D", "E", "Ę", "F", "G", "H", "I", "J", "K", "L", "Ł", "M", "N", "Ń", "O", "Ó", "P", "R", "S", "Ś", "T", "U", "W", "Y", "Z", "Ź", "Ż"]
    
    let rowCount = 5
}

extension AlphabetViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lowerCaseLetters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "alphabetCellIdentifier"
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! AlphabetCollectionViewCell
        collectionViewCell.textLabel.text = "\(upperCaseLetters[indexPath.row])\(lowerCaseLetters[indexPath.row])"
        
        return collectionViewCell
    }
}

extension AlphabetViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        SpeechHelper.defaultHelper.speake(lowerCaseLetters[indexPath.row])
    }
}

extension AlphabetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / 5 - 10
        return CGSizeMake(width, width)
    }

}
