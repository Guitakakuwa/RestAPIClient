//
//  ErrorHandlingTests.swift
//
//
//  Created by Guilherme Takakuwa on 29/02/24.
//

import XCTest
import Foundation
@testable import NetworkModule

final class ErrorHandlingTests: XCTestCase {
    func testResponseCouldNotParseRequestAndThrowsParsingErrorMocked() async {
        // Given
        typealias RequestResponseObject = [String: String]
        let client = APIClient()
        let request = GetSingleCardRequest.getSingleCard
        
        // When
        do {
            // Perform the request
            let _: RequestResponseObject = try await client.sendRequest(request: request)
            
            // If the request succeeds unexpectedly, fail the test
            XCTFail("Request succeeded unexpectedly")
        } catch let error as HTTPRequestError {
            // Then
            switch error {
            case .networkError(let responseError):
                // Ensure that the response error is a decoding error
                if case HTTPRequestError.decodingError = responseError {
                    XCTAssertTrue(true, "Expected decoding error")
                } else {
                    XCTFail("Unexpected network error: \(responseError)")
                }
            default:
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            XCTFail("Unexpected error occurred: \(error)")
        }
    }
}
