//
//  TranslateRouter.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class TranslateRouter: ViperTransitionRouter, TranslateRouterInput {
    
    func goBack() {
        transitionHandler?.closeModule(true)
    }
}
