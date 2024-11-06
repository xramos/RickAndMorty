//
//  CharacterMock.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation

@testable import RickAndMorty

final class CharacterMock {
    
    let id = 1
    let name = "Rick Sanchez"
    let status = "Alive"
    let species = "Human"
    let type = ""
    let gender = "Male"
    let image = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    
    // MARK: - Character
    
    func generateCharacter(id: Int? = nil,
                           name: String? = nil,
                           status: CharacterStatus? = nil,
                           species: String? = nil,
                           type: String? = nil,
                           gender: Gender? = nil,
                           image: String? = nil) -> Character {
        
        return Character(id: id ?? self.id,
                         name: name ?? self.name,
                         status: status ?? .unknown,
                         species: species ?? self.species,
                         type: type ?? self.type,
                         gender: gender ?? .unknown,
                         image: image ?? self.image)
    }
    
    // MARK: - ServerCharacter
    
    func generateServerCharacter(id: Int? = nil,
                                 name: String? = nil,
                                 status: String? = nil,
                                 species: String? = nil,
                                 type: String? = nil,
                                 gender: String? = nil,
                                 image: String? = nil) -> ServerCharacter {
        
        return ServerCharacter(id: id ?? self.id,
                               name: name ?? self.name,
                               status: status ?? self.status,
                               species: species ?? self.species,
                               type: type ?? self.type,
                               gender: gender ?? self.gender,
                               image: image ?? self.image)
    }
}
