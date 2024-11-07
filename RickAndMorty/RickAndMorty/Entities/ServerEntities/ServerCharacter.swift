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
    
    let origin: ServerCharacterLocation
    let location: ServerCharacterLocation
    
    func convertToEntity() -> Character {
        
        return Character(id: id,
                         name: name,
                         status: CharacterStatus(rawValue: status) ?? .unknown,
                         species: species,
                         type: type,
                         gender: Gender(rawValue: gender) ?? .unknown,
                         image: image,
                         originId: getIdFromURL(url: origin.url),
                         locationId: getIdFromURL(url: location.url)
        )
    }
    
    func getIdFromURL(url: String) -> Int {
        
        let idString = url.replacingOccurrences(of: "https://rickandmortyapi.com/api/location/", with: "")
        return Int(idString) ?? 0
    }
}
