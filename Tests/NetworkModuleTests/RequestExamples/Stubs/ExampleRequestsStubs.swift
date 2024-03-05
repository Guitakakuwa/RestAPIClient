//
//  ExampleRequestsStubs.swift
//
//
//  Created by Guilherme Takakuwa on 05/03/24.
//
import Foundation
@testable import NetworkModule

enum ExampleRequestsStubs: RequestProtocol {
    case getSingleCard
    case postCreatePost
    
    var method: HTTPMethod {
        switch self {
        case .getSingleCard:
            return .get
            
        case .postCreatePost:
            return .post
        }
    }
    
    var baseURL: URL {
        switch self {
        case .getSingleCard:
            return URL(string: "https://omgvamp-hearthstone-v1.p.rapidapi.com/")!
            
        case .postCreatePost:
            return URL(string: "https://jsonplaceholder.typicode.com/")!
        }
    }
    
    var path: String {
        switch self {
        case .getSingleCard:
            return "cards/Ysera"
            
        case .postCreatePost:
            return "posts"
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .getSingleCard:
            return [
                "X-RapidAPI-Key": "9b7b080c9amsh8b9a685fd112a18p15d825jsn5de5cb4d4cb6",
                "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"
            ]
        case .postCreatePost:
            return [ "Content-type": "application/json; charset=UTF-8"]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getSingleCard:
            return nil
        case .postCreatePost:
            return [
                "title": "example title",
                "body": "example body",
                "userId": 1
            ]
        }
    }
    
    var responseObjectType: Codable.Type {
        switch self {
        case .getSingleCard:
            return [HeartStoneSingleCardResponse].self
        case .postCreatePost:
            return CreatePostResponse.self
        }
        
    }
}

