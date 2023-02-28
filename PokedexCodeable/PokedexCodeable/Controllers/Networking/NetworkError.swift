//
//  NetworkError.swift
//  PokedexCodeable
//
//  Created by Chase on 2/28/23.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
    
        case .invalidURL:
            return "Invalid URL. Unable to reach the server."
        case .thrownError(let error):
            return "Thrown Error: \(error.localizedDescription)"
        case .noData:
            return "There was a problem recieving the data: Server responded with no data."
        case .unableToDecode:
            return "Unrecognized data format...unable to decode data."
        }
    }
}
