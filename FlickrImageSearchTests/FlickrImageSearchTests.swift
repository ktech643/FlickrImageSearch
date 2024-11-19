//
//  FlickrImageSearchTests.swift
//  FlickrImageSearchTests
//
//  Created by Jahan on 19/11/2024.
//

import XCTest
@testable import FlickrImageSearch

final class FlickrImageSearchTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFormattedDate() {//
        let view = DetailView(photo: FlickrItem(title: "", link: "", media: FlickrMedia(imageUrl: ""), dateTaken: "2024-11-19T00:00:00Z", itemDescription: "", published: "", author: "", authorID: "", tags: ""))
        let formatted = view.formattedDate(from: "2024-11-19T00:00:00Z")
        XCTAssertEqual(formatted, "Nov 19, 2024")
    }
    
}
