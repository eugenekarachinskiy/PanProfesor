//
//  ExamsConfiguratorTests.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import XCTest

class ExamsModuleConfiguratorTests: XCTestCase {

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
        let viewController = ExamsViewControllerMock()
        let configurator = ExamsModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "ExamsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is ExamsPresenter, "output is not ExamsPresenter")

        let presenter: ExamsPresenter = viewController.output as! ExamsPresenter
        XCTAssertNotNil(presenter.view, "view in ExamsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in ExamsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is ExamsRouter, "router is not ExamsRouter")

        let interactor: ExamsInteractor = presenter.interactor as! ExamsInteractor
        XCTAssertNotNil(interactor.output, "output in ExamsInteractor is nil after configuration")
    }

    class ExamsViewControllerMock: ExamsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
