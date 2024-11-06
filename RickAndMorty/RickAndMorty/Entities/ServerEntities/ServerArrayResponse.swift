//
//  ServerArrayResponse.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 6/11/24.
//

import Foundation

struct ServerArrayResponse<T: Codable>: Codable {
    
    let results: [T]
}
