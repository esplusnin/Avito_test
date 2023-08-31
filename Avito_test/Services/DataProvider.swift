//
//  DataProvider.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

final class DataProvider: DataProviderProtocol {
    
    // MARK: - Dependencies:
    private let networkClient = NetworkClientService()
    
    // MARK: - Public Methods:
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
    
    // MARK: - Supporting Methods:
    private func createFullPathURL(path: String) -> URL? {
        let urlString = Resources.Network.defaultURL + path
        
        return URL(string: urlString) ?? nil
    }
}
