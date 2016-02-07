//
//  TrainingCardsInitializer.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class TrainingCardsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var viewController: TrainingCardsViewController!

    override func awakeFromNib() {

        let configurator = TrainingCardsModuleConfigurator()
        configurator.configureModuleForViewInput(viewController)
    }

}
