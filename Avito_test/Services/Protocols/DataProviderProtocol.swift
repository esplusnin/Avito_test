//
//  DataProviderProtocol.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

protocol DataProviderProtocol: AnyObject {
    func fetchAdvertisement(completion: @escaping (Result<Advertisements, Error>) -> Void)
}
