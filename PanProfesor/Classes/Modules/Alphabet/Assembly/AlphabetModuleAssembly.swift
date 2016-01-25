//
//  AlphabetModuleAssembly.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import UIKit

class AlphabetModuleAssembly: ViperAssembly {
    
    override func configure(viewInput: UIViewController) {
        super.configureModuleForViewInput(viewInput)
        
        if let viewController = viewInput as? AlphabetViewController {
            let router = AlphabetRouter()
            router.transitionHandler = viewController
            
            let presenter = AlphabetPresenter()
            presenter.view = viewController
            presenter.router = router
            
            let interactor = AlphabetInteractor()
            interactor.output = presenter
            
            presenter.interactor = interactor
            viewController.output = presenter
            viewController.moduleInput = presenter
        }
    }
}