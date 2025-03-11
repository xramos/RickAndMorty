//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import SwiftUI
import Combine

protocol CharacterDetailViewModelContract {
    var isLoadingPublisher: AnyPublisher<Bool, Never> { get }
    var characterPublisher: AnyPublisher<Character, Never> { get }
    var originLocationPublisher: AnyPublisher<CharacterLocation?, Never> { get }
    var lastLocationPublisher: AnyPublisher<CharacterLocation?, Never> { get }
    
    func getLocations()
}

class CharacterDetailViewModel {
    
    let getLocationUseCase: GetLocationUseCaseContract
    
    @Published public private(set) var isLoading: Bool = false
    
    @Published public private(set) var character: Character
    @Published public private(set) var originLocation: CharacterLocation?
    @Published public private(set) var lastLocation: CharacterLocation?
    
    private var cancellable: AnyCancellable?
    
    init(getLocationUseCase: GetLocationUseCaseContract = GetLocationUseCase(),
         character: Character) {
        
        self.getLocationUseCase = getLocationUseCase
        self.character = character
    }
}

extension CharacterDetailViewModel: CharacterDetailViewModelContract {
    
    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        $isLoading.eraseToAnyPublisher()
    }
    
    var characterPublisher: AnyPublisher<Character, Never> {
        $character.eraseToAnyPublisher()
    }
    
    var originLocationPublisher: AnyPublisher<CharacterLocation?, Never> {
        $originLocation.eraseToAnyPublisher()
    }
    
    var lastLocationPublisher: AnyPublisher<CharacterLocation?, Never> {
        $lastLocation.eraseToAnyPublisher()
    }
    
    func getLocations() {
        
        isLoading = true
        
        getLocation(locationId: character.originId) { location in
            
            if let location = location {
                
                self.originLocation = location
            }
            
            self.getLocation(locationId: self.character.locationId) { location in
                
                if let location = location {
                    
                    self.lastLocation = location
                }
            }
        }
    }
}

private extension CharacterDetailViewModel {
    
    func getLocation(locationId: Int, completionHandler: @escaping (CharacterLocation?) -> Void) {
        
        cancellable = getLocationUseCase.execute(isForced: false, locationId: locationId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                self.isLoading = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
                
            }, receiveValue: { location in
            
                completionHandler(location)
            })
    }
}
