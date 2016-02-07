//
//  TranslateInitializer.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class TranslateModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var viewController: TranslateViewController!

    override func awakeFromNib() {

        let configurator = TranslateModuleConfigurator()
        configurator.configureModuleForViewInput(viewController)
    }

}
