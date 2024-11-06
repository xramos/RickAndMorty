//
//  NetworkImage.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import SwiftUI
import PreviewSnapshots

struct NetworkImage: View {
    
    let imageUrlString: String
    
    init(imageUrlString: String) {
        self.imageUrlString = imageUrlString
    }
    
    var body: some View {
        
        VStack {
            
            CachedAsyncImage(url: URL(string: imageUrlString)) { phase in
                
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.imageSize, height: Constants.imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.imageSize))
                        .shadow(color: .gray, radius: Constants.radius)
                case .failure:
                    Image("errorImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Constants.imageSize, height: Constants.imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: Constants.imageSize))
                        .shadow(color: .gray, radius: Constants.radius)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

// MARK: - Previews

struct NetworkImage_Previews: PreviewProvider {
    
    static var previews: some View {
        
        snapshots.previews.previewLayout(.sizeThatFits)
    }
    
    static var snapshots: PreviewSnapshots<String> {
        
        PreviewSnapshots(configurations: [
            .init(name: "Success", state: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            .init(name: "Failure", state: "https://rickandmortyapi.com/api/character/avatar/1")
        ], configure: { state in
            
            NetworkImage(imageUrlString: state)
        })
    }
}
