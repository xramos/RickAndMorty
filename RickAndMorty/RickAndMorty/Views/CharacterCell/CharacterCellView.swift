//
//  CharacterCellView.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import SwiftUI

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
            
            HStack(spacing: 12) {
                
                NetworkImage(imageUrlString: image)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(name)
                        .font(.headline)
                    
                    Text(status)
                        .font(.caption)
                }
            }
            
        }.padding(.bottom, 8)
    }
}

#Preview {
    CharacterCellView(image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                      name: "Rick Sanchez",
                      status: "Alive")
}
