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
        
        dbCharacter.id = Int16(character.id)
        dbCharacter.name = character.name
        dbCharacter.status = character.status.rawValue
        dbCharacter.species = character.species
        dbCharacter.type = character.type
        dbCharacter.gender = character.gender.rawValue
        dbCharacter.image = character.image
        dbCharacter.originId = Int16(character.originId)
        dbCharacter.locationId = Int16(character.locationId)
        
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
    
    func saveLocation(location: CharacterLocation) {
        
        let dbLocation = DBCharacterLocation(context: coreDataStack.managedContext)
        
        dbLocation.id = Int16(location.id)
        dbLocation.name = location.name
        dbLocation.type = location.type
        dbLocation.dimension = location.dimension
        
        coreDataStack.saveContext()
    }
    
    func getLocations() -> [CharacterLocation] {
        
        var locations: [CharacterLocation] = []
        
        let fetchRequest = NSFetchRequest<DBCharacterLocation>(entityName: "DBCharacterLocation")
        
        do {
            
            let dbLocations = try coreDataStack.managedContext.fetch(fetchRequest)
            
            for dbLocation in dbLocations {
                let location = dbLocation.convertToEntity()
                locations.append(location)
            }
            
        } catch let error as NSError {
            
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return locations
    }
    
    func getLocationById(id: Int) -> CharacterLocation? {
        
        var location: CharacterLocation?
        
        let fetchRequest = NSFetchRequest<DBCharacterLocation>(entityName: "DBCharacterLocation")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        do {
            
            let dbLocations = try coreDataStack.managedContext.fetch(fetchRequest)
            
            if let dbLocation = dbLocations.first {
                
                location = dbLocation.convertToEntity()
            }
            
        } catch let error as NSError {
            
            print("Could not fetch location. \(error), \(error.userInfo)")
        }
        
        return location
    }
}
