//
//  File.swift
//  
//
//  Created by Guilherme Takakuwa on 26/02/24.
//

import Foundation

struct HeartStoneSingleCardResponse: Codable {
    let cardId: String
    let dbfId: Int
    let name: String
    let cardSet: String
    let type: String
    let faction: String?
    let rarity: String?
    let cost: Int?
    let attack: Int?
    let health: Int?
    let armor: String?
    let text: String?
    let flavor: String?
    let artist: String?
    let playerClass: String
    let img: URL?
    let imgGold: URL?
    let locale: String
    let elite: Bool?
    let race: String?
    let mechanics: [Mechanic]?
}

struct Mechanic: Codable {
    let name: String
}
