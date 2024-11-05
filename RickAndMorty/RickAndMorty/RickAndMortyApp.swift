//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
