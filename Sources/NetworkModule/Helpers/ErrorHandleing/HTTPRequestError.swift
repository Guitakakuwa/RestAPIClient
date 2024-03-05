//
//  HTTPRequestError.swift
//
//
//  Created by Guilherme Takakuwa on 25/02/24.
//

import Foundation

enum HTTPRequestError: Error, Equatable {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError
    case invalidStatusCode(Int)
    case clientError(Int, String)
    case serverError(Int, String)
    
    static func == (lhs: HTTPRequestError, rhs: HTTPRequestError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.networkError(let error1), .networkError(let error2)):
            return "\(error1)" == "\(error2)"
        case (.invalidResponse, .invalidResponse):
            return true
        case (.decodingError, .decodingError):
            return true
        case (.invalidStatusCode(let code1), .invalidStatusCode(let code2)):
            return code1 == code2
        case (.clientError(let code1, let message1), .clientError(let code2, let message2)):
            return code1 == code2 && message1 == message2
        case (.serverError(let code1, let message1), .serverError(let code2, let message2)):
            return code1 == code2 && message1 == message2
        default:
            return false
        }
    }
}
