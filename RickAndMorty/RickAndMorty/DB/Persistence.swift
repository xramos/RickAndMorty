//
//  Persistence.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation

protocol Persistence {
    
    /**
     Save character in DB
     */
    func saveCharacter(character: Character)
    
    /**
     Get Characters
     */
    func getCharacters() -> [Character]
    
    /**
        Save location in DB
     */
    func saveLocation(location: CharacterLocation)
    
    /**
     Get Locations
     */
    func getLocations() -> [CharacterLocation]
    
    /**
     Get Location by specified id if found
     */
    func getLocationById(id: Int) -> CharacterLocation?
}
