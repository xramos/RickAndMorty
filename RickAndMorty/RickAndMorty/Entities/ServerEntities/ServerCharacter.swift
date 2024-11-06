//
//  ServerCharacter.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation

struct ServerCharacter: Codable {
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    
    func convertToEntity() -> Character {
        
        return Character(id: id,
                         name: name,
                         status: CharacterStatus(rawValue: status) ?? .unknown,
                         species: species,
                         type: type,
                         gender: Gender(rawValue: gender) ?? .unknown,
                         image: image)
    }
}
