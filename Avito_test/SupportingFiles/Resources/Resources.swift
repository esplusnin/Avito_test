//
//  Resources.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import Foundation

enum Resources {
    enum Identifiers {
        static let catalogCell = "CatalogCell"
    }
    
    enum Network {
        static let defaultURL = "https://www.avito.st"
        static let mainCatalogURL = "/s/interns-ios/main-page.json"
        
        static func getProductIDURL(itemID: String) -> String {
            "/s/interns-ios/details/" + itemID + ".json"
        }
    }
}
