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
    
    var headers: [String: String] {
        return [
            "X-RapidAPI-Key": "9b7b080c9amsh8b9a685fd112a18p15d825jsn5de5cb4d4cb6",
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

