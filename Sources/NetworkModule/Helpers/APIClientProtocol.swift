//
//  APIClientProtocol.swift
//
//
//  Created by Guilherme Takakuwa on 25/02/24.
//

import Foundation

protocol HTTPClientProtocol {
    func sendRequest<T: Decodable, R: RequestProtocol>(request: R) async throws -> T
}
