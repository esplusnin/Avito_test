//
//  ViewController + Extension.swift
//  Avito_test
//
//  Created by Евгений on 31.08.2023.
//

import UIKit
import NotificationBannerSwift

extension UIViewController {
    
    // MARK: - Blocking UI:
    private var activityIndicator: UIActivityIndicatorView? {
        view.subviews.first { $0 is UIActivityIndicatorView } as? UIActivityIndicatorView
    }
    
    // Public Methods:
    func blockUI() {
        setupActivityIndicator()
        view.isUserInteractionEnabled = false
    }
    
    func unblockUI() {
        view.isUserInteractionEnabled = true
        
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
    
    // Private Methods:
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
    
    // MARK: - Notification Banner:
    private static var lastBannerShowTime: Date?
    
    func showNotificationBanner(with text: String) {
        let currentTime = Date()
        if let lastShowTime = UIViewController.lastBannerShowTime,
           currentTime.timeIntervalSince(lastShowTime) < 2 { return }
        
        let image = Resources.Images.notificationBannerImage
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = image
        imageView.tintColor = .white
        
        let banner = NotificationBanner(title: text,
                                        subtitle: L10n.NetworkError.tryLater,
                                        leftView: imageView, style: .info)
        banner.autoDismiss = false
        banner.dismissOnTap = true
        banner.dismissOnSwipeUp = true
        banner.show()
        
        UIViewController.lastBannerShowTime = currentTime
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            banner.dismiss()
        }
    }
}
