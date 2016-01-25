//
//  SectionsModuleAssembly.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/25/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import UIKit

class SectionsModuleAssembly: ViperAssembly {
    
    override func configure(viewInput: UIViewController) {
        super.configure(viewInput)
        
        if let sessionVC = viewController as? SectionsViewController {
            let router = SectionsRouter()
            router.transitionHandler = sessionVC
            
            let presenter = SectionsPresenter()
            presenter.view = sessionVC
            presenter.router = router
            
            let interactor = SectionsInteractor()
            interactor.output = presenter
            
            presenter.interactor = interactor
            sessionVC.output = presenter
        }
    }
}