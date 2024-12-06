//
//  CharacterLocation.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation

struct CharacterLocation: Equatable {
    
    let id: Int
    let name: String
    let type: String
    let dimension: String
    
    static func ==(lhs: CharacterLocation, rhs: CharacterLocation) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.dimension == rhs.dimension
    }
}
