//
//  TrainingCardsConfiguratorTests.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import XCTest

class TrainingCardsModuleConfiguratorTests: XCTestCase {

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
        let viewController = TrainingCardsViewControllerMock()
        let configurator = TrainingCardsModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewController)

        //then
        XCTAssertNotNil(viewController.output, "TrainingCardsViewController is nil after configuration")
        XCTAssertTrue(viewController.output is TrainingCardsPresenter, "output is not TrainingCardsPresenter")

        let presenter: TrainingCardsPresenter = viewController.output as! TrainingCardsPresenter
        XCTAssertNotNil(presenter.view, "view in TrainingCardsPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in TrainingCardsPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is TrainingCardsRouter, "router is not TrainingCardsRouter")

        let interactor: TrainingCardsInteractor = presenter.interactor as! TrainingCardsInteractor
        XCTAssertNotNil(interactor.output, "output in TrainingCardsInteractor is nil after configuration")
    }

    class TrainingCardsViewControllerMock: TrainingCardsViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
