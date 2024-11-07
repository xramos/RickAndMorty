//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import SwiftUI

class CharacterDetailViewModel: ObservableObject {
    
    @Published public private(set) var character: Character
    
    // MARK: - Methods
    
    init(character: Character) {
        
        self.character = character
    }
}
