//
//  CardsInitializer.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class CardsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var viewController: CardsViewController!

    override func awakeFromNib() {

        let configurator = CardsModuleConfigurator()
        configurator.configureModuleForViewInput(viewController)
    }

}
