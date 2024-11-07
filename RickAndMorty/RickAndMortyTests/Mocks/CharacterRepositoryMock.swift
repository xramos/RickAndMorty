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
    var isGetLocationCalled: Bool = false
    
    func getCharacters(page: Int) -> AnyPublisher<CharacterInformation, any Error> {
        
        isGetCharactersCalled = true
        
        return Result.Publisher(CharacterInformation(pages: 1, characters: []))
            .eraseToAnyPublisher()
    }
    
    func getLocation(isForced: Bool, locationId: Int) -> AnyPublisher<CharacterLocation, any Error> {
        
        isGetLocationCalled = true
        
        return Result.Publisher(CharacterLocation(id: 1, name: "", type: "", dimension: ""))
            .eraseToAnyPublisher()
    }
}
