import XCTest
import Foundation
@testable import NetworkModule

final class GetNetworkModuleTests: XCTestCase {
    
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
           
           wait(for: [expectation], timeout: 10) // Adjust timeout as needed
       }
}
