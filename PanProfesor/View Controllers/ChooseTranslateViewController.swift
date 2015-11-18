//
//  ChooseTranslateViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/18/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit
import CoreData

class ChooseTranslateViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var textLabel: UILabel!
    
    var translateWords: [String] = [String]()
    var incorrectIndexes: [NSIndexPath] = [NSIndexPath]()
    var correctIndex: NSIndexPath?
    
    var currentLoop = 0
    var currentWord: Word?
    
    let loopsMaxCount = 10
    let timeinterval = 1.0
    
    static let wordsLimit = 6
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        guard let context = DataBaseManager.defaultManager.manangedObjectContext,
            let currentSection = self.section else {
                return nil
        }
        
        let sortDescriptor = NSSortDescriptor(key: "used", ascending: true)
        
        let fetchedRequest = NSFetchRequest(entityName: "Word")
        fetchedRequest.predicate = NSPredicate(format: "section == %@", currentSection)
        fetchedRequest.sortDescriptors = [sortDescriptor]
        fetchedRequest.fetchLimit = wordsLimit
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        setup()
    }
    
    func setupFetchedResultsController() {
        do {
            try fetchedResultsController?.performFetch()
        } catch let error {
            print("error setup fetch \(error)")
        }
    }
    
    func prepareView() {
        pageControl.numberOfPages = loopsMaxCount
    }
    
    func setup() {
        setupData()
        setupView()
    }
    
    func setupData() {
        correctIndex = nil
        translateWords.removeAll()
        incorrectIndexes.removeAll()
        
        setupFetchedResultsController()
        currentWord = fetchedResultsController?.fetchedObjects?[0] as? Word
        
        if let wordsArray = fetchedResultsController?.fetchedObjects as? [Word] {
            for word in wordsArray {
                if let translateText = word.russian {
                    translateWords.append(translateText)
                }
            }
        }
        
        translateWords.shuffleInPlace()
    }
    
    func setupView() {
        pageControl.currentPage = currentLoop
        textLabel.text = currentWord?.polish
        collectionView.reloadData()
    }
    
    func didFinish() {
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        let alertController = UIAlertController(title: "Finish", message: "Finish", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func checkTranslateWord(indexPath: NSIndexPath) {
        let translatedText = translateWords[indexPath.row]
        if currentWord?.russian == translatedText {
            correctIndex = indexPath
            collectionView.reloadData()
            answeredCorrect()
        } else {
            incorrectIndexes.append(indexPath)
            collectionView.reloadData()
        }
    }
    
    func answeredCorrect() {
        SpeechHelper.defaultHelper.speake(currentWord?.polish)
        increaseWordUse()
        collectionView.userInteractionEnabled = false
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(timeinterval * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
            self.collectionView.userInteractionEnabled = true
            
            self.currentLoop++
            if self.currentLoop == self.loopsMaxCount {
                self.didFinish()
            } else {
                self.setup()
            }
        })
    }
    
    func increaseWordUse() {
        if let usedCount = currentWord?.used?.integerValue {
            currentWord?.used = NSNumber(integer: usedCount + 1)
        } else {
            currentWord?.used = NSNumber(int: 1)
        }
        
        DataBaseManager.defaultManager.saveContext()
    }
}

extension ChooseTranslateViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return translateWords.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "translateWordIdentifier"
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! TranslateCollectionViewCell
        
        let text = translateWords[indexPath.row]
        let backgroundColor = incorrectIndexes.contains(indexPath) ? UIColor.blueColor() : (correctIndex == indexPath ? UIColor.greenColor() : UIColor.yellowColor())
        
        collectionViewCell.updateWithText(text, backgroundColor: backgroundColor)
        return collectionViewCell
    }
}

extension ChooseTranslateViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !incorrectIndexes.contains(indexPath) {
            checkTranslateWord(indexPath)
        }
    }
}


extension ChooseTranslateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(collectionView.frame.size.width / 2 - 10, collectionView.frame.size.height / 3 - 10)
    }
}

extension ChooseTranslateViewController: NSFetchedResultsControllerDelegate {
    
}
