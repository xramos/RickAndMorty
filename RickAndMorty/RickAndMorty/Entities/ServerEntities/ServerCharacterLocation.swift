//
//  ServerLocation.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation

struct ServerCharacterLocation: Codable {
    
    let id: Int?
    let name: String
    let url: String
    let type: String?
    let dimension: String?
    
    func convertToEntity() -> CharacterLocation {
        
        return CharacterLocation(id: id ?? 1,
                                 name: name,
                                 type: type ?? "",
                                 dimension: dimension ?? "")
    }
}
