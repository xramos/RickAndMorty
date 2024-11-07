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
    
    func getLocation(isForced: Bool, locationId: Int) -> AnyPublisher<CharacterLocation, any Error> {
        
        if isForced {
            
            //Remove Cache
            remoteDataSource.removeGetLocationCache(locationId: locationId)
        }
        
        if remoteDataSource.isGetLocationAvailable(locationId: locationId) {
            
            if let location = localDataSource.getLocationById(id: locationId) {
                
                return Result.Publisher(location).eraseToAnyPublisher()
                
            } else {
                
                // Try Again
                return getLocation(isForced: true,
                                   locationId: locationId)
            }
        } else {
            
            return remoteDataSource.getLocation(locationId: locationId).map { serverLocation -> CharacterLocation in
                
                let location = serverLocation.convertToEntity()
                
                self.localDataSource.saveLocation(location: location)
                
                self.remoteDataSource.addGetLocationCache(locationId: locationId)
                
                return location
            }
            .mapError({ $0 })
            .eraseToAnyPublisher()
        }
    }
}
