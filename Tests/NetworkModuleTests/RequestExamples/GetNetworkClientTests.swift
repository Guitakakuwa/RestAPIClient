import XCTest
import Foundation
@testable import NetworkModule

final class GetNetworkClientTests: XCTestCase {
    // This tests ensures that API request is made and response is not empty
    func testExampleGetRequestResponseIsNotEmpty() async {
        typealias RequestResponseObject = [HeartStoneSingleCardResponse]
        let client = APIClient()
        let request = ExampleRequestsStubs.getSingleCard
        
        do {
            let response: RequestResponseObject = try await client.sendRequest(request: request)
            
            print("Response:", response)
            XCTAssert(!response.isEmpty)
        } catch {
            print("Error:", error)
            XCTFail("Error: \(error)")
        }
    }
}
