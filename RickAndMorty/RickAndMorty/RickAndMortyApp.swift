//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import SwiftUI

@main
struct RickAndMortyApp: App {

    var body: some Scene {
        
        WindowGroup {
            
            NavigationView {
                
                CharacterListView()
            }
            .tint(Color.tertiary)
        }
    }
}
