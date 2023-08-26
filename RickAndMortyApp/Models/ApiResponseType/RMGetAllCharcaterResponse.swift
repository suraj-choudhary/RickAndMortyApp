//
//  RMGetCharcaterResponse.swift
//  RickAndMortyApp
//
//  Created by suraj kumar on 21/08/23.
//

import Foundation

struct RMGetAllCharcaterResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    let info: Info?
    let results: [RMCharacter]
}

