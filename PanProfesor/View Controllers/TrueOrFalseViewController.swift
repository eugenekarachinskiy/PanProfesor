//
//  TrueOrFalseViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 9/26/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit
import CoreData

class TrueOrFalseViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl: UIPageControl?
    
    var suggestedWords: [String] = [String]()
    var currentIndex = 0
    static let wordsLimit = 10
    
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

        // Do any additional setup after loading the view.
        setupData()
        setupView()
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
    
    func showCorrectOrNo() -> Bool {
        return (rand()%2 == 0)
    }
    
    @IBAction func truePressed(sender: AnyObject) {
        let wordsArray:[Word] = self.fetchedResultsController?.fetchedObjects as! Array<Word>
        let currentWord = wordsArray[currentIndex]
        let currentSuggestion = suggestedWords[currentIndex]
        
        if currentWord.russian == currentSuggestion {
            answeredTruthly()
        } else {
            answeredFalsely()
        }
    }
    
    @IBAction func falsePressed(sender: AnyObject) {
        let wordsArray:[Word] = self.fetchedResultsController?.fetchedObjects as! Array<Word>
        let currentWord = wordsArray[currentIndex]
        let currentSuggestion = suggestedWords[currentIndex]
        
        if currentWord.russian != currentSuggestion {
            answeredTruthly()
        } else {
            answeredFalsely()
        }
    }
    
    func answeredTruthly() {
        let wordsArray:[Word] = self.fetchedResultsController?.fetchedObjects as! Array<Word>
        let currentWord = wordsArray[currentIndex]
        if let usedCount = currentWord.used?.integerValue {
            currentWord.used = NSNumber(integer: usedCount + 1)
            
        } else {
            currentWord.used = NSNumber(int: 1)
        }
        
        currentIndex++
        showCurrentCard(animated: true)
    }
    
    func answeredFalsely() {
        let alertView = UIAlertView(title: "Ответ неверный", message: "Ответ неверный", delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }
    
    func setupData() {
        suggestedWords.removeAll()
        setupFetchedResultsController()
        
        let wordsArray:[Word] = self.fetchedResultsController?.fetchedObjects as! Array<Word>
        for word in wordsArray {
            if showCorrectOrNo() {
                if let originalWord = word.russian {
                    suggestedWords.append(originalWord)
                }
            } else {
                let randomIndex = Int(arc4random_uniform(UInt32(wordsArray.count)))
                let randomWord = wordsArray[randomIndex]
                if let randomOriginal = randomWord.russian {
                    suggestedWords.append(randomOriginal)
                }
            }
        }
        
    }
    
    func setupView() {
        if let wordsCount = fetchedResultsController?.fetchedObjects?.count {
            pageControl?.numberOfPages = wordsCount
        } else {
            pageControl?.numberOfPages = 0
        }
    }
    
    //MARK: Show Card Methods
    
    func showCurrentCard(animated animated: Bool) {
        showCard(index: currentIndex, animated: animated)
    }
    
    func showCard(index index: Int, animated: Bool) {
        let numberOfItems = collectionView?.numberOfItemsInSection(0)
        if index < numberOfItems {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: animated)
            pageControl?.currentPage = index
        } else {
            didFinish()
        }
    }
    
    func didFinish() {
        DataBaseManager.defaultManager.saveContext()
        
        let alertView = UIAlertView(title: "Finish", message: "Finish", delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
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

extension TrueOrFalseViewController: NSFetchedResultsControllerDelegate {
    
}


extension TrueOrFalseViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let wordsCount = fetchedResultsController?.fetchedObjects?.count {
            return wordsCount
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "cardIdentifier"
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardCollectionViewCell
        
        let word = fetchedResultsController?.fetchedObjects?[indexPath.row] as? Word
        let suggestedWord = suggestedWords[indexPath.row]
        collectionViewCell.updateWithWord(word, suggestedText: suggestedWord)
        
        return collectionViewCell
    }
}

extension TrueOrFalseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
