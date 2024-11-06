//
//  CharacterRepositoryImplementation.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import Combine

class CharacterRepositoryImplementation {
    
    private let localDataSource: CharacterLocalDataSource
    private let remoteDataSource: CharacterRemoteDataSource
    
    init(localDataSource: CharacterLocalDataSource = CharacterLocalDataSource(),
         remoteDatSource: CharacterRemoteDataSource = CharacterRemoteDataSource()) {
        
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDatSource
    }
}

extension CharacterRepositoryImplementation: CharacterRepository {
    
    func getCharacters() -> AnyPublisher<[Character], any Error> {
        
        return remoteDataSource.getCharacters().map { serverCharacters -> [Character] in
            
            var characters: [Character] = []
            
            for serverCharacter in serverCharacters.results {
                
                let character = serverCharacter.convertToEntity()
                self.localDataSource.saveCharacter(character: character)
                characters.append(character)
            }
            
            return characters
        }
        .mapError({ $0 })
        .eraseToAnyPublisher()
    }
}
