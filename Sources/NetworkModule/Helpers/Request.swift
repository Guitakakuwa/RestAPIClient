//
//  File.swift
//  
//
//  Created by Guilherme Takakuwa on 26/02/24.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
}

extension Request {
    var url: URL {
        baseURL.appendingPathComponent(endpoint)
    }
    
    func makeURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return request
    }
}
