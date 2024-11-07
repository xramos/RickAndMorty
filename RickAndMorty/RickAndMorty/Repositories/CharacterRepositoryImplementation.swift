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
    
    func getCharacters(page: Int) -> AnyPublisher<CharacterInformation, any Error> {
        
        return remoteDataSource.getCharacters(page: page).map { serverCharacters -> CharacterInformation in
            
            var characters: [Character] = []
            
            for serverCharacter in serverCharacters.results {
                
                let character = serverCharacter.convertToEntity()
                characters.append(character)
            }
            
            return CharacterInformation(pages: serverCharacters.info.pages,
                                        characters: characters)
        }
        .mapError({ $0 })
        .eraseToAnyPublisher()
    }
    
    func getLocation(locationId: Int) -> AnyPublisher<CharacterLocation, any Error> {
        
        return remoteDataSource.getLocation(locationId: locationId).map { serverLocation -> CharacterLocation in
            
            let location = serverLocation.convertToEntity()
            
            return location
        }
        .mapError({ $0 })
        .eraseToAnyPublisher()
    }
}
