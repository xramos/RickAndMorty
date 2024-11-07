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
            
            content
        }
        .task {
            
            // TODO: Get Location
        }
    }
    
    @ViewBuilder
    var content: some View {
        
        VStack {
            
            VStack {
                
                NetworkImage(imageUrlString: viewModel.character.image)
                
                Text(viewModel.character.name)
                    .font(.title)
                
                Divider()
                    .background(Color.accentColor)
                
                VStack(spacing: 10) {
                    
                    TitleValueView(title: "Status:",
                                   value: viewModel.character.status.rawValue)
                    
                    TitleValueView(title: "Species:",
                                   value: viewModel.character.species)
                    
                    TitleValueView(title: "Type:",
                                   value: viewModel.character.type)
                    
                    TitleValueView(title: "Gender:",
                                   value: viewModel.character.gender.rawValue)
                }
            }
            .padding(Constants.padding)
            .background(Color.primaryContainer)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
            .shadow(color: Color.neutral, radius: Constants.radius)
            
            Spacer()
        }
        .padding(Constants.padding)
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
                                  image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                  originId: 1,
                                  locationId: 1)
        
        ForEach(ColorScheme.allCases, id: \.self) {
            CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))
                .preferredColorScheme($0)
        }
    }
}
