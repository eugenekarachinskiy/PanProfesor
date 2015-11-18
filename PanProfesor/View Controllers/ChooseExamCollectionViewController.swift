//
//  ChooseExamCollectionViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 11/17/15.
//  Copyright © 2015 Eugene Karachinskiy. All rights reserved.
//

import UIKit

class ChooseExamCollectionViewController: UICollectionViewController {

    let tasks = ["Карточки", "Собери слово", "Мемория", "Верно-Неверно", "Собери пару"]//, // "Собери слово аудио", "Выбери перевод аудио", "Тренировочные карточки"]
    let segues = ["cardsSegueIdentifier", "makeWordSegueIdentifier", "memorySegueIdentifier", "trueOrFalseSegueIdentifier", "makePairSegueIdentifier"]//, "", "", "", "", "", "", "", "", "", "", "",]
    
    var section: Section?

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? BaseViewController {
            destVC.section = section
        }
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier = "examCellIdentifier"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ExamCollectionViewCell
        
        cell.textLabel.text = tasks[indexPath.row]
        cell.backgroundColor = UIColor.yellowColor()
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(segues[indexPath.row], sender: nil)
    }
}

