//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import SwiftUI

struct CharacterListView: View {
    
    @StateObject var viewModel: CharacterListViewModel = CharacterListViewModel()
    
    var body: some View {
        
        VStack {
            
            content
            
        }.task {
            
            if viewModel.characters.isEmpty {
                
                viewModel.getCharacters()
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        
        ScrollView {
            
            LazyVStack {
                
                ForEach(viewModel.characters) { character in
                    
                    NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))) {
                        
                        CharacterCellView(image: character.image,
                                          name: character.name,
                                          status: character.status.rawValue)
                    }
                    .onAppear {
                        
                        if viewModel.isLastCharacter(character: character) {
                            
                            viewModel.getNextCharacters()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Previews

struct CharacterListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) {
            CharacterListView()
                .preferredColorScheme($0)
        }
    }
}
