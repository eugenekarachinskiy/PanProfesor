//
//  ViperPresenter.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/24/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class ViperPresenter <ViewInput: AnyObject, InteractorInput, RouterInput> {
    weak var view: ViewInput?
    var router: RouterInput?
    var interactor: InteractorInput?
}