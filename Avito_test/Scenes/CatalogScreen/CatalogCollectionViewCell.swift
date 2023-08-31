//
//  CatalogCollectionViewCell.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import UIKit
import Kingfisher

final class CatalogCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants and Variables:
    private var productModel: Advertisement? {
        didSet {
            guard let productModel,
                  let imageURL = URL(string: productModel.imageURL) else { return }
            let processor = RoundCornerImageProcessor(cornerRadius: 100)
            
            productImageView.kf.indicatorType = .activity
            productImageView.kf.setImage(with: imageURL, options: [.processor(processor),
                                                                   .transition(.fade(1))])
            titleLabel.text = productModel.title
            priceLabel.text = productModel.price
            geoLabel.text = productModel.location
            dateLabel.text = productModel.createdDate
        }
    }
        
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .bodyTitleFont
        label.textColor = .blackDay
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyMediumFont
        label.textColor = .blackDay
        
        return label
    }()
    
    private lazy var productImageView = UIImageView()
    private lazy var geoLabel = UILabel()
    private lazy var dateLabel = UILabel()
    
    // MARK: - Lifecycle:
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        productImageView.kf.cancelDownloadTask()
    }
    
    // MARK: - Public Methods:
    func setupProduct(model: Advertisement) {
        productModel = model
    }
}

// MARK: - Setup Views:
private extension CatalogCollectionViewCell {
    func setupViews() {
        [titleLabel, priceLabel, productImageView, geoLabel, dateLabel].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupLabels()
    }
    
    func setupLabels() {
        [geoLabel, dateLabel].forEach { label in
            label.font = .bodyMetaFont
            label.textColor = .gray
        }
    }
}

// MARK: - Setup Constraints:
extension CatalogCollectionViewCell {
    private func setupConstraints() {
        let height = bounds.width
        
        NSLayoutConstraint.activate([
            productImageView.heightAnchor.constraint(equalToConstant: height),
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            geoLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            geoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: geoLabel.bottomAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
