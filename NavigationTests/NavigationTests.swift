//
//  NavigationTests.swift
//  NavigationTests
//
//  Created by Kiryl Rakk on 25/1/23.
//

import XCTest
@testable import Navigation

final class NavigationTests: XCTestCase {
    
    var statusHelper : StatusHelper!

    override func setUpWithError() throws {
        statusHelper = StatusHelper()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        statusHelper = nil
    }
    
    // testing textfield with some text
    func test_addingSomeText_in_textField () {
            let expected = "Some text"
            let result = statusHelper.getStatus(text: expected)
            XCTAssertEqual(expected, result)
    }
    
    
    // testing textfield with no text
    func test_emptyField_in_textField() {
        let result = statusHelper.getStatus(text: "")
        XCTAssertNil(result)
    }
    
    // testing textfield with space instead of text
    func test_space_in_textField() {
        let result = statusHelper.getStatus(text: " ")
        XCTAssertNil(result)
    }
    
}
