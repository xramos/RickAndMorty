//
//  GetLocationUseCaseImplementation.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation
import Combine

class GetLocationUseCaseImplementation {
    
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository = CharacterRepositoryImplementation()) {
        
        self.repository = repository
    }
}

extension GetLocationUseCaseImplementation: GetLocationUseCase {
    
    func execute(locationId: Int) -> AnyPublisher<CharacterLocation, any Error> {
        
        return repository.getLocation(locationId: locationId)
    }
}
