//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import SwiftUI
import Combine

class CharacterDetailViewModel: ObservableObject {
    
    let getLocationUseCase: GetLocationUseCase
    
    @Published internal var state: State = .loading
    
    @Published public private(set) var character: Character
    
    @Published public private(set) var originLocation: CharacterLocation?
    @Published public private(set) var lastLocation: CharacterLocation?
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    
    init(getLocationUseCase: GetLocationUseCase = GetLocationUseCaseImplementation(),
         character: Character) {
        
        self.getLocationUseCase = getLocationUseCase
        self.character = character
    }
    
    func getLocations() {
        
        state = .loading
        
        getLocation(locationId: character.originId) { location in
            
            if let location = location {
                
                self.originLocation = location
            }
            
            self.state = .loading
            
            self.getLocation(locationId: self.character.locationId) { location in
                
                if let location = location {
                    
                    self.lastLocation = location
                }
            }
        }
    }
    
    func getLocation(locationId: Int, completionHandler: @escaping (CharacterLocation?) -> Void) {
        
        cancellable = getLocationUseCase.execute(locationId: locationId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                self.state = .loaded
                
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

extension CharacterDetailViewModel {
    
    enum State: Equatable {
        
        case loading
        case loaded
    }
}
