//
//  Request.swift
//
//
//  Created by Guilherme Takakuwa on 26/02/24.
//

import Foundation
protocol RequestProtocol {
    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var responseObjectType: Codable.Type { get }
}
