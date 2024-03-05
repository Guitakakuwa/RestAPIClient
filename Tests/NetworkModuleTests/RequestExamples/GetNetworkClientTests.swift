import XCTest
import Foundation
@testable import NetworkModule

final class GetNetworkClientTests: XCTestCase {
    // This tests ensures that API request is made and response is not empty
    func testExampleGetRequestResponseIsNotEmpty() {
        typealias RequestResponseObject = [HeartStoneSingleCardResponse]
        let expectation = XCTestExpectation(description: "Receive response")
        let client = APIClient()
        let request = ExampleRequestsStubs.getSingleCard
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
        
        wait(for: [expectation], timeout: 5)
    }
}
