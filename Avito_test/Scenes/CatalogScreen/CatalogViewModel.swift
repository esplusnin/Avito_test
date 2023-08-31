//
//  CatalogViewModel.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

final class CatalogViewModel: CatalogViewModelProtocol {
    
    // MARK: - Dependencies:
    private let dataProvider: DataProviderProtocol
    
    // MARK: - Constants and Variables:
    var provider: DataProviderProtocol {
        dataProvider
    }
    
    // MARK: - Observable Values:
    var productsObservable: Observable<Advertisements> {
        $products
    }
    
    @Observable
    private(set) var products: Advertisements = []
    
    // MARK: - Lifecycle:
    init(provider: DataProviderProtocol) {
        self.dataProvider = provider
    }
    
    // MARK: - Public Methods:
    func fetchProducts() {
        dataProvider.fetchAdvertisement { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                print(error)
            }
        }
    }
}
