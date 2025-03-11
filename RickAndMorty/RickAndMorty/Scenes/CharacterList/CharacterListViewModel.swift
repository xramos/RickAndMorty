//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import SwiftUI
import Combine

protocol CharacterListViewModelContract {
    var charactersPublisher: AnyPublisher<[Character], Never> { get }
    
    func getCharacters(page: Int)
    func isLastCharacter(character: Character) -> Bool
    func getNextCharacters()
}

class CharacterListViewModel {
    
    let getCharactersUseCase: GetCharactersUseCaseContract
    
    @Published public private(set) var characters: [Character] = []
    
    private var cancellable: AnyCancellable?
    
    private var currentPage = 1
    
    // Assumption: We have at least 1 page of information
    private var totalPages = 1
    
    init(getCharactersUseCase: GetCharactersUseCaseContract = GetCharactersUseCase()) {
        
        self.getCharactersUseCase = getCharactersUseCase
    }
}

extension CharacterListViewModel: CharacterListViewModelContract {
    
    var charactersPublisher: AnyPublisher<[Character], Never> {
        $characters.eraseToAnyPublisher()
    }
    
    func getCharacters(page: Int) {
        
        cancellable = getCharactersUseCase.execute(page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
                
            }, receiveValue: { (characterInformation: CharacterInformation) in
                
                self.totalPages = characterInformation.pages
                self.characters.append(contentsOf: characterInformation.characters)
            })
    }
    
    func isLastCharacter(character: Character) -> Bool {
        
        return character == characters.last
    }
    
    func getNextCharacters() {
        
        if currentPage < totalPages {
            currentPage += 1
            getCharacters(page: currentPage)
        }
    }
}
