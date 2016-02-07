//
//  CardsPresenterTests.swift
//  PanProfesor
//
//  Created by Eugene  on 07/02/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import XCTest

class CardsPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: CardsInteractorInput {

    }

    class MockRouter: CardsRouterInput {

    }

    class MockViewController: CardsViewInput {

        func setupInitialState() {

        }
    }
}
