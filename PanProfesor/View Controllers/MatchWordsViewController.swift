//
//  MatchWordsViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 9/26/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class MatchWordsViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let records: [Record] = [Record(text: "Волосы", translateText: "włosy"), Record(text: "Кожа", translateText: "skóra"), Record(text: "лоб", translateText: "czoło"), Record(text: "висок", translateText: "skroń"), Record(text: "бровь", translateText: "brew")]
    
    let itemsCount = 5;
    
    var elements: [RecordStruct] = [];
    var selectedIndexPaths: [NSIndexPath] = [];
    var correctedIndexPaths: [NSIndexPath] = [];
    
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
        elements.removeAll()
        selectedIndexPaths.removeAll()
        correctedIndexPaths.removeAll()
        fetchData()
    
        for record in records {
            elements.append(RecordStruct(text: record.text, isOriginal: true))
            elements.append(RecordStruct(text: record.translateText, isOriginal: false))
        }
        
        elements.shuffleInPlace()
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
