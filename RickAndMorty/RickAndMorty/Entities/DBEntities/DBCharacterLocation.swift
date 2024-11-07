//
//  DBCharacterLocation.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation

extension DBCharacterLocation {
    
    func convertToEntity() -> CharacterLocation {
        
        return CharacterLocation(id: Int(id),
                                 name: name ?? "",
                                 type: type ?? "",
                                 dimension: dimension ?? "")
    }
}
