//
//  TranslateViewController.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, TranslateViewInput, ViperModuleTransitionHandlerProtocol {

    //Presenter
    var output: TranslateViewOutput!
    weak var moduleInput: AnyObject?
    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var textLabel: UILabel!
    
    //Constants
    let loopsMaxCount = 10
    let timeinterval = 1.0
    let speechService = SpeechService()
    
    //Vars
    var words: Array<WordDto> = Array<WordDto>()
    var translateWords: [String] = [String]()
    var incorrectIndexes: [NSIndexPath] = [NSIndexPath]()
    var correctIndex: NSIndexPath?
    
    var currentLoop = 0
    var currentWord: WordDto?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: TranslateViewInput
    func setupInitialState() {
       pageControl.numberOfPages = loopsMaxCount
    }
    
    func setupWordsDataSource(words: [WordDto]) {
        self.words = words
        setup()
    }
    
    // MARK: Internal methods
    func setup() {
        setupData()
        setupView()
    }
    
    func setupData() {
        correctIndex = nil
        translateWords.removeAll()
        incorrectIndexes.removeAll()
        
        currentWord = words.first
        translateWords = words.map({ (word) -> String in
            return word.russian
        })
        
        translateWords.shuffleInPlace()
    }
    
    func setupView() {
        pageControl.currentPage = currentLoop
        textLabel.text = currentWord?.polish
        collectionView.reloadData()
    }
    
    func spellWord() {
        speechService.speak((currentWord?.polish)!, languge: "Pl-pl")
    }
    
    func examDidComplete() {
        let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .Cancel) { (action) -> Void in
            self.output.finishedTranslateExam()
        }
        
        let alertController = UIAlertController(title: NSLocalizedString("Finished", comment: "Finished"), message: NSLocalizedString("You successfully completed this exam", comment: "You successfully completed this exam"), preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(cancelAction)
        
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
        spellWord()
        increaseWordUse()
        collectionView.userInteractionEnabled = false
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(timeinterval * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
            self.collectionView.userInteractionEnabled = true
            
            self.currentLoop++
            if self.currentLoop == self.loopsMaxCount {
                self.examDidComplete()
            } else {
                self.output.viewIsReady()
            }
        })
    }
    
    func increaseWordUse() {
        // TODO:
    }
}


extension TranslateViewController: UICollectionViewDataSource {
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

extension TranslateViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !incorrectIndexes.contains(indexPath) {
            checkTranslateWord(indexPath)
        }
    }
}

extension TranslateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width / 2 - 10, collectionView.frame.size.height / 3 - 10)
    }
}

