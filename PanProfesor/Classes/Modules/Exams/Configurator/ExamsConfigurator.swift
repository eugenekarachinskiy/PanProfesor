//
//  ExamsConfigurator.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class ExamsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ExamsViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: ExamsViewController) {

        let router = ExamsRouter()
        router.transitionHandler = viewController

        let presenter = ExamsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ExamsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        viewController.moduleInput = presenter
    }

}
