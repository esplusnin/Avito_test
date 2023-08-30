//
//  Advertisement.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

struct Advertisement: Codable {
    let id, title, price, location: String
    let imageURL: String
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}

typealias Advertisements = [Advertisement]
