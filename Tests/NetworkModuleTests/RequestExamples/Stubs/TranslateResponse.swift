//
//  TranslateResponse.swift
//
//
//  Created by Guilherme Takakuwa on 05/03/24.
//

import Foundation

struct CreatePostResponse: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

