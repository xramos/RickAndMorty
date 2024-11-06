//
//  TestCoreDataStack.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation
import CoreData

@testable import RickAndMorty

class TestCoreDataStack: CoreDataStack {
    
    override init() {
        
        super.init()
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: Constants.modelName)
        
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        storeContainer = container
    }
}
