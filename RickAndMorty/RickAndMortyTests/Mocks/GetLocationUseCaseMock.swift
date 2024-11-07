//
//  GetLocationUseCaseMock.swift
//  RickAndMortyTests
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation
import Combine

@testable import RickAndMorty

class GetLocationUseCaseMock: GetLocationUseCase {
    
    var isExecuteCalled: Bool = false
    
    func execute(locationId: Int) -> AnyPublisher<CharacterLocation, any Error> {
        
        isExecuteCalled = true
        
        return Result.Publisher(CharacterLocationMock().generateCharacterLocation())
            .eraseToAnyPublisher()
    }
}
