//
//  DBCharacter.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation

extension DBCharacter {
    
    func convertToEntity() -> Character {
        
        return Character(id: Int(id),
                         name: name ?? "",
                         status: CharacterStatus(rawValue: status ?? "") ?? .unknown,
                         species: species ?? "",
                         type: type ?? "",
                         gender: Gender(rawValue: gender ?? "") ?? .unknown,
                         image: image ?? "")
    }
}
