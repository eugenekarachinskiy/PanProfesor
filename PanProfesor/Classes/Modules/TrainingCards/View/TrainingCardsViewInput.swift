//
//  TrainingCardsViewInput.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

protocol TrainingCardsViewInput: class {

    /**
        @author Eugene 
        Setup initial state of the view
    */

    func setupInitialState()
    func setupViewDataSource(words: [WordDto])
}
