//
//  NetworkImage.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import SwiftUI

struct NetworkImage: View {
    
    let imageUrlString: String
    var width: CGFloat? = 40
    var height: CGFloat? = 40
    
    init(imageUrlString: String, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.imageUrlString = imageUrlString
        self.width = width
        self.height = height
    }
    
    var body: some View {
        
        VStack {
            
            AsyncImage(url: URL(string: imageUrlString)) { phase in
                
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: width, maxHeight: height)
                        .clipShape(RoundedRectangle(cornerRadius: width ?? 40))
                        .shadow(color: .gray, radius: 5)
                case .failure:
                    Image("ErrorImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: width, maxHeight: height)
                        .clipShape(RoundedRectangle(cornerRadius: width ?? 40))
                        .shadow(color: .gray, radius: 5)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    NetworkImage(imageUrlString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
}
