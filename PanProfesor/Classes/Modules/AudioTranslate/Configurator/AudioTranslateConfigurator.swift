//
//  AudioTranslateConfigurator.swift
//  PanProfesor
//
//  Created by Eugene  on 26/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class AudioTranslateModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AudioTranslateViewController {
            configure(viewController)
        }
    }

    private func configure(viewController: AudioTranslateViewController) {
        let router = AudioTranslateRouter()
        router.transitionHandler = viewController
        
        let presenter = AudioTranslatePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AudioTranslateInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
        viewController.moduleInput = presenter
    }

}
