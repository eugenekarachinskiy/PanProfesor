//
//  TranslateConfiguratorTests.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import XCTest

class TranslateModuleConfiguratorTests: XCTestCase {

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
        let viewController = TranslateViewControllerMock()
        let configurator = TranslateModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "TranslateViewController is nil after configuration")
        XCTAssertTrue(viewController.output is TranslatePresenter, "output is not TranslatePresenter")

        let presenter: TranslatePresenter = viewController.output as! TranslatePresenter
        XCTAssertNotNil(presenter.view, "view in TranslatePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in TranslatePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is TranslateRouter, "router is not TranslateRouter")

        let interactor: TranslateInteractor = presenter.interactor as! TranslateInteractor
        XCTAssertNotNil(interactor.output, "output in TranslateInteractor is nil after configuration")
    }

    class TranslateViewControllerMock: TranslateViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
