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

        do {
            let data = try await performRequest(request: urlRequest)
            if let response = try decodeResponse(data, responseType: request.responseObjectType) as? T {
                return response
            } else {
                throw HTTPRequestError.decodingError
            }
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

    func performRequest(request: URLRequest) async throws -> Data {
        let (data, _) = try await session.data(for: request)
        return data
    }

    func decodeResponse<T: Decodable>(_ data: Data, responseType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
