//
//  DBManager.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation
import CoreData

class DBManager {
    
    // MARK: - Properties
    
    let coreDataStack: CoreDataStack
    
    // MARK: - Methods
    
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        
        self.coreDataStack = coreDataStack
    }
}

// MARK: - Persistence

extension DBManager: Persistence {
    
    func saveCharacter(character: Character) {
        
        let dbCharacter = DBCharacter(context: coreDataStack.managedContext)
        dbCharacter.id = Int32(character.id)
        dbCharacter.name = character.name
        dbCharacter.status = character.status.rawValue
        dbCharacter.species = character.species
        dbCharacter.type = character.type
        dbCharacter.gender = character.gender.rawValue
        dbCharacter.image = character.image
        
        coreDataStack.saveContext()
    }
    
    func getCharacters() -> [Character] {
        
        var characters: [Character] = []
        
        let fetchRequest = NSFetchRequest<DBCharacter>(entityName: "DBCharacter")
        
        do {
            
            let dbCharacters = try coreDataStack.managedContext.fetch(fetchRequest)
            
            for dbCharacter in dbCharacters {
                let character = dbCharacter.convertToEntity()
                characters.append(character)
            }
            
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return characters
    }
}
