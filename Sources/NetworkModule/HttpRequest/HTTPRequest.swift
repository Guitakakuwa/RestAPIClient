import Foundation
import Combine

class HTTPRequest: HTTPClientProtocol {

    private let baseURL: URL
    private let session: URLSession
    
    init(
        baseURL: URL
    ) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: .default)
    }
    
    func sendRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?
    ) async throws -> T {
        
        guard let url = buildURL(
            endpoint: endpoint,
            parameters: parameters
        ) else {
            throw HTTPRequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        configureRequest(
            &request,
            method: method,
            parameters: parameters,
            headers: headers
        )
        
        do {
            let data = try await performRequest(request)
            return try decodeResponse(data)
        } catch {
            throw HTTPRequestError.networkError(error)
        }
    }
}

extension HTTPRequest {
    private func buildURL(
        endpoint: String,
        parameters: [String: Any]?
    ) -> URL? {
        var urlComponents = URLComponents(
            url: baseURL.appendingPathComponent(endpoint),
            resolvingAgainstBaseURL: true
        )
        
        if let parameters = parameters,
           HTTPMethod.get == .get {
            urlComponents?.queryItems = parameters.map {
                URLQueryItem(
                    name: $0,
                    value: "\($1)"
                )
            }
        }
        
        return urlComponents?.url
    }
    
    private func configureRequest(
        _ request: inout URLRequest,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?
    ) {
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            headers.forEach {
                request.addValue(
                    $1,
                    forHTTPHeaderField: $0
                )
            }
        }
        
        if let parameters = parameters,
           HTTPMethod.get != method {
            request.httpBody = try? JSONSerialization.data(
                withJSONObject: parameters,
                options: []
            )
        }
    }
    
    private func performRequest(
        _ request: URLRequest
    ) async throws -> Data {
        let (data, _) = try await session.data(for: request)
        return data
    }
    
    private func decodeResponse<T: Decodable>(
        _ data: Data
    ) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(
            T.self,
            from: data
        )
    }
}
