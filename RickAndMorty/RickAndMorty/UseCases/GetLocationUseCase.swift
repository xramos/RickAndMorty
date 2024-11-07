//
//  GetLocationUseCase.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation
import Combine

protocol GetLocationUseCase {
    
    func execute(locationId: Int) -> AnyPublisher<CharacterLocation, Error>
}
