//
//  ProductViewModel.swift
//  Avito_test
//
//  Created by Евгений on 31.08.2023.
//

import Foundation

final class ProductViewModel: ProductViewModelProtocol {
    
    // MARK: - Dependencies:
    private let dataProvider: DataProviderProtocol?
    
    // MARK: - Constants and Variables:
    private var productID: String
    
    // MARK: - Observable Values:
    var productObservable: Observable<Product?> {
        $product
    }
    
    var errorStringObservable: Observable<String?> {
        $errorString
    }

    @Observable
    private(set) var product: Product?
    
    @Observable
    private(set) var errorString: String?
    
    // MARK: - Lifecycle:
    init(provider: DataProviderProtocol?, productID: String) {
        self.dataProvider = provider
        self.productID = productID
    }
    
    // MARK: - Public Methods:
    func fetchProduct() {
        dataProvider?.fetchProduct(itemID: productID) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let product):
                self.product = product
            case .failure(let error):
                print("FAILURE")
                let errorString = HandlingErrorService().handlingHTTPStatusCodeError(error: error)
                self.errorString = errorString
            }
        }
    }
}
