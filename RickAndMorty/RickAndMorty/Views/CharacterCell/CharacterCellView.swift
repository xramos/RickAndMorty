//
//  CharacterCellView.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import SwiftUI
import PreviewSnapshots

struct CharacterCellView: View {
    
    var image: String
    var name: String
    var status: String
    
    init(image: String, name: String, status: String) {
        self.image = image
        self.name = name
        self.status = status
    }
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: Constants.spacing) {
                
                NetworkImage(imageUrlString: image)
                
                VStack(alignment: .leading) {
                    
                    Text(name)
                        .font(.callout)
                        .foregroundStyle(Color.primaryMain)
                    
                    Text(status)
                        .font(.caption)
                        .foregroundStyle(Color.secondaryMain)
                }
                
                Spacer()
            }
            .padding(Constants.padding)
            .background(Color.primaryContainer)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous))
            .shadow(color: Color.neutral, radius: Constants.radius)
        }
    }
}

// MARK: - Previews

struct CharacterCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    static var snapshots: PreviewSnapshots<ColorScheme> {
        
        PreviewSnapshots(configurations: [
            .init(name: "Light", state: .light),
            .init(name: "Dark", state: .dark)
        ], configure: { state in
            
            CharacterCellView(image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                              name: "Rick Sanchez",
                              status: "Alive")
            .preferredColorScheme(state)
        })
    }
}
