//
//  CharacterRepositoryMock.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import Combine

@testable import RickAndMorty

class CharacterRepositoryMock: CharacterRepository {
    
    var isGetCharactersCalled: Bool = false
    
    func getCharacters() -> AnyPublisher<[Character], any Error> {
        
        isGetCharactersCalled = true
        
        return Result.Publisher([]).eraseToAnyPublisher()
    }
}
