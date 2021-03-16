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
            guard error == nil else {
                print(String(describing: error!))
                completion(.failure(.error(error: error!.localizedDescription)))
                return
            }
            
            guard let httpREsponse = response as? HTTPURLResponse, httpREsponse.statusCode == 200 else {
                completion(.failure(.InvalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.InvalidData))
                return
            }
            do {
            let json = try JSONDecoder().decode(T.self, from: data)
            completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case InvalidResponse
    case InvalidData
    case error(error: String)
    case decodingError(err: String)
}
