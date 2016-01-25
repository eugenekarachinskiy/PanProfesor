//
//  AlphabetViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class AlphabetViewController: ViperTransitionViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
    let rowCount = 5
    
    var alphabet: [AlphabetCharacter] = [AlphabetCharacter]()
    var output: AlphabetViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.setupView()
    }
}

extension AlphabetViewController: AlphabetViewInput {
    func showAlphabet(alphabet: [AlphabetCharacter]) {
        self.alphabet = alphabet
    }
}


extension AlphabetViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alphabet.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "alphabetCellIdentifier"
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! AlphabetCollectionViewCell
        collectionViewCell.textLabel.text = alphabet[indexPath.row].title()
        
        return collectionViewCell
    }
}

extension AlphabetViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        output?.alphabetCharacterDidSelect(alphabet[indexPath.row])
    }
}

extension AlphabetViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / 5 - 10
        return CGSizeMake(width, width)
    }
}
