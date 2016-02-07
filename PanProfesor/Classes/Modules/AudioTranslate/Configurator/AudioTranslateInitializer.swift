//
//  AudioTranslateInitializer.swift
//  PanProfesor
//
//  Created by Eugene  on 26/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import UIKit

class AudioTranslateModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var viewController: AudioTranslateViewController!

    override func awakeFromNib() {

        let configurator = AudioTranslateModuleConfigurator()
        configurator.configureModuleForViewInput(viewController)
    }

}
