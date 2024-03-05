//
//  HTTPRequest.swift
//
//
//  Created by Guilherme Takakuwa on 25/02/24.
//

import Foundation
import Combine

class APIClient: APIClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func sendRequest<T: Decodable, R: RequestProtocol>(request: R) async throws -> T {
        guard let url = buildURL(request: request) else {
            throw HTTPRequestError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        configureRequest(&urlRequest, request: request)
        let responseTuple = try await performRequest(request: urlRequest)
        do {
            if let response = try decodeResponse(
                responseTuple,
                responseType: request.responseObjectType
            ) as? T {
                return response
            } else {
                throw HTTPRequestError.decodingError
            }
        } catch is HTTPRequestClientError {
            let responseStatusCode = (responseTuple.1 as? HTTPURLResponse)?.statusCode ?? HTTPStatusCode.unknown.rawValue
            throw HTTPRequestClientError.clientError(responseStatusCode, "")
        } catch {
            throw HTTPRequestError.networkError(error)
        }
    }
}

private extension APIClient {
    func buildURL<R: RequestProtocol>(request: R) -> URL? {
        var urlComponents = URLComponents(
            url: request.baseURL.appendingPathComponent(request.path),
            resolvingAgainstBaseURL: true
        )
        
        if let parameters = request.parameters,
           request.method == .get {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        }
        
        return urlComponents?.url
    }
    
    func configureRequest<R: RequestProtocol>(_ urlRequest: inout URLRequest, request: R) {
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let parameters = request.parameters,
           request.method != .get {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
    }
    
    func performRequest(request: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: request)
    }
    
    private func decodeResponse<T: Decodable>(_ requestResponse: (Data, URLResponse), responseType: T.Type) throws -> Decodable {
        let decoder = JSONDecoder()
        let data = requestResponse.0
        let response = requestResponse.1
        
        if (try? decoder.decode(ErrorResponse.self, from: data)) != nil {
            try handleResponse(requestResponse)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    func handleResponse(_ requestResponse: (Data,URLResponse)) throws {
        let data = requestResponse.0
        let response = requestResponse.1
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HTTPRequestError.invalidResponse
        }
        
        let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode) ?? .unknown
        
        switch statusCode {
        case .success, .empty:
            // Success status code, do nothing
            break
        case .badRequest, .unauthorized, .forbidden, .notFound:
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw HTTPRequestClientError.clientError(statusCode.rawValue, errorResponse.message)
        case .internalServerError:
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw HTTPRequestClientError.serverError(statusCode.rawValue, errorResponse.message)
        default:
            throw HTTPRequestError.invalidStatusCode(httpResponse.statusCode)
        }
    }
}
