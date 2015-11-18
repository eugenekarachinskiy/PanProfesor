//
//  CardsViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/18/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit
import CoreData

class CardsViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var currentIndex = 0;
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        guard let context = DataBaseManager.defaultManager.manangedObjectContext,
            let currentSection = self.section else {
                return nil
        }
        
        let sortDescriptor = NSSortDescriptor(key: "used", ascending: true)
        
        let fetchedRequest = NSFetchRequest(entityName: "Word")
        fetchedRequest.predicate = NSPredicate(format: "section == %@", currentSection)
        fetchedRequest.sortDescriptors = [sortDescriptor]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        showCurrentCard()
    }
    
    @IBAction func showNext() {
        showNextCard()
    }
    
    @IBAction func showPrevious() {
        showPrevious()
    }
    
    func setupFetchedResultsController() {
        do {
            try fetchedResultsController?.performFetch()
        } catch let error {
            print("error setup fetch \(error)")
        }
    }
    
    func setup() {
        setupData()
        setupView()
    }
    
    func setupData() {
        setupFetchedResultsController()
    }
    
    func setupView() {
        if let wordsCount = fetchedResultsController?.fetchedObjects?.count {
            pageControl?.numberOfPages = wordsCount
        } else {
            pageControl?.numberOfPages = 0
        }
        
        updateTitle()
    }
    
    func updateTitle() {
        if let numberOfItems = collectionView?.numberOfItemsInSection(0) {
            self.navigationItem.title = "Карточки(\(currentIndex + 1)/\(numberOfItems + 1))"
        }
    }
    
    func didFinish() {
        
    }

    func showPreviousCard() {
        if currentIndex == 0 {
            if let itemsNumber = fetchedResultsController?.fetchedObjects?.count {
                 currentIndex = itemsNumber
            }
        } else {
            currentIndex--
        }
        
        showCurrentCard()
    }
    
    func showNextCard() {
        if let itemsCount = fetchedResultsController?.fetchedObjects?.count {
            if currentIndex == itemsCount - 1 {
                currentIndex = 0;
            } else {
                currentIndex++
            }
            
            showCurrentCard()
        }
    }
    
    func showCurrentCard() {
        showCard(index: currentIndex, animated: true)
        updateTitle()
    }
    
    func showCard(index index: Int, animated: Bool) {
        let wordsArray:[Word] = self.fetchedResultsController?.fetchedObjects as! Array<Word>
        let currentWord = wordsArray[currentIndex]
        
        SpeechHelper.defaultHelper.speake(currentWord.polish)
        
        let numberOfItems = collectionView?.numberOfItemsInSection(0)
        if index < numberOfItems {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: animated)
            pageControl?.currentPage = index
        } else {
            didFinish()
        }
    }

}


extension CardsViewController: NSFetchedResultsControllerDelegate {
    
}

extension CardsViewController: UICollectionViewDataSource {
    
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
        
        if let word = fetchedResultsController?.fetchedObjects?[indexPath.row] as? Word {
            collectionViewCell.updateWithWord(word)
        }
        
        return collectionViewCell
    }
}

extension CardsViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showNextCard()
    }
}

extension CardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
