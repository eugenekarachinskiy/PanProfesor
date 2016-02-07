//
//  ExamsViewController.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class ExamsViewController: UICollectionViewController, ExamsViewInput, ViperModuleTransitionHandlerProtocol {

    weak var moduleInput: AnyObject?
    var output: ExamsViewOutput!
    var exams: [ExamItem] = [ExamItem]()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: ExamsViewInput
    func setupInitialState() {
    }
    
    func showExams(exams: [ExamItem]) {
        self.exams = exams
        self.collectionView?.reloadData()
    }
    
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        guard let configurationHolder = segue.destinationViewController as? ViperModuleTransitionHandlerProtocol,
            let segueInfo = sender as? SegueInfo  else {
                return
        }
        
        segueInfo.configurationBlock?(input: configurationHolder.moduleInput)
    }
    
    // MARK: UICollectionViewDataSource UICollectionViewDelegate
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exams.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "examCellIdentifier"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExamCollectionViewCell
        
        cell.textLabel.text = exams[indexPath.row].title
        cell.backgroundColor = UIColor.yellowColor()
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        output.examSelected(exams[indexPath.row])
    }
}

