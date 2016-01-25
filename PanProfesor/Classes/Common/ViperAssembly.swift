//
//  ViperAssembly.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/25/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import UIKit

class ViperAssembly: NSObject, ViperModuleConfiguratorProtocol {
    
    @IBOutlet weak var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureModuleForViewInput(viewController)
    }
    
    
    func configureModuleForViewInput(viewInput: UIViewController?) {
        if let vc = viewController {
            configure(vc)
        }
    }
    
    func configure(viewInput: UIViewController) {
        
    }
}