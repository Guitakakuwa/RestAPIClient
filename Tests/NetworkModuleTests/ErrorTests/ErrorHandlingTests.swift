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
    
    func testResponseCouldNotParseRequestAndThrowsParsingError() async {
        // Given
        let baseURL = URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/")!
        let client = HTTPRequest(baseURL: baseURL)
        let endpoint = "cards/Ysera"
        let method: HTTPMethod = .get
        let headers = [
            "X-RapidAPI-Key": "9b7b080c9amsh8b9a685fd112a18p15d825jsn5de5cb4d4cb6",
            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
        ]
        
        // When
        do {
            let response: HeartStoneSingleCardResponse = try await client.sendRequest(
                endpoint: endpoint,
                method: method,
                headers: headers
            )
            
            print("Response:", response)
            XCTFail("Decoding should have failed with type mismatch error")
            
        } catch let error as HTTPRequestError {
            
            // Then
            switch error {
            case .networkError(let decodingError as DecodingError):
                // Ensure that the decoding error is a type mismatch error
                switch decodingError {
                case .typeMismatch(_, _):
                    // Test passes if it reaches here
                    XCTAssert(true, "Received expected type mismatch error")
                default:
                    XCTFail("Received decoding error, but not the expected type mismatch error")
                }
            default:
                XCTFail("Received network error, but not the expected decoding error")
            }
        } catch {
            // If an unexpected error occurred, fail the test
            XCTFail("Unexpected error occurred: \(error)")
        }
    }
}
