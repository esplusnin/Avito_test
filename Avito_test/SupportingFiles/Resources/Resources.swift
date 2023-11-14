//
//  Resources.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import UIKit

enum Resources {
    enum Identifiers {
        static let catalogCell = "CatalogCell"
        static let catalogFilterCell = "CatalogFilterCell"
    }
    
    enum Network {
        static let defaultURL = "https://www.avito.st"
        static let mainCatalogURL = "/s/interns-ios/main-page.json"
        
        static func getProductIDURL(itemID: String) -> String {
            "/s/interns-ios/details/" + itemID + ".json"
        }
    }
    
    enum Images {
        static let cancelButtonImage = UIImage(systemName: "minus.circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        static let notificationBannerImage = UIImage(systemName: "antenna.radiowaves.left.and.right.slash")
    }
}
