//
//  ViperPresenter.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/24/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class ViperPresenter <InteractorInput, RouterInput> {
//    weak var view: ViperViewInput?
    var view: ViperViewInput?
    var router: RouterInput?
    var interactor: InteractorInput?
}

protocol ViperPresenterProtocol {
    weak var view: ViperViewInput? {get set}
}
