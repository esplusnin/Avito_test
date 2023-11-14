//
//  ProductViewController.swift
//  Avito_test
//
//  Created by Евгений on 31.08.2023.
//

import UIKit
import Kingfisher

final class ProductViewController: UIViewController {
    
    // MARK: - Dependencies:
    private let viewModel: ProductViewModelProtocol?
    
    // MARK: - Constants and Variables:
    private var productModel: Product? {
        didSet {
            guard let productModel,
                  let imageURL = URL(string: productModel.imageURL) else { return }
            
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(with: imageURL, options: [.transition(.fade(1)),
                                                                   .cacheOriginalImage])
            titleLabel.text = productModel.title
            priceLabel.text = productModel.price
            geoLabel.text = productModel.location
            locationLabel.text = productModel.address
            descriptionLabel.text = productModel.description
            advertiseDate.text =  L10n.Product.advertisementFrom + " \(productModel.createdDate)"
            
            clearViewsBackground()
        }
    }
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .titleFont
        label.textColor = .blackDay
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumFont
        label.textColor = .blackDay
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .metaFont
        
        
        return label
    }()
        
    private lazy var productImageView = UIImageView()
    private lazy var geoLabel = UILabel()
    private lazy var locationLabel = UILabel()
    private lazy var separator = UIView()
    private lazy var advertiseDate = UILabel()
    private lazy var callButton = BaseCustomButton(state: .call)
    private lazy var messageButton = BaseCustomButton(state: .write)
    
    // MARK: - Lifecycle:
    init(viewModel: ProductViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTarget()
        
        bind()
        viewModel?.fetchProduct()
        blockUI()
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel?.productObservable.bind { [weak self] productModel in
            guard let self,
                  let productModel else { return }
            DispatchQueue.main.async {
                self.productModel = productModel
                self.unblockUI()
            }
        }
        
        viewModel?.errorStringObservable.bind { [weak self] errorString in
            guard let self else { return }
            if let errorString {
                DispatchQueue.main.async {
                    self.unblockUI()
                    self.showNotificationBanner(with: errorString)
                }
            }
        }
    }
    
    private func clearViewsBackground() {
        [titleLabel, priceLabel, productImageView, geoLabel, locationLabel,
         descriptionLabel, advertiseDate].forEach { view in
            view.backgroundColor = .clear
        }
    }
    
    @objc private func showCallAlert() {
        AlertService().showAlert(viewController: self, state: .call, productText: productModel?.phoneNumber ?? "")
    }
    
    @objc private func showMessageAlert() {
        AlertService().showAlert(viewController: self, state: .write, productText: productModel?.email ?? "")
    }
}

// MARK: - Setup Views:
private extension ProductViewController {
    func setupViews() {
        view.backgroundColor = .greenDay
        
        [titleLabel, priceLabel, productImageView, geoLabel, locationLabel,
         descriptionLabel, separator, advertiseDate].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.masksToBounds = true
            view.backgroundColor = .lightGray
        }
        
        [callButton, messageButton].forEach { button in
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupLabels()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .blackDay
    }
    
    func setupLabels() {
        [geoLabel, locationLabel, advertiseDate].forEach { label in
            label.font = .bodyMediumFont
            label.textColor = .gray
        }
    }
}

// MARK: - Setup Constraints:
extension ProductViewController {
    private func setupConstraints() {
        
        enum UIConstants {
            static let sideInset: CGFloat = 15
            static let topInset: CGFloat = 10
            static let smallTopInset: CGFloat = 5
            static let numberOfSideInsets: CGFloat = 3
            static let numberOfButtons: CGFloat = 2
        }
        
        let widht = view.frame.width
        let buttonWidht = (widht - (UIConstants.sideInset * UIConstants.numberOfSideInsets)) / UIConstants.numberOfButtons
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: widht),
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: UIConstants.topInset),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.topInset),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            
            geoLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: UIConstants.topInset),
            geoLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            geoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            
            locationLabel.topAnchor.constraint(equalTo: geoLabel.bottomAnchor, constant: UIConstants.smallTopInset),
            locationLabel.leadingAnchor.constraint(equalTo: geoLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            
            separator.heightAnchor.constraint(equalToConstant: 1),
            separator.widthAnchor.constraint(equalToConstant: view.frame.width - 10),
            separator.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: UIConstants.smallTopInset),
            separator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            
            advertiseDate.bottomAnchor.constraint(equalTo: callButton.topAnchor, constant: -UIConstants.sideInset),
            advertiseDate.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            advertiseDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            
            callButton.widthAnchor.constraint(equalToConstant: buttonWidht),
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UIConstants.sideInset),
            
            messageButton.widthAnchor.constraint(equalToConstant: buttonWidht),
            messageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            messageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UIConstants.sideInset),
        ])
    }
}

// MARK: - Setup Targets:
extension ProductViewController {
    private func setupTarget() {
        callButton.addTarget(self, action: #selector(showCallAlert), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(showMessageAlert), for: .touchUpInside)
    }
}
