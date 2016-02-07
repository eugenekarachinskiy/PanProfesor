//
//  CardsConfiguratorTests.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import XCTest

class CardsModuleConfiguratorTests: XCTestCase {

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
        let viewController = CardsViewControllerMock()
        let configurator = CardsModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "CardsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is CardsPresenter, "output is not CardsPresenter")

        let presenter: CardsPresenter = viewController.output as! CardsPresenter
        XCTAssertNotNil(presenter.view, "view in CardsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in CardsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is CardsRouter, "router is not CardsRouter")

        let interactor: CardsInteractor = presenter.interactor as! CardsInteractor
        XCTAssertNotNil(interactor.output, "output in CardsInteractor is nil after configuration")
    }

    class CardsViewControllerMock: CardsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
