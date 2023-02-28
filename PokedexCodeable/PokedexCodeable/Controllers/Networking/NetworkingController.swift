//
//  NetworkingController.swift
//  PokedexCodeable
//
//  Created by Chase on 2/28/23.
//

import Foundation

class NetworkingController {
    
    static func fetchPokedex(with url: String, completion: @escaping (Result<TopLevel, NetworkError>) -> Void) {
        
        guard let finalURL = URL(string: url) else { completion(.failure(.invalidURL)) ; return }
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error))) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                
                let topLevel = try JSONDecoder().decode(TopLevel.self, from: data)
                completion(.success(topLevel))
            } catch {
                
                completion(.failure(.unableToDecode))
            }
        } .resume()
    }
}
