//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        
        VStack {
            
            NetworkImage(imageUrlString: viewModel.character.image)
            
            Text(viewModel.character.name)
                .font(.title)
            
            Divider()
            
            Spacer().frame(height: 20)
            
            VStack(spacing: 10) {
                
                TitleValueView(title: "Status:",
                               value: viewModel.character.status.rawValue)
                
                TitleValueView(title: "Species:",
                               value: viewModel.character.species)
                
                TitleValueView(title: "Type:",
                               value: viewModel.character.type)
                
                TitleValueView(title: "Gender:",
                               value: viewModel.character.gender.rawValue)
                
                Spacer()
            }
        }
        .padding()
    }
}

// MARK: - Previews

struct CharacterDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let character = Character(id: 1,
                                  name: "Rick Sanchez",
                                  status: .alive,
                                  species: "Human",
                                  type: "",
                                  gender: .male,
                                  image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        
        CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
    }
}
