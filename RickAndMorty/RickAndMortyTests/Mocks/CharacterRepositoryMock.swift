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
    
    func getCharacters(page: Int) -> AnyPublisher<CharacterInformation, any Error> {
        
        isGetCharactersCalled = true
        
        return Result.Publisher(CharacterInformation(pages: 1, characters: [])).eraseToAnyPublisher()
    }
}
