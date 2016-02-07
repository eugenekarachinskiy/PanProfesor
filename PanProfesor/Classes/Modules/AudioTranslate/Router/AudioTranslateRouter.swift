//
//  AudioTranslateRouter.swift
//  PanProfesor
//
//  Created by Eugene  on 26/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

class AudioTranslateRouter: ViperTransitionRouter, AudioTranslateRouterInput {
    func goBack() {
        transitionHandler?.closeModule(true)
    }
}
