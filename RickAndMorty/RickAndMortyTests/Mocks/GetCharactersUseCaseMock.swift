//
//  GetCharactersUseCaseMock.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import Combine

@testable import RickAndMorty

class GetCharactersUseCaseMock: GetCharactersUseCase {
    
    var isExecuteCalled: Bool = false
    
    func execute(page: Int) -> AnyPublisher<CharacterInformation, any Error> {
        
        isExecuteCalled = true
        
        return Result.Publisher(CharacterInformation(pages: 1, characters: [])).eraseToAnyPublisher()
    }
}
