//
//  ProductViewModelProtocol.swift
//  Avito_test
//
//  Created by Евгений on 31.08.2023.
//

import Foundation

protocol ProductViewModelProtocol: AnyObject {
    var productObservable: Observable<Product?> { get }
    var errorStringObservable: Observable<String?> { get }
    func fetchProduct()
}
