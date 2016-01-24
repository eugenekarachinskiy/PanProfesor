//
//  ViperModuleTransitionHandler.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import UIKit

typealias ConfigurationBlock = (input: ViperBaseModuleInput?) -> (ViperBaseModuleOutput?)

protocol ViperModuleTransitionHandlerProtocol: class {
    
    weak var moduleInput: ViperBaseModuleInput? { get set }
    
    func openModule(segueIdentifier: String, configurationBlock: ConfigurationBlock)
    func closeModule(animated: Bool)
}

extension ViperModuleTransitionHandlerProtocol where Self: UIViewController {
    
    func openModule(segueIdentifier: String, configurationBlock: ConfigurationBlock) {
        let segueInfo = SegueInfo()
        segueInfo.configurationBlock = configurationBlock
        
        performSegueWithIdentifier(segueIdentifier, sender: segueInfo)
    }
    
    func closeModule(animated: Bool) {
        navigationController?.popViewControllerAnimated(animated)
    }
    
}