//
//  MemoryWordsViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 9/26/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class Record {
    let text: String
    let translateText: String
    
     init(text: String, translateText: String) {
        self.text = text
        self.translateText = translateText
    }
}

struct RecordStruct {
    var text: String
    var isOriginal: Bool
    
    init(text: String, isOriginal: Bool) {
        self.text = text
        self.isOriginal = isOriginal
    }
}

class MemoryWordsViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let records: [Record] = [Record(text: "Волосы", translateText: "włosy"), Record(text: "Кожа", translateText: "skóra"), Record(text: "лоб", translateText: "czoło"), Record(text: "висок", translateText: "skroń"), Record(text: "бровь", translateText: "brew")]
    let timeInterval = 5.0
    let itemsCount = 5;
    
    var elements: [RecordStruct] = [];
    var selectedIndexPaths: [NSIndexPath] = [];
    var correctedIndexPaths: [NSIndexPath] = [];
    
    var timer: NSTimer?
    var wordsHidden = false;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData() {
        
    }
    
    func setupData() {
        fetchData()
        elements.removeAll()
        
        for record in records {
            elements.append(RecordStruct(text: record.text, isOriginal: true))
            elements.append(RecordStruct(text: record.translateText, isOriginal: false))
        }
        
        elements.shuffleInPlace()
        
        wordsHidden = false
        selectedIndexPaths.removeAll()
        correctedIndexPaths.removeAll()
        
        collectionView.userInteractionEnabled = false
        collectionView.reloadData()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "hideAllWords", userInfo: nil, repeats: false)
    }
    
    func hideAllWords() {
        wordsHidden = true
        collectionView.userInteractionEnabled = true
        collectionView.reloadData()
    }

    func finishedCurrent() {
        setupData()
    }
    
    func checkPair() {
        if selectedIndexPaths.count == 2 {
            guard let firstIndex = selectedIndexPaths.first,
                  let secondIndex = selectedIndexPaths.last else {
                return
            }
            
            let firstRecord = elements[firstIndex.row]
            let secondRecord = elements[secondIndex.row]
            collectionView.userInteractionEnabled = false;
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue(), { () -> Void in
            
                if self.compareRecords(firstRecord, secondRecord: secondRecord) {
                    self.correctedIndexPaths.appendContentsOf(self.selectedIndexPaths)
                }
                
                self.collectionView.userInteractionEnabled = true
                self.selectedIndexPaths.removeAll()
                self.collectionView.reloadData()
                
                if self.correctedIndexPaths.count == self.itemsCount * 2 {
                    self.finishedCurrent()
                }
            })
        }
    }
    
    func compareRecords(firstRecord: RecordStruct, secondRecord: RecordStruct) -> Bool {
        if firstRecord.isOriginal != secondRecord.isOriginal {
            let originalText = firstRecord.isOriginal ? firstRecord.text : secondRecord.text
            let translatedText = !secondRecord.isOriginal ? secondRecord.text : firstRecord.text
            
            let filteredArray = records.filter() { $0.text.lowercaseString == originalText.lowercaseString && $0.translateText.lowercaseString == translatedText.lowercaseString }
            return (filteredArray.count > 0)
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

extension MemoryWordsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount * 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "memoryWordIdentifier"
        let collectionViewCell:MemoryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! MemoryCollectionViewCell
        
        let record = elements[indexPath.row]
        let textHidden = selectedIndexPaths.contains(indexPath) ? false : wordsHidden
        let alpha: CGFloat = !correctedIndexPaths.contains(indexPath) ? 1.0 : 0.0
        let backgroundColor = record.isOriginal ? UIColor.blueColor() : UIColor.yellowColor()
        
        collectionViewCell.updateWithText(record.text, backgroundColor: backgroundColor, textHidden: textHidden, alpha: alpha)
        return collectionViewCell
    }
}

extension MemoryWordsViewController: UICollectionViewDelegate {
    
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


extension MemoryWordsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(collectionView.frame.size.width / 2 - 10, collectionView.frame.size.height / 5 - 10)
    }
}
