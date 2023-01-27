//
//  LikeTest.swift
//  NavigationTests
//
//  Created by Kiryl Rakk on 27/1/23.
//

import XCTest

final class LikeTest: XCTestCase {
    
    var likeHelper : LikeHelper!
    
    override func setUpWithError() throws {
        likeHelper = LikeHelper()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        likeHelper = nil
        try super.tearDownWithError()
    }
    

    func test_likestatusAfter_like() {
        
        // given
        var beforeLikeStatus = true
        let expected = false
        // when
        let fake = FakeLikePresenter()
        likeHelper.delegate = fake
         likeHelper.likePost(isLiked: &beforeLikeStatus)
        let result = likeHelper.likeStatus!
        //than
        XCTAssertEqual(expected, result)
    }
}

class FakeLikePresenter: LikeDelegate {
    func likePost(_ isLike: inout Bool) {
    }
}
