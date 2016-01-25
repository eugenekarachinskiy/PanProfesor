//
//  ViperViewController.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/24/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import UIKit

class ViperViewController<ViewOutput>: UIViewController, ViperModuleTransitionHandlerProtocol {
    weak var moduleInput: ViperBaseModuleInput? // weak reference to presenter
    var output: ViewOutput?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        guard let configurationHolder = segue.destinationViewController as? ViperBaseTransitionViewController,
            let segueInfo = sender as? SegueInfo  else {
                return
        }
        
        segueInfo.configurationBlock?(input: configurationHolder.moduleInput)
    }
}
