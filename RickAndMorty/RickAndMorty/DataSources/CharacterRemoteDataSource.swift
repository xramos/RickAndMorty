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
    static let getPage: String = "?page="
    
    static let getLocationURL: String = "/location"
    
    static let getLocationCachePath: String = "location/@i"
    static let getLocationCacheTime: Double = CacheTime.short.rawValue
    
    private let baseURLString: String
    private let session: URLSession
    private let cache: Caching
    
    init(baseURL: String = Constants.baseURL,
         session: URLSession = URLSession.shared,
         cache: Caching = CacheManager(type: CacheType.remote)) {
        
        self.baseURLString = baseURL
        self.session = session
        self.cache = cache
    }
    
    func getCharacters(page: Int) -> AnyPublisher<ServerArrayResponse<ServerCharacter>, Error> {
        
        let manager = NetworkManager(baseURL: baseURLString,
                                     session: session)
        
        let urlRequest = getCharactersEndpoint(page: page)
        
        return manager.performRequest(urlRequest: urlRequest)
    }
    
    func getLocation(locationId: Int) -> AnyPublisher<ServerCharacterLocation, Error> {
        
        let manager = NetworkManager(baseURL: baseURLString,
                                     session: session)
        
        let urlRequest = getLocationEndpoint(locationId: locationId)
        
        return manager.performRequest(urlRequest: urlRequest)
    }
}

// MARK: - Endpoints

extension CharacterRemoteDataSource {
    
    func getCharactersEndpoint(page: Int) -> URLRequest {
        
        let endpoint = "\(baseURLString)\(CharacterRemoteDataSource.getCharactersURL)\(CharacterRemoteDataSource.getPage)\(page)"
        
        let url = URL(string: endpoint.filter { !$0.isWhitespace })
                
        let urlRequest = URLRequest(url: url!)
                
        return urlRequest
    }
    
    func getLocationEndpoint(locationId: Int) -> URLRequest {

        let endpoint = "\(baseURLString)\(CharacterRemoteDataSource.getLocationURL)/\(locationId)"
        
        let url = URL(string: endpoint.filter { !$0.isWhitespace })
                
        let urlRequest = URLRequest(url: url!)
                
        return urlRequest
    }
}

// MARK: - Cache

extension CharacterRemoteDataSource {
    
    func isGetLocationAvailable(locationId: Int) -> Bool {
        
        return cache.isAvailable(key: String(format: "\(CharacterRemoteDataSource.getLocationCachePath)", locationId),
                                 cacheTime: CharacterRemoteDataSource.getLocationCacheTime,
                                 isReachable: true)
    }
    
    func addGetLocationCache(locationId: Int) {
        
        cache.add(key: String(format: "\(CharacterRemoteDataSource.getLocationCachePath)", locationId))
    }
    
    func removeGetLocationCache(locationId: Int) {
        
        cache.evict(key: String(format: "\(CharacterRemoteDataSource.getLocationCachePath)", locationId))
    }
}
