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
    
    // MARK: - Classes:
    private var dateFormatterService: DateFormatService?
    private var currencyFormatterService: CurrencyFormatterService?
    
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
                let newProduct = updateProductsInfo(with: product)
                self.product = newProduct
            case .failure(let error):
                let errorString = HandlingErrorService().handlingHTTPStatusCodeError(error: error)
                self.errorString = errorString
            }
        }
    }
    
    // MARK: - Private Methods:
    private func updateProductsInfo(with product: Product) -> Product {
        dateFormatterService = DateFormatService()
        currencyFormatterService = CurrencyFormatterService()
        
        let oldDate = product.createdDate
        let newDate = dateFormatterService?.getAdaptedDateString(from: oldDate) ?? ""
        let newPrice = currencyFormatterService?.getAdaptedCurrencyString(from: product.price) ?? ""
        
        dateFormatterService = nil
        currencyFormatterService = nil
        
        return Product(id: product.id,
                       title: product.title,
                       price: newPrice,
                       location: product.location,
                       imageURL: product.imageURL,
                       createdDate: newDate,
                       description: product.description,
                       email: product.email,
                       phoneNumber: product.phoneNumber,
                       address: product.address)
    }
}
