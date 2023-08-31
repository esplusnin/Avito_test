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
    
    private var unsortedProducts: Advertisements = []
    
    // MARK: - Observable Values:
    var productsObservable: Observable<Advertisements> {
        $products
    }
    
    var errorStringObservable: Observable<String?> {
        $errorString
    }
    
    @Observable
    private(set) var products: Advertisements = []
    
    @Observable
    private(set) var errorString: String?
    
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
                self.unsortedProducts = products
            case .failure(let error):
                let errorString = HandlingErrorService().handlingHTTPStatusCodeError(error: error)
                self.errorString = errorString
            }
        }
    }
    
    func sortProducts(by name: String) {
        if name == "" {
            products = unsortedProducts
        } else {
            var newProducts: Advertisements = []
            
            for product in unsortedProducts {
                if product.title.contains(name) {
                    newProducts.append(product)
                }
            }
            
            products = newProducts
        }
    }
}
