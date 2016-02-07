//
//  CardsViewController.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, CardsViewInput, ViperModuleTransitionHandlerProtocol {
    
    //presenters
    var moduleInput: AnyObject?
    var output: CardsViewOutput!
    
    //outletes
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //constants
    let speechService = SpeechService()
    
    //vars
    var words:Array<WordDto> = Array<WordDto>()
    var currentIndex = 0;
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    // MARK: CardsViewInput
    func setupInitialState() {
        
    }
    
    func setupDataSourceWithWords(words: [WordDto]) {
        self.words = words
        setupView()
    }
    
    //MARK: Internal Methods
    @IBAction func showNext() {
        showNextCard()
    }
    
    @IBAction func showPrevious() {
        showPrevious()
    }
    
    func setupView() {
        pageControl?.numberOfPages = words.count
        collectionView.reloadData()
        showCurrentCard()
    }
    
    func updateTitle() {
        self.navigationItem.title = "Карточки(\(currentIndex + 1)/\(words.count))"
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
        updateTitle()
    }
    
    func showCard(index index: Int, animated: Bool) {
        let currentWord = words[currentIndex]
        speechService.speak(currentWord.polish, languge: "PL-pl")
    
        if index < words.count {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: animated)
            pageControl?.currentPage = index
        }
    }
}

extension CardsViewController: UICollectionViewDataSource {
    
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
        collectionViewCell.updateWithWord(word)
        
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
