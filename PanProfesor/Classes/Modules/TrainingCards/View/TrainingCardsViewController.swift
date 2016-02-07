//
//  TrainingCardsViewController.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class TrainingCardsViewController: UIViewController, TrainingCardsViewInput, ViperModuleTransitionHandlerProtocol {
    
    //presenters
    weak var moduleInput: AnyObject?
    var output: TrainingCardsViewOutput!
    
    //outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //constants
    let timeInterval = 1.0
    let speechService = SpeechService()
    
    //vars
    var words:Array<WordDto> = Array<WordDto>()
    var showWord = false
    var currentIndex = 0;
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: TrainingCardsViewInput
    func setupInitialState() {
        
    }
    
    func setupViewDataSource(words: [WordDto]) {
        self.words = words
        setupView()
    }
    
    //Internal methods
    func setupView() {
        pageControl.numberOfPages = words.count
        collectionView.reloadData()
    }
    
    func showPreviousCard() {
        if currentIndex == 0 {
            currentIndex = words.count
        } else {
            currentIndex--
        }
        
        showCurrentCard()
    }
    
    func showNextCard() {
        if currentIndex == words.count - 1 {
            currentIndex = 0;
        } else {
            currentIndex++
        }
        
        showCurrentCard()
    }
    
    func showCurrentCard() {
        showCard(index: currentIndex, animated: true)
    }
    
    func showCard(index index: Int, animated: Bool) {
        let numberOfItems = collectionView?.numberOfItemsInSection(0)
        if index < numberOfItems {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: animated)
            pageControl?.currentPage = index
        }
    }
    
    func showOriginalWord() {
        let currentWord = words[currentIndex]
        speechService.speak(currentWord.polish, languge: "PL-pl")
        
        showWord = true
        collectionView.userInteractionEnabled = false
        collectionView.reloadData()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(timeInterval * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
            self.collectionView.userInteractionEnabled = true
            self.showWord = false
            self.showNextCard()
        })
    }
}


extension TrainingCardsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "cardIdentifier"
        let collectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardCollectionViewCell
        let word = words[indexPath.row]
        collectionViewCell.updateWithWord(word, showOriginal: showWord)
        
        return collectionViewCell
    }
}

extension TrainingCardsViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        showOriginalWord()
    }
}

extension TrainingCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
