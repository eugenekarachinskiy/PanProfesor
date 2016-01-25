//
//  SectionsViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class SectionsViewController: ViperTransitionViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var output: SectionsViewOutput?
    var data: [SectionDto] = [SectionDto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.setupView()
    }
    
    
    @IBAction func alphabetPressed() {
        output?.showAlphabet()
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
    
    
}

extension SectionsViewController: SectionsViewInput {
    func showSections(sections: [SectionDto]) {
        data = sections
    }
}

extension SectionsViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "sectionCellIdentifier"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! SectionCollectionViewCell
        
        let section = data[indexPath.row]
        cell.textLabel.text = section.title
        
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
}

extension SectionsViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       output?.selectedSection(data[indexPath.row])
    }
}




