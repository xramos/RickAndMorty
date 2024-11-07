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
            
            viewModel.getCharacters()
        }
    }
    
    @ViewBuilder
    var content: some View {
        
        switch viewModel.state {
        case .loading:
            loadingView
        case .failed:
            failedView
        case .loaded:
            loadedView
        }
    }
    
    @ViewBuilder
    var loadingView: some View {
        
        ProgressView()
        
        Text("Loading Characters")
            .font(.caption)
    }
    
    @ViewBuilder
    var failedView: some View {
        
        Text("Ops, there has been some error")
                
        Button(action: { viewModel.getCharacters() },
               label: { Text("Try again")})
    }
    
    @ViewBuilder
    var loadedView: some View {
        
        List {
            
            ForEach(viewModel.characters) { character in
                
                NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))) {
                    
                    CharacterCellView(image: character.image,
                                      name: character.name,
                                      status: character.status.rawValue)
                }
                .padding([.leading, .trailing], Constants.padding)
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - Previews

struct CharacterListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CharacterListView()
    }
}
