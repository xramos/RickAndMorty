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
    
    func execute() -> AnyPublisher<[Character], any Error> {
        
        isExecuteCalled = true
        
        return Result.Publisher([]).eraseToAnyPublisher()
    }
}
