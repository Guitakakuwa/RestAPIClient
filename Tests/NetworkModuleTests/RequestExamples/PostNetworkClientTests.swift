//
//  PostNetworkClientTests.swift
//
//
//  Created by Guilherme Takakuwa on 05/03/24.
//

import XCTest
import Foundation
@testable import NetworkModule

final class PostNetworkClientTests: XCTestCase {
    
    func testExamplePostRequestResponseIsEqualRequest() async {
        typealias RequestResponseObject = CreatePostResponse
        let expectation = XCTestExpectation(description: "Receive response")
        let client = APIClient()
        let request = ExampleRequestsStubs.postCreatePost
        do {
            let response: RequestResponseObject = try await client.sendRequest(request: request)
            
            print("Response:", response)
            XCTAssertEqual(
                response.body,
                request.parameters!["body"] as! String,
                "Expected body the same as request"
            )
            
            XCTAssertEqual(
                response.title,
                request.parameters!["title"] as! String,
                "Expected title the same as request"
            )
            
            expectation.fulfill()
        } catch {
            print("Error:", error)
            XCTFail("Error: \(error)")
        }
    }
    
    func testExamplePostRequestResponseIsNotEqualRequest() async {
        typealias RequestResponseObject = CreatePostResponse
        let expectation = XCTestExpectation(description: "Receive response")
        let client = APIClient()
        let request = ExampleRequestsStubs.postCreatePost
        do {
            let response: RequestResponseObject = try await client.sendRequest(request: request)
            
            print("Response:", response)
            XCTAssertNotEqual(
                response.body,
                request.parameters!["title"] as! String,
                "Expected body the same as request"
            )
            
            XCTAssertNotEqual(
                response.title,
                request.parameters!["body"] as! String,
                "Expected title the same as request"
            )
            
            expectation.fulfill()
        } catch {
            print("Error:", error)
            XCTFail("Error: \(error)")
        }
    }
}
