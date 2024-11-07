//
//  CharacterLocationMock.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation

@testable import RickAndMorty

final class CharacterLocationMock {
    
    let id = 1
    let name = "Earth"
    let type = "Planet"
    let dimension = "Dimension C-137"
    let url = "https://rickandmortyapi.com/api/location/1"
    
    // MARK: - DBCharacterLocation
    
    func generateDBCharacterLocation(id: Int? = nil,
                                     name: String? = nil,
                                     type: String? = nil,
                                     dimension: String? = nil,
                                     url: String? = nil) -> DBCharacterLocation {
        
        let dbLocation = DBCharacterLocation(context: TestCoreDataStack().managedContext)
        
        dbLocation.id = Int16(id ?? self.id)
        dbLocation.name = name ?? self.name
        dbLocation.type = type ?? self.type
        dbLocation.dimension = dimension ?? self.dimension
        
        return dbLocation
    }
    
    // MARK: - CharacterLocation
    
    func generateCharacterLocation(id: Int? = nil,
                                   name: String? = nil,
                                   type: String? = nil,
                                   dimension: String? = nil) -> CharacterLocation {
        
        return CharacterLocation(id: id ?? self.id,
                                 name: name ?? self.name,
                                 type: type ?? self.type,
                                 dimension: dimension ?? self.dimension)
    }
    
    // MARK: - ServerCharacterLocation
    
    func generateServerCharacterLocation(id: Int? = nil,
                                         name: String? = nil,
                                         type: String? = nil,
                                         dimension: String? = nil,
                                         url: String? = nil) -> ServerCharacterLocation {
        
        return ServerCharacterLocation(id: id ?? self.id,
                                       name: name ?? self.name,
                                       url: url ?? self.url,
                                       type: type ?? self.type,
                                       dimension: dimension ?? self.dimension)
    }
}
