//
//  LoginTest.swift
//  NavigationTests
//
//  Created by Kiryl Rakk on 26/1/23.
//

import XCTest
@testable import Navigation

final class LoginTest: XCTestCase {

    var accountHelper : LoginHelper!
    override func setUpWithError() throws {
        try super.setUpWithError()
        accountHelper = LoginHelper()
    }

    override func tearDownWithError() throws {
        accountHelper = nil
        try super.tearDownWithError()
    }

    func test_filled_field () {
        // given
        accountHelper.delegate = FakePresenter()
        let exampleLogin = "some text"
        // when
        let result = accountHelper.signIn(exampleLogin, password: "")
        // then
        XCTAssertEqual(exampleLogin, result)
    }
    
    func test_empty_field () {
        // given
        accountHelper.delegate = FakePresenter()
        let exampleLogin = ""
        // when
        let result = accountHelper.signIn(exampleLogin, password: "")
        // then
        XCTAssertNil(result)
    }
    
    func test_space_in_field () {
        // given
        accountHelper.delegate = FakePresenter()
        let exampleLogin = " "
        // when
        let result = accountHelper.signIn(exampleLogin, password: "")
        // then
        XCTAssertNil(result)
    }
}


class FakePresenter : CheckerServiceProtocol {
    func signIn(_ email: String, password: String) -> String {
        return email
    }
    
    func signUp(_ email: String, password: String) -> String {
        return ""
    }
    
    func showAccount() {
        
    }
    
    func showCreateAcccount(_ email: String, password: String) {
        
    }
    
    func showAllertAutherization(text: String) {
        
    }
}
