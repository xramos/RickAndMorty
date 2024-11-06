//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import Combine

protocol CharacterRepository {
    
    func getCharacters() -> AnyPublisher<[Character], Error>
}
