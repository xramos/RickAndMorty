//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import SwiftUI
import PreviewSnapshots

struct CharacterListView: View {
    
    var viewModel: CharacterListViewModelContract
    
    @State var characters: [Character] = []
    
    var body: some View {
        
        VStack {
            
            content
            
        }.task {
            
            if characters.isEmpty {
                
                viewModel.getCharacters(page: 1)
            }
        }.onReceive(viewModel.charactersPublisher) {
            characters = $0
        }
    }
    
    @ViewBuilder
    var content: some View {
        
        ScrollView {
            
            LazyVStack {
                
                ForEach(characters) { character in
                    
                    NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))) {
                        
                        CharacterCellView(image: character.image,
                                          name: character.name,
                                          status: character.status.rawValue)
                    }
                    .accessibilityIdentifier("CharacterCell_\(character.id)")
                    .onAppear {
                        
                        if viewModel.isLastCharacter(character: character) {
                            
                            viewModel.getNextCharacters()
                        }
                    }
                }
            }
            .padding()
        }
        .accessibilityIdentifier("CharacterScrollView")
    }
}

// MARK: - Previews

struct CharacterListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    static var snapshots: PreviewSnapshots<ColorScheme> {
        
        PreviewSnapshots(configurations: [
            .init(name: "Light", state: .light),
            .init(name: "Dark", state: .dark)
        ], configure: { state in
            CharacterListView(viewModel: CharacterListViewModel())
                .preferredColorScheme(state)
        })
    }
}
