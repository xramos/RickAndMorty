//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Xavier Ramos Sole on 5/11/24.
//

import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidResponse
    case invalidStatusCode
}
