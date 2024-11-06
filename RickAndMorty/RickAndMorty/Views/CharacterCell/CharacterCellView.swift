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
        
        VStack(alignment: .leading) {
            
            HStack(spacing: Constants.spacing) {
                
                NetworkImage(imageUrlString: image)
                
                VStack(alignment: .leading) {
                    
                    Text(name)
                        .font(.headline)
                    
                    Text(status)
                        .font(.caption)
                }
            }
            
            Divider()
        }
    }
}

// MARK: - Previews

struct CharacterCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    static var snapshots: PreviewSnapshots<String> {
        
        PreviewSnapshots(configurations: [
            .init(name: "Default", state: "")
        ], configure: { state in
            
            CharacterCellView(image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                              name: "Rick Sanchez",
                              status: "Alive")
        })
    }
}
