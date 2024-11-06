//
//  GetCharactersUseCaseImplementation.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import Combine

class GetCharactersUseCaseImplementation {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = CharacterRepositoryImplementation()) {
        
        self.repository = repository
    }
}

extension GetCharactersUseCaseImplementation: GetCharactersUseCase {
    
    func execute() -> AnyPublisher<[Character], Error> {
        
        return repository.getCharacters()
    }
}
