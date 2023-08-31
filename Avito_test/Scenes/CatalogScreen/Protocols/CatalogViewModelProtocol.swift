//
//  CatalogViewModelProtocol.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

protocol CatalogViewModelProtocol: AnyObject {
    var provider: DataProviderProtocol { get }
    var productsObservable: Observable<Advertisements> { get }
    var errorStringObservable: Observable<String?> { get }
    func fetchProducts()
    func sortProducts(by name: String)
}
