//
//  AlphabetModuleAssembly.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class AlphabetModuleAssembly: NSObject {
    
    @IBOutlet weak var viewController: AlphabetViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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