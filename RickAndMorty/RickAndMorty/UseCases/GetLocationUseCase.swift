//
//  GetLocationUseCase.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation
import Combine

protocol GetLocationUseCaseContract {
    func execute(isForced: Bool, locationId: Int) -> AnyPublisher<CharacterLocation, Error>
}

final class GetLocationUseCase {
    
    private let repository: CharacterRepositoryContract
    
    init(repository: CharacterRepositoryContract = CharacterRepository()) {
        
        self.repository = repository
    }
}

extension GetLocationUseCase: GetLocationUseCaseContract {
    
    func execute(isForced: Bool, locationId: Int) -> AnyPublisher<CharacterLocation, any Error> {
        
        return repository.getLocation(isForced: isForced,
                                      locationId: locationId)
    }
}
