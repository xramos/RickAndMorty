//
//  Character.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation

struct Character: Identifiable, Equatable, Hashable {
    
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: Gender
    let image: String
}
