//
//  ErrorRequestStub.swift
//
//
//  Created by Guilherme Takakuwa on 05/03/24.
//
import Foundation
@testable import NetworkModule

enum ErrorRequestStub: RequestProtocol {
    case getSingleCardWithoutToken
    case getSingleCardWithWrongParseObject
    
    var method: HTTPMethod {
        switch self {
        case .getSingleCardWithoutToken, .getSingleCardWithWrongParseObject:
            return .get
        }
    }
    
    var baseURL: URL {
        return URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/")!
    }
    
    var path: String {
        switch self {
        case .getSingleCardWithoutToken, .getSingleCardWithWrongParseObject:
            return "cards/Ysera"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .getSingleCardWithoutToken:
            return [
                "X-RapidAPI-Key": "",
                "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
            ]
            
        case .getSingleCardWithWrongParseObject:
            return [
                "X-RapidAPI-Key": "9b7b080c9amsh8b9a685fd112a18p15d825jsn5de5cb4d4cb6",
                "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
            ]
        }
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var responseObjectType: Codable.Type {
        switch self {
        case .getSingleCardWithoutToken:
            return [HeartStoneSingleCardResponse].self
        case .getSingleCardWithWrongParseObject:
            return [String: String].self
        }
        
    }
}

