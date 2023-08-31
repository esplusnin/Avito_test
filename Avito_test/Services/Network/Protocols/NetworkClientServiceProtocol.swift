//
//  NetworkClientServiceProtocol.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

protocol NetworkClientServiceProtocol: AnyObject {
    func fetchData<T: Decodable>(url: URL, model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
