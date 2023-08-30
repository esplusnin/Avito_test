//
//  DataProvider.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

final class DataProvider {
    
    private let networkClient = NetworkClientService()
    
    func fetchAdvertisement(completion: @escaping (Result<Advertisements, Error>) -> Void) {
        guard let url = createFullPathURL(path: Resources.Network.mainCatalogURL) else { return }
        
        networkClient.fetchData(url: url, model: DataResult.self) { result in
            switch result {
            case .success(let dataResult):
                completion(.success(dataResult.advertisements))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createFullPathURL(path: String) -> URL? {
        let urlString = Resources.Network.defaultURL + path
        
        return URL(string: urlString) ?? nil
    }
}
