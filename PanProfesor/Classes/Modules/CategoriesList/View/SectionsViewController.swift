//
//  SectionsViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/22/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class SectionsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var output: SectionsViewOutput?
    var data: [SectionDto]?
    
    
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
        
        guard let configurationHolder = segue.destinationViewController as? UIViewController,
              let segueInfo = sender as? SegueInfo  else {
            return
        }
        
//        segueInfo.configurationBlock(configurationHolder)
        
        
    }
    
    
}

extension SectionsViewController: SectionsViewInput {
    func showSections(sections: [SectionDto]) {
        data = sections
    }
}
