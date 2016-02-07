//
//  TrainingCardsConfigurator.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class TrainingCardsModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? TrainingCardsViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: TrainingCardsViewController) {

        let router = TrainingCardsRouter()

        let presenter = TrainingCardsPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = TrainingCardsInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        viewController.moduleInput = presenter
    }

}
