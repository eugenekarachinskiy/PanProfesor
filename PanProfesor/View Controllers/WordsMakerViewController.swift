//
//  WordsMakerViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 9/26/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit
import CoreData

class WordsMakerViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var originalWordLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var letters: [Character] = [Character]()
    var selectedIndexPaths: [NSIndexPath] = [NSIndexPath]()
    var currentWord: Word?
    var correctFirstAttempt: Bool = true
    var currentIndex: Int = 0
    let wordsLimit: Int = 10
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        guard let context = DataBaseManager.defaultManager.manangedObjectContext,
              let currentSection = self.section else {
            return nil
        }
        
        let sortDescriptor = NSSortDescriptor(key: "used", ascending: true)
        
        let fetchedRequest = NSFetchRequest(entityName: "Word")
        fetchedRequest.predicate = NSPredicate(format: "section == %@", currentSection)
        fetchedRequest.sortDescriptors = [sortDescriptor]
        fetchedRequest.fetchLimit = 10
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupFetchedResultsController()
        setupView()
        updateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        if let wordsCount = fetchedResultsController?.fetchedObjects?.count {
            pageControl.numberOfPages = wordsCount
        } else {
            pageControl.numberOfPages = 0
        }
    }
    
    func setupFetchedResultsController() {
        do {
            try fetchedResultsController?.performFetch()
        } catch let error {
            print("error setup fetch \(error)")
        }
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
        currentWord = fetchedResultsController?.fetchedObjects?[currentIndex] as? Word
        correctFirstAttempt = true
        
        pageControl.currentPage = currentIndex
        originalWordLabel.text = currentWord?.russian
        wordTextField.text = nil
        
        if let translatedWord = currentWord?.polish {
            imageView.image = UIImage(named: translatedWord)
            letters = Array(translatedWord.characters)
        }
        
        letters.shuffleInPlace()
        selectedIndexPaths.removeAll()
        collectionView.reloadData()
    }
    
    func selectLetterAtIndexPath(indexPath: NSIndexPath) {
        let character = letters[indexPath.row]
        let letter = String(character).lowercaseString
        selectedIndexPaths.append(indexPath)
        wordTextField.text?.appendContentsOf(letter)
        
        if wordTextField.text?.characters.count == currentWord?.polish?.characters.count {
            if currentWord?.polish?.lowercaseString == wordTextField.text?.lowercaseString {
                wordCreatedSuccessfully()
            } else {
                wordCreatedIncorrect()
            }
        }
    }
    
    func wordCreatedSuccessfully() {
        if correctFirstAttempt {
            if let usedCount = currentWord?.used?.integerValue {
                currentWord?.used = NSNumber(integer: usedCount + 1)
                
            } else {
                currentWord?.used = NSNumber(int: 1)
            }
        }
        
        currentIndex++
        if currentIndex == wordsLimit {
            didFinishLevel()
        } else {
            updateData()
        }
    }
    
    func wordCreatedIncorrect() {
        correctFirstAttempt = false
    }
    
    
    func didFinishLevel() {
        DataBaseManager.defaultManager.saveContext()
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

extension WordsMakerViewController: NSFetchedResultsControllerDelegate {
    
}
