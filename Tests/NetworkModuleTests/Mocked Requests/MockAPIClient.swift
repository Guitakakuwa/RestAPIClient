//
//  MockAPIClient.swift
//
//
//  Created by Guilherme Takakuwa on 05/03/24.
//

import Foundation
@testable import NetworkModule

class MockAPIClient: APIClient {
    var responseData: Data?
    var error: Error?

    override func sendRequest<T: Decodable, R: RequestProtocol>(request: R) async throws -> T {
        if let error = error {
            throw error
        }
        
        if let responseData = responseData {
            let decoder = JSONDecoder()
            do {
                let decodedResponse = try decoder.decode(T.self, from: responseData)
                return decodedResponse
            } catch {
                throw ClientHandlingError.decodingError
            }
        } else {
            throw NSError(
                domain: "MockAPIClient",
                code: 0,
                userInfo: [
                    NSLocalizedDescriptionKey: "Response data not set"
                ]
            )
        }
    }
}
