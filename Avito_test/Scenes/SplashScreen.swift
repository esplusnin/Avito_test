//
//  LaunchScreen.swift
//  Avito_test
//
//  Created by Евгений on 31.08.2023.
//

import UIKit
import Lottie

final class SplashScreen: UIViewController {
    
    // MARK: - UI:
    private var greetingAnimation = LottieAnimationView(name: "GreetingAnimation")
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        startAnimation()
    }
    
    // MARK: - Private Methods:
    private func startAnimation() {
        greetingAnimation.play()
        switchToCatalogVC()
    }
    
    private func switchToCatalogVC() {
        let networkClient = NetworkClientService()
        let dataProvider = DataProvider(networkClient: networkClient)
        let catalogViewModel = CatalogViewModel(provider: dataProvider)
        let catalogViewController = CatalogViewController(viewModel: catalogViewModel)
        let catalogNavigationViewController = UINavigationController(rootViewController: catalogViewController)
        catalogNavigationViewController.modalPresentationStyle = .overFullScreen
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self else { return }
            self.present(catalogNavigationViewController, animated: true)
        }
    }
}

// MARK: - Setup Views:
extension SplashScreen {
    private func setupViews() {
        view.backgroundColor = .greenDay
        view.addSubview(greetingAnimation)
        greetingAnimation.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Setup Constraints:
extension SplashScreen {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            greetingAnimation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            greetingAnimation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            greetingAnimation.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            greetingAnimation.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
