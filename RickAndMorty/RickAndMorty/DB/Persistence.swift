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
}
