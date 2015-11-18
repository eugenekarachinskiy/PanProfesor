//
//  TrueOrFalseViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 9/26/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit
import CoreData

class TrueOrFalseViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var pageControl: UIPageControl?
   
    var currentIndex = 0
    
    lazy var fetchedResultsController: NSFetchedResultsController? = {
        guard let context = DataBaseManager.defaultManager.manangedObjectContext,
            let currentSection = self.section else {
                return nil
        }
        
        let sortDescriptor = NSSortDescriptor(key: "used", ascending: false)
        
        let fetchedRequest = NSFetchRequest(entityName: "Word")
        fetchedRequest.predicate = NSPredicate(format: "section == %@", currentSection)
        fetchedRequest.sortDescriptors = [sortDescriptor]
        fetchedRequest.fetchLimit = 10
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupFetchedResultsController()
        setupView()
    }
    
    func setupFetchedResultsController() {
        do {
            try fetchedResultsController?.performFetch()
        } catch let error {
            print("error setup fetch \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func truePressed(sender: AnyObject) {
        if true {
            answeredTruthly()
        } else {
            answeredFalsely()
        }
    }
    
    @IBAction func falsePressed(sender: AnyObject) {
        if false {
            answeredTruthly()
        } else {
            answeredFalsely()
        }
    }
    
    func answeredTruthly() {
        currentIndex++
        showCurrentCard(animated: true)
    }
    
    func answeredFalsely() {
        
    }
    
    func setupView() {
        self.pageControl?.numberOfPages = 10;
    }
    
    
    //MARK: Show Card Methods
    
    func showCurrentCard(animated animated: Bool) {
        showCard(index: currentIndex, animated: animated)
    }
    
    func showCard(index index: Int, animated: Bool) {
        let numberOfItems = collectionView?.numberOfItemsInSection(0)
        if index < numberOfItems {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: animated)
            pageControl?.currentPage = index
        } else {
            print("index out of range")
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

extension TrueOrFalseViewController: NSFetchedResultsControllerDelegate {
    
}


extension TrueOrFalseViewController: UICollectionViewDataSource {
    
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
        
        let word = fetchedResultsController?.fetchedObjects?[indexPath.row] as? Word
        collectionViewCell.updateWithWord(word)
        
        return collectionViewCell
    }
}

extension TrueOrFalseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
