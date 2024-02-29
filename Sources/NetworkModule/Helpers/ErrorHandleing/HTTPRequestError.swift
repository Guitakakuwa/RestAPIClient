//
//  HTTPRequestError.swift
//
//
//  Created by Guilherme Takakuwa on 25/02/24.
//

import Foundation

enum HTTPRequestError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    case invalidStatusCode(Int)
}
