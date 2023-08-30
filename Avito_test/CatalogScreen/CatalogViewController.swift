//
//  ViewController.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    let viewModel = CatalogViewModel()
    
    // MARK: - Constants and Variables:
    enum UIConstants {
        static let numberOfCells: CGFloat = 2
        static let defaultInset: CGFloat = 10
        static let cellHeight: CGFloat = 300
        static let numberOfLineInsets: CGFloat = 3
    }

    // MARK: - UI:
    private lazy var catalogCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: Resources.Identifiers.catalogCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchProducts()
        setupViews()
        setupConstraints()
    }
}

// MARK: - UICollectionViewDataSource:
extension CatalogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.catalogCell,
            for: indexPath) as? CatalogCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .gray
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidht = view.frame.width
        let cellWidht = (viewWidht - (UIConstants.defaultInset * UIConstants.numberOfLineInsets)) / UIConstants.numberOfCells
        
        return CGSize(width:cellWidht , height: UIConstants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        UIConstants.defaultInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        UIConstants.defaultInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset = UIConstants.defaultInset
        
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

// MARK: - Setup Views:
extension CatalogViewController {
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(catalogCollectionView)
    }
}

// MARK: - Setup Constraints:
extension CatalogViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            catalogCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            catalogCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            catalogCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            catalogCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
