//
//  Character.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation

struct Character: Identifiable, Equatable, Hashable {
    
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: Gender
    let image: String
    let originId: Int
    let locationId: Int
    
    static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.status.rawValue == rhs.status.rawValue &&
        lhs.species == rhs.species &&
        lhs.type == rhs.type &&
        lhs.gender.rawValue == rhs.gender.rawValue &&
        lhs.image == rhs.image &&
        lhs.originId == rhs.originId &&
        lhs.locationId == rhs.locationId
    }
}
