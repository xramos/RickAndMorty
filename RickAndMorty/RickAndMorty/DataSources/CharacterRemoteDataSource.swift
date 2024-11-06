//
//  CharacterRemoteDataSource.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation
import Combine

class CharacterRemoteDataSource {
    
    static let getCharactersURL: String = "/character"
    private let baseURLString: String
    private let session: URLSession
    
    init(baseURL: String = Constants.baseURL, session: URLSession = URLSession.shared) {
        
        self.baseURLString = baseURL
        self.session = session
    }
    
    func getCharacters() -> AnyPublisher<ServerArrayResponse<ServerCharacter>, Error> {
        
        let manager = NetworkManager(baseURL: baseURLString,
                                     session: session)
        
        let urlRequest = getCharactersEndpoint()
        
        return manager.performRequest(urlRequest: urlRequest)
    }
}


extension CharacterRemoteDataSource {
    
    func getCharactersEndpoint() -> URLRequest {
        
        let endpoint = "\(baseURLString)\(CharacterRemoteDataSource.getCharactersURL)"
        
        let url = URL(string: endpoint.filter { !$0.isWhitespace })
                
        let urlRequest = URLRequest(url: url!)
                
        return urlRequest
    }
}
