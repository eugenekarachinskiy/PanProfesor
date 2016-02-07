//
//  AudioTranslateConfiguratorTests.swift
//  PanProfesor
//
//  Created by Eugene  on 26/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import XCTest

class AudioTranslateModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = AudioTranslateViewControllerMock()
        let configurator = AudioTranslateModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "AudioTranslateViewController is nil after configuration")
        XCTAssertTrue(viewController.output is AudioTranslatePresenter, "output is not AudioTranslatePresenter")

        let presenter: AudioTranslatePresenter = viewController.output as! AudioTranslatePresenter
        XCTAssertNotNil(presenter.view, "view in AudioTranslatePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in AudioTranslatePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is AudioTranslateRouter, "router is not AudioTranslateRouter")

        let interactor: AudioTranslateInteractor = presenter.interactor as! AudioTranslateInteractor
        XCTAssertNotNil(interactor.output, "output in AudioTranslateInteractor is nil after configuration")
    }

    class AudioTranslateViewControllerMock: AudioTranslateViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
