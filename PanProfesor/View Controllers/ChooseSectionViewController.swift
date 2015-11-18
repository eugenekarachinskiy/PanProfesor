//
//  ChooseSectionViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/17/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit
import CoreData

class ChooseSectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    lazy var sectionsFetchedResultsController: NSFetchedResultsController = {
        let moc = DataBaseManager.defaultManager.manangedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "Section")
        fetchRequest.sortDescriptors = Array()
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchedResultsController()
    }
    
    func setupFetchedResultsController() {
        do {
            try sectionsFetchedResultsController.performFetch()
        } catch let error {
            print("error setup fetch \(error)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? ChooseExamCollectionViewController {
            destVC.section = sender as? Section
        }
    }
}


extension ChooseSectionViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView.reloadData()
    }
}

extension ChooseSectionViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = sectionsFetchedResultsController.fetchedObjects?.count {
            return count
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "sectionCellIdentifier"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! SectionCollectionViewCell

        if let fetchedObjects = sectionsFetchedResultsController.fetchedObjects {
            if let section = fetchedObjects[indexPath.row] as? Section {
                cell.textLabel.text = section.title
            }
        }
        
        cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
}

extension ChooseSectionViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let fetchedObjects = sectionsFetchedResultsController.fetchedObjects {
            if let section = fetchedObjects[indexPath.row] as? Section {
                performSegueWithIdentifier("chooseExamSegue", sender: section)
            }
        }
    }
}
