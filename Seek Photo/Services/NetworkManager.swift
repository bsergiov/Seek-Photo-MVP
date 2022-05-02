//
//  NetworkManager.swift
//  Seek Photo
//
//  Created by BSergio on 02.05.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    // MARK: - Generic Methodes fetch model
    func fetch<T: Codable>(dataType: T.Type, completion:  @escaping (Result<T, NetworkError>) -> Void) {
        
        let key = "qi7jMjsECyBY4ThTcsMxJHo444uhaswM7GoZZRxONxg"
        guard let url = URL(string: "https://api.unsplash.com/photos/random?page=1&client_id=\(key)&count=30") else {
            completion(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let type = try decoder.decode(T.self, from: data)
                completion(.success(type))
            } catch {
                print(error)
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    // MARK: - Fetch data to Image
    func fetchData(from urlString: String, completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}
