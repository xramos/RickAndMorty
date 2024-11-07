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
    
    @Published public private(set) var characters: [Character] = []
    
    private var cancellable: AnyCancellable?
    
    private var currentPage = 1
    
    // Assumption: We have at least 1 page of information
    private var totalPages = 1
    
    // MARK: - Methods
    
    init(getCharactersUseCase: GetCharactersUseCase = GetCharactersUseCaseImplementation()) {
        
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    func getCharacters(page: Int = 1) {
        
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
