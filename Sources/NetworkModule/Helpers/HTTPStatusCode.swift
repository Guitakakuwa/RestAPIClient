//
//  HTTPStatusCode.swift
//
//
//  Created by Guilherme Takakuwa on 25/02/24.
//

import Foundation

enum HTTPStatusCode: Int {
    case success = 200
    case empty = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case internalServerError = 500
    case unknown = -1
}
