//
//  ExamsPresenterTests.swift
//  PanProfesor
//
//  Created by Eugene  on 25/01/2016.
//  Copyright © 2016 Eugeniusz Karaczynski. All rights reserved.
//

import XCTest

class ExamsPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: ExamsInteractorInput {

    }

    class MockRouter: ExamsRouterInput {

    }

    class MockViewController: ExamsViewInput {

        func setupInitialState() {

        }
    }
}
