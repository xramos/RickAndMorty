//
//  GetCharactersUseCase.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import Combine

protocol GetCharactersUseCaseContract {
    func execute(page: Int) -> AnyPublisher<CharacterInformation, Error>
}

final class GetCharactersUseCase {
    
    private let repository: CharacterRepositoryContract
    
    init(repository: CharacterRepositoryContract = CharacterRepository()) {
        
        self.repository = repository
    }
}

extension GetCharactersUseCase: GetCharactersUseCaseContract {
    
    func execute(page: Int) -> AnyPublisher<CharacterInformation, Error> {
        
        return repository.getCharacters(page: page)
    }
}
