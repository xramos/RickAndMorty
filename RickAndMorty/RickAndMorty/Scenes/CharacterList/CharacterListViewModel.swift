//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import SwiftUI
import Combine

class CharacterListViewModel: ObservableObject {
    
    let getCharactersUseCase: GetCharactersUseCase
    
    @Published internal var state: State = .loading
    @Published public private(set) var characters: [Character] = []
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Methods
    
    init(getCharactersUseCase: GetCharactersUseCase = GetCharactersUseCaseImplementation()) {
        
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    func getCharacters() {
        
        state = .loading
        
        cancellable = getCharactersUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    self.state = .loaded
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    self.state = .failed
                }
                
            }, receiveValue: { (characters: [Character]) in
                
                self.characters = characters
            })
    }
}

extension CharacterListViewModel {
    
    enum State: Equatable {
        
        case loading
        case failed
        case loaded
    }
}
