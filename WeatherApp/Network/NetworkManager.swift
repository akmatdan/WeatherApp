//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Daniil Akmatov on 13/3/21.
//

import Foundation

final class NetworkManager<T: Codable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil
            else {
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            
            guard let httpREsponse = response as? HTTPURLResponse, httpREsponse.statusCode == 200 else {
                completion(.failure(.InvalidResponse))
                return
            }
        }
        .resume()
    }
}

enum NetworkError: Error {
    case InvalidResponse
    case InvalidData
    case error(error: String)
}
