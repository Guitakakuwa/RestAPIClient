//
//  GetSingleCardRequest.swift
//
//
//  Created by Guilherme Takakuwa on 29/02/24.
//
import Foundation

enum GetSingleCardRequest: RequestProtocol {
    case getSingleCard
    
    var method: HTTPMethod {
        switch self {
        case .getSingleCard:
            return .get
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/")!
    }
    
    var path: String {
        switch self {
        case .getSingleCard:
            return "cards/Ysera"
        }
    }
    
    var headers: [String: String]? {
        return [
            "X-RapidAPI-Key": "",
            "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
        ]
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var responseObjectType: Codable.Type {
        return [HeartStoneSingleCardResponse].self
    }
}

