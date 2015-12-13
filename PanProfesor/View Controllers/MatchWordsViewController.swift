//
//  MatchWordsViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 9/26/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit
import CoreData

class MatchWordsViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemsCount = 5;
    let loopsLimit = 2

    var loops = 0
    var elements: [RecordStruct] = [];
    var selectedIndexPaths: [NSIndexPath] = [];
    var correctedIndexPaths: [NSIndexPath] = [];
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        guard let context = DataBaseManager.defaultManager.manangedObjectContext,
            let currentSection = self.section else {
                return nil
        }
        
        let sortDescriptor = NSSortDescriptor(key: "used", ascending: true)
        
        let fetchedRequest = NSFetchRequest(entityName: "Word")
        fetchedRequest.predicate = NSPredicate(format: "section == %@", currentSection)
        fetchedRequest.sortDescriptors = [sortDescriptor]
        fetchedRequest.fetchLimit = 5
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFetchedResultsController() {
        do {
            try fetchedResultsController?.performFetch()
        } catch let error {
            print("error setup fetch \(error)")
        }
    }
    
    func fetchData() {
        setupFetchedResultsController()
    }
    
    func setupData() {
        elements.removeAll()
        selectedIndexPaths.removeAll()
        correctedIndexPaths.removeAll()
    
        fetchData()
    
        let wordsArray:[Word] = self.fetchedResultsController?.fetchedObjects as! Array<Word>
        
        for word in wordsArray {
            if let originalText = word.russian,
                let translatedText = word.polish {
                    elements.append(RecordStruct(text: originalText, isOriginal: true))
                    elements.append(RecordStruct(text: translatedText, isOriginal: false))
                    
            }
        }
        
        elements.shuffleInPlace()
        collectionView.reloadData()
    }
    
    func finishedCurrent() {
        increaseUsedNumber()
        loops++
        
        if loops == loopsLimit {
            let alertView = UIAlertView(title: "Finish", message: "Finish", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        } else {
            setupData()
        }
    }
    
    func increaseUsedNumber() {
        let wordsArray:[Word] = self.fetchedResultsController?.fetchedObjects as! Array<Word>
        for word in wordsArray {
            if let usedCount = word.used?.integerValue {
                word.used = NSNumber(integer: usedCount + 1)
                
            } else {
                word.used = NSNumber(int: 1)
            }
        }
    }

    
    func checkPair() {
        if selectedIndexPaths.count == 2 {
            guard let firstIndex = selectedIndexPaths.first,
                let secondIndex = selectedIndexPaths.last else {
                    return
            }
            
            let firstRecord = elements[firstIndex.row]
            let secondRecord = elements[secondIndex.row]
            
            if compareRecords(firstRecord, secondRecord: secondRecord) {
                correctedIndexPaths.appendContentsOf(self.selectedIndexPaths)
            }
                
            self.selectedIndexPaths.removeAll()
            self.collectionView.reloadData()
                
            if correctedIndexPaths.count == itemsCount * 2 {
                finishedCurrent()
            }
        }
    }
    
    func compareRecords(firstRecord: RecordStruct, secondRecord: RecordStruct) -> Bool {
        if firstRecord.isOriginal != secondRecord.isOriginal {
            let originalText = firstRecord.isOriginal ? firstRecord.text : secondRecord.text
            let translatedText = !secondRecord.isOriginal ? secondRecord.text : firstRecord.text
            
            if let recordsArray: [Word] = fetchedResultsController?.fetchedObjects as? Array<Word> {
                let filteredArray = recordsArray.filter() { $0.russian?.lowercaseString == originalText.lowercaseString && $0.polish?.lowercaseString == translatedText.lowercaseString }
                return (filteredArray.count > 0)
            } else {
                return false
            }
        } else {
            return false
        }
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

extension MatchWordsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount * 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "matchWordIdentifier"
        let collectionViewCell:MemoryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! MemoryCollectionViewCell
        
        let record = elements[indexPath.row]
        let alpha: CGFloat = !correctedIndexPaths.contains(indexPath) ? 1.0 : 0.0
        let backgroundColor = selectedIndexPaths.contains(indexPath) ? UIColor.orangeColor() : (record.isOriginal ? UIColor.blueColor() : UIColor.yellowColor())
        
        collectionViewCell.updateWithText(record.text, backgroundColor: backgroundColor, textHidden: false, alpha: alpha)
        return collectionViewCell
    }
}

extension MatchWordsViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let index = selectedIndexPaths.indexOf(indexPath) {
            selectedIndexPaths.removeAtIndex(index)
        } else {
            selectedIndexPaths.append(indexPath)
        }
        
        collectionView.reloadData()
        checkPair()
    }
}


extension MatchWordsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(collectionView.frame.size.width / 2 - 10, collectionView.frame.size.height / 5 - 10)
    }
}

extension MatchWordsViewController: NSFetchedResultsControllerDelegate {
    
}
