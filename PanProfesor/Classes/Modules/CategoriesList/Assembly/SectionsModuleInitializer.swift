//
//  SectionsModuleInitializer.swift
//  PanProfesor
//
//  Created by Eugene Karachinskiy on 1/23/16.
//  Copyright © 2016 Eugene Karachinskiy. All rights reserved.
//

import Foundation

class SectionsModuleInitializer: NSObject {
    @IBOutlet weak var viewController: SectionsViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let configurator = SectionsModuleConfigurator()
        configurator.configureModuleForViewInput(viewController)
    }
}