//
//  CardsConfigurator.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class CardsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? CardsViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: CardsViewController) {

        let router = CardsRouter()

        let presenter = CardsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = CardsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        viewController.moduleInput = presenter
    }

}
