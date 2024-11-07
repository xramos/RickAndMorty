//
//  CharacterLocalDataSource.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation

class CharacterLocalDataSource {
    
    private let dbManager: Persistence
    
    init(dbManager: Persistence = DBManager()) {
        self.dbManager = dbManager
    }
    
    func saveCharacter(character: Character) {
        
        dbManager.saveCharacter(character: character)
    }
    
    func getCharacters() -> [Character] {
        
        return dbManager.getCharacters()
    }
    
    func saveLocation(location: CharacterLocation) {
        
        dbManager.saveLocation(location: location)
    }
    
    func getLocations() -> [CharacterLocation] {
        
        return dbManager.getLocations()
    }
    
    func getLocationById(id: Int) -> CharacterLocation? {
        
        return dbManager.getLocationById(id: id)
    }
}
