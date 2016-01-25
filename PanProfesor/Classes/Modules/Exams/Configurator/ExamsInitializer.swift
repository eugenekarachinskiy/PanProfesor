//
//  ExamsInitializer.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class ExamsModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var viewController: ExamsViewController!

    override func awakeFromNib() {

        let configurator = ExamsModuleConfigurator()
        configurator.configureModuleForViewInput(viewController)
    }

}
