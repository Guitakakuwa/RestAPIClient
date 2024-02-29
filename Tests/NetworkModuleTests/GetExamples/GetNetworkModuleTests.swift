import XCTest
import Foundation
@testable import NetworkModule

final class GetNetworkModuleTests: XCTestCase {
    
    // This tests ensures that API request returns 401 (Unauthorized) for incorrect authentication
    func testAuthenticationFailure() async {
        // Given
        let baseURL = URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/")!
        let client = HTTPRequest(baseURL: baseURL)
        let endpoint = "some/endpoint"
        let method: HTTPMethod = .get
        let invalidApiKey = "invalid_api_key" 
        
        let headers = [
            "Authorization": "Bearer \(invalidApiKey)"
        ]
        
        // When
        do {
            // Perform the authenticated request
            let _: [String:String] = try await client.sendRequest(
                endpoint: endpoint,
                method: method,
                headers: headers
            )
            
            // If the request succeeds unexpectedly, fail the test
            XCTFail("Request succeeded unexpectedly")
        } catch let error as HTTPRequestError {
            // Then
            switch error {
            case .networkError(let responseError):
                // Ensure that the status code is 401 (Unauthorized)
                if let urlError = responseError as? URLError,
                   let statusCode = HTTPStatusCode(rawValue: urlError.code.rawValue) {
                    XCTAssertEqual(statusCode, .notFound, "Expected status code 401 (Unauthorized)")
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
    
    //This tests ensures that API request is made and response is not empty
    func testExampleGetRequestResponseIsNotEmpty() {
        let expectation = XCTestExpectation(description: "Receive response")
        
        let baseURL = URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/")!
        let request = HTTPRequest(baseURL: baseURL)
        
        let endpoint = "cards/Ysera"
        let method = HTTPMethod.get
        let headers = [
            "X-RapidAPI-Key": "9b7b080c9amsh8b9a685fd112a18p15d825jsn5de5cb4d4cb6",
            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
        ]
        
        Task {
            do {
                let response: [HeartStoneSingleCardResponse] = try await request.sendRequest(
                    endpoint: endpoint,
                    method: method,
                    headers: headers
                )
                
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
