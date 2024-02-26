//
//  APIClientProtocol.swift
//
//
//  Created by Guilherme Takakuwa on 25/02/24.
//

import Foundation

protocol HTTPClientProtocol {
    func sendRequest<T: Codable>(endpoint: String,
                                  method: HTTPMethod,
                                  parameters: [String: Any]?,
                                  headers: [String: String]?) async throws -> T
}

extension HTTPClientProtocol {
    func sendRequest<T: Codable>(endpoint: String,
                                  method: HTTPMethod = .get,
                                  parameters: [String: Any]? = nil,
                                  headers: [String: String]? = nil) async throws -> T {
        return try await sendRequest(endpoint: endpoint, method: method, parameters: parameters, headers: headers)
    }
}
