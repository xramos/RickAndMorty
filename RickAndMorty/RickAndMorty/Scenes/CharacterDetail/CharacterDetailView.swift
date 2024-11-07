//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import SwiftUI
import PreviewSnapshots

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    var body: some View {
        
        VStack {
            
            content
        }
        .task {
            
            viewModel.getLocations()
        }
    }
    
    @ViewBuilder
    var content: some View {
        
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .loaded:
            loadedView
        }
    }
    
    @ViewBuilder
    var loadedView: some View {
        
        VStack {
            
            characterSection
            
            if let location = viewModel.originLocation {
                
                Spacer().frame(maxHeight: 20)
                
                locationSection(locationName: "Origin Location",
                                location: location)
            }
            
            if let location = viewModel.lastLocation {
                
                Spacer().frame(maxHeight: 20)
                
                locationSection(locationName: "Last Known Location",
                                location: location)
            }
            
            Spacer()
        }
        .padding(Constants.padding)
    }
    
    @ViewBuilder
    var characterSection: some View {
        
        VStack {
            
            NetworkImage(imageUrlString: viewModel.character.image)
            
            Text(viewModel.character.name)
                .font(.title)
                .foregroundStyle(Color.secondaryMain)
            
            Divider()
                .background(Color.accentColor)
            
            VStack(spacing: 10) {
                
                TitleValueView(title: "Status:",
                               value: viewModel.character.status.rawValue)
                
                if !viewModel.character.species.isEmpty {
                    TitleValueView(title: "Species:",
                                   value: viewModel.character.species)
                }
                
                if !viewModel.character.type.isEmpty {
                    TitleValueView(title: "Type:",
                                   value: viewModel.character.type)
                }
                
                TitleValueView(title: "Gender:",
                               value: viewModel.character.gender.rawValue)
            }
        }
        .padding(Constants.padding)
        .background(Color.primaryContainer)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
        .shadow(color: Color.neutral, radius: Constants.radius)
    }
    
    @ViewBuilder
    func locationSection(locationName: String, location: CharacterLocation) -> some View {
        
        VStack {
            
            Text(locationName)
                .font(.title3)
                .foregroundStyle(Color.secondaryMain)
            
            Divider()
                .background(Color.accentColor)
            
            VStack(spacing: 10) {
                
                if !location.name.isEmpty {
                    TitleValueView(title: "Name:", value: location.name)
                }
                
                if !location.type.isEmpty {
                    TitleValueView(title: "Type:", value: location.type)
                }
                
                if !location.dimension.isEmpty {
                    TitleValueView(title: "Dimension:", value: location.dimension)
                }
            }
        }
        .padding(Constants.padding)
        .background(Color.primaryContainer)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
        .shadow(color: Color.neutral, radius: Constants.radius)
    }
}

// MARK: - Previews

struct CharacterDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    static var snapshots: PreviewSnapshots<ColorScheme> {
        
        PreviewSnapshots(configurations: [
            .init(name: "Light", state: .light),
            .init(name: "Dark", state: .dark)
        ], configure: { state in
            
            CharacterDetailView(viewModel: CharacterDetailViewModel(character: Character(id: 1,
                                                                                         name: "Rick Sanchez",
                                                                                         status: .alive,
                                                                                         species: "Human",
                                                                                         type: "Genetic experiment",
                                                                                         gender: .male,
                                                                                         image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                                                                         originId: 1,
                                                                                         locationId: 1)))
            .preferredColorScheme(state)
        })
    }
}
