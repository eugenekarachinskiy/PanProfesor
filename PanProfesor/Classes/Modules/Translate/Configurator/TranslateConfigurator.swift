//
//  TranslateConfigurator.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class TranslateModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? TranslateViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: TranslateViewController) {
        let router = TranslateRouter()
        router.transitionHandler = viewController
        
        let presenter = TranslatePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = TranslateInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        viewController.moduleInput = presenter
    }

}
