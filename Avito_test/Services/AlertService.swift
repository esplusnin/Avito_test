//
//  AlertService.swift
//  Avito_test
//
//  Created by Евгений on 31.08.2023.
//

import UIKit

final class AlertService {
    
    func showAlert(viewController: UIViewController, state: StateButton, productText: String) {
        var buttonText: String
        
        switch state {
        case .call:
            buttonText = L10n.AlertService.callTitle
        case .write:
            buttonText = L10n.AlertService.messageTitle
        }
        
        let alertController = UIAlertController(title: L10n.AlertService.title,
                                                message: L10n.AlertService.message,
                                                preferredStyle: .actionSheet)
        let action = UIAlertAction(title: buttonText + " \(productText)", style: .default)
        
        alertController.addAction(action)
        viewController.present(alertController, animated: true)
    }
}
