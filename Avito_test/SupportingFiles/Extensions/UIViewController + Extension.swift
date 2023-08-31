//
//  ViewController + Extension.swift
//  Avito_test
//
//  Created by Евгений on 31.08.2023.
//

import UIKit

extension UIViewController {
    
    // MARK: - UI:
    private var activityIndicator: UIActivityIndicatorView? {
        view.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
    }
    
    // MARK: - Public Methods:
    func blockUI() {
        setupActivityIndicator()
        view.isUserInteractionEnabled = false
    }
    
    func unblockUI() {
        view.isUserInteractionEnabled = true
        
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
    
    // MARK: - Private Methods:
    private func setupActivityIndicator() {
        if activityIndicator == nil {
            let indicator = UIActivityIndicatorView(style: .large)
            
            view.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            indicator.startAnimating()
        } else {
            activityIndicator?.startAnimating()
        }
    }
}
