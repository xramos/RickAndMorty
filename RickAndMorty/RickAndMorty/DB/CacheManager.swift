//
//  CacheManager.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 7/11/24.
//

import Foundation

class CacheManager: Caching {
    
    private let baseURL: URL
    
    init(type: CacheType) {
        
        guard let applicationSupportDirectoryURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError()
        }
        
        baseURL = applicationSupportDirectoryURL
            .appendingPathComponent("rickAndMorty")
            .appendingPathComponent(type.rawValue)
        
        try? FileManager.default.createDirectory(at: baseURL, withIntermediateDirectories: true, attributes: nil)
    }
    
    func add(key: String) {
        
        let item = baseURL.appendingPathComponent(key)
        try? FileManager.default.removeItem(at: item)
        try? FileManager.default.createDirectory(at: item, withIntermediateDirectories: true, attributes: nil)
    }
    
    func evict(key: String) {
        
        try? FileManager.default.removeItem(at: baseURL.appendingPathComponent(key))
    }
    
    func exists(key: String) -> Bool {
        
        guard let fullPath = baseURL.appendingPathComponent(key).path.removingPercentEncoding else {
            return false
        }
        
        return FileManager.default.fileExists(atPath: fullPath)
    }
    
    func expired(key: String, time: Double) -> Bool {
        
        guard let fullPath = baseURL.appendingPathComponent(key).path.removingPercentEncoding,
            let creationDate = (try? FileManager.default.attributesOfItem(atPath: fullPath)[.creationDate]) as? Date else {
                return true
        }
        
        let date = creationDate.addingTimeInterval(time * 60.0)
        
        return date < Date()
    }
    
    func removeAll() {
        
        try? FileManager.default.contentsOfDirectory(at: baseURL, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions())
            .forEach {
                try? FileManager.default.removeItem(at: $0)
                print("Cache: Remove item at \($0)")
            }
    }

    func isAvailable(key: String, cacheTime: Double, isReachable: Bool) -> Bool {
        
        var isCacheAvailable = false
        
        if exists(key: key) && !isReachable {
            
            isCacheAvailable = true
            
        } else if !expired(key: key, time: cacheTime) {
            
            isCacheAvailable = true
            
        }
        
        return isCacheAvailable
    }
}
