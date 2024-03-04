import XCTest
import Foundation
@testable import NetworkModule

final class GetNetworkModuleTests: XCTestCase {
    
    // This tests ensures that API request returns 401 (Unauthorized) for incorrect authentication
    func testAuthenticationFailure() async {
        // Given
        typealias RequestResponseObject = [String:String]
        let client = APIClient()
        let invalidApiKey = "invalid_api_key"
        let request = GetSingleCardRequest.getSingleCard
        
        // When
        do {
            // Perform the request
            let _: RequestResponseObject  = try await client.sendRequest(request: request)
            
            // If the request succeeds unexpectedly, fail the test
            XCTFail("Request succeeded unexpectedly")
        } catch let error as HTTPRequestError {
            // Then
            switch error {
            case .networkError(let responseError):
                // Ensure that the status code is 401 (Unauthorized)
                if let urlError = responseError as? URLError,
                   let statusCode = HTTPStatusCode(rawValue: urlError.code.rawValue) {
                    XCTAssertEqual(statusCode, .unauthorized, "Expected status code 401 (Unauthorized)")
                } else {
                    XCTFail("Unexpected error: \(error)")
                }
            default:
                // If the error is not a network error, fail the test
                XCTFail("Unexpected error: \(error)")
            }
        } catch {
            // If an unexpected error occurred, fail the test
            XCTFail("Unexpected error occurred: \(error)")
        }
    }
    
    // This tests ensures that API request is made and response is not empty
    func testExampleGetRequestResponseIsNotEmpty() {
        typealias RequestResponseObject = [HeartStoneSingleCardResponse]
        let expectation = XCTestExpectation(description: "Receive response")
        let client = APIClient()
        let request = GetSingleCardRequest.getSingleCard
        Task {
            do {
                let response: RequestResponseObject = try await client.sendRequest(request: request)
                
                print("Response:", response)
                XCTAssert(!response.isEmpty)
                
                expectation.fulfill()
            } catch {
                print("Error:", error)
                XCTFail("Error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 50)
    }
}
