//
//  NetworkClient.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

enum NetworkError: Error {
    case parsingError
    case httpStatusCode(Int)
    case urlSessionError
    case requestError(Error)
}

final class NetworkClientService: NetworkClientServiceProtocol {
    
    // MARK: - Constants and Variables:
    let session = URLSession.shared
    
    // MARK: - Public Methods:
    func fetchData<T: Decodable>(url: URL, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.urlSessionError))
                return
            }
            
            guard 200...300 ~= response.statusCode else {
                completion(.failure(NetworkError.httpStatusCode(response.statusCode)))
                return
            }
            
            if let data {
                self.pars(model: model, data: data, completion: completion)
            }
            
            if let error {
                completion(.failure(NetworkError.requestError(error)))
            }
        }
        .resume()
    }
    
    // MARK: - Supporting Methods:
    private func pars<T: Decodable>(model: T.Type, data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        let decoder = JSONDecoder()
        
        do {
            let model = try decoder.decode(T.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(NetworkError.parsingError))
        }
    }
}
