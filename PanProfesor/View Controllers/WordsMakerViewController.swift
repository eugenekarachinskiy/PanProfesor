//
//  WordsMakerViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 9/26/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class WordsMakerViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var wordTextField: UITextField!
    
    var letters: [Character] = [Character]()
    var selectedIndexPaths: [NSIndexPath] = [NSIndexPath]()
    
    let word = "Nadgarstek"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backspacePressed() {
        removeLastLetter()
    }
    
    func removeLastLetter() {
        if selectedIndexPaths.count > 0 {
            if let text = wordTextField.text {
                let trancatedText = text.substringToIndex(text.endIndex.predecessor())
                wordTextField.text = trancatedText
            }
            
            selectedIndexPaths.removeLast()
            collectionView.reloadData()
        }
    }

    func updateData() {
        selectedIndexPaths.removeAll()
        letters = Array(word.characters)
        letters.shuffleInPlace()
        collectionView.reloadData()
    }
    
    func selectLetterAtIndexPath(indexPath: NSIndexPath) {
        let character = letters[indexPath.row]
        let letter = String(character).lowercaseString
        wordTextField.text?.appendContentsOf(letter)
        
        if wordTextField.text?.characters.count == word.characters.count {
            if word.lowercaseString == wordTextField.text?.lowercaseString {
                createWordSuccessfully()
            } else {
                createIncorrectWord()
            }
        }
        
    }
    
    func createWordSuccessfully() {
        
    }
    
    func createIncorrectWord() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WordsMakerViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !selectedIndexPaths.contains(indexPath) {
            selectLetterAtIndexPath(indexPath)
            selectedIndexPaths.append(indexPath)
            collectionView.reloadData()
        }
    }
}


extension WordsMakerViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "letterCellIdentifier"
        let collectionViewCell: LetterCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! LetterCollectionViewCell

        let character = letters[indexPath.row]
        let letter = String(character).lowercaseString
        
        collectionViewCell.updateWithText(letter)
        collectionViewCell.textLabel.textColor = selectedIndexPaths.contains(indexPath) ? UIColor.redColor() : UIColor.blackColor()
        
        return collectionViewCell
    }
}
