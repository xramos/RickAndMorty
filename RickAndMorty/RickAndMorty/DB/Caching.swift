//
//  Caching.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation

protocol Caching {
    
    /**
     Add key to cache
     */
    func add(key: String)
    
    /**
     Remove key from cache
     */
    func evict(key: String)
    
    /**
     Check if key extists in cache. true if exists, false otherwise
     */
    func exists(key: String) -> Bool
    
    /**
     Check if key with selected time is expired. true if  expired, false otherwise
     */
    func expired(key: String, time: Double) -> Bool
    
    /**
     Remove all keys from cache
     */
    func removeAll()
    
    /**
        Checks if cache for the specified key, cacheTime and reachability is available
     */
    func isAvailable(key: String, cacheTime: Double, isReachable: Bool) -> Bool
}
