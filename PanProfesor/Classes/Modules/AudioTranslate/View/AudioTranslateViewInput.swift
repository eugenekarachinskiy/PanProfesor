//
//  AudioTranslateViewInput.swift
//  PanProfesor
//
//  Created by Eugene  on 26/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

protocol AudioTranslateViewInput: class {

    /**
        @author Eugene 
        Setup initial state of the view
    */

    func setupInitialState()
    func displayWords(words:[WordDto])
}
