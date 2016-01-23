//
//  SectionsModuleConfigurator.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation
import UIKit

class SectionsModuleConfigurator: BaseModuleConfiguratorProtocol {
    
    func configureModuleForViewInput(viewInput: UIViewController) {
        if let sectionsViewController = viewInput as? SectionsViewController {
            configure(sectionsViewController)
        }
    }
    
    private func configure(viewController: SectionsViewController) {
        let router = SectionsRouter()
        router.transitionHandler = viewController
        
        let presenter = SectionsPresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = SectionsInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
    }
}
