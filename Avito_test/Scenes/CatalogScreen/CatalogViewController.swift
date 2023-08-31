//
//  ViewController.swift
//  Avito_test
//
//  Created by Евгений on 30.08.2023.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    // MARK: - Dependencies:
    private let viewModel: CatalogViewModelProtocol?
    
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
        collectionView.backgroundColor = .greenDay
        
        return collectionView
    }()
    
    private lazy var refreshControl = UIRefreshControl()

    // MARK: - Lifecycle:
    init(viewModel: CatalogViewModelProtocol) {
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
        setupTargets()
        
        bind()
        viewModel?.fetchProducts()
        blockUI()
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel?.productsObservable.bind { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.catalogCollectionView.reloadData()
                self.unblockUI()
            }
        }
    }
    
    private func switchToProductVC(productID: String) {
        let dataProvider = viewModel?.provider
        let productViewModel = ProductViewModel(provider: dataProvider, productID: productID)
        let viewController = ProductViewController(viewModel: productViewModel)
        
        viewController.modalPresentationStyle = .overFullScreen
        
        present(viewController, animated: true)
    }
    
    // MARK: - Objc Methods:
    @objc private func refreshCollection() {
        blockUI()
        viewModel?.fetchProducts()
    }
}

// MARK: - UICollectionViewDataSource:
extension CatalogViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.productsObservable.wrappedValue.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.catalogCell,
            for: indexPath) as? CatalogCollectionViewCell else { return UICollectionViewCell() }
        
        if let model = viewModel?.productsObservable.wrappedValue[indexPath.row] {
            cell.setupProduct(model: model)
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let advertisements = viewModel?.productsObservable.wrappedValue else { return }
        let productID = advertisements[indexPath.row].id
        
        switchToProductVC(productID: productID)
    }
}

// MARK: - Setup Views:
extension CatalogViewController {
    private func setupViews() {
        view.backgroundColor = .greenDay
        
        view.addSubview(catalogCollectionView)
        catalogCollectionView.addSubview(refreshControl)
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

// MARK: - Setup Targets:
extension CatalogViewController {
    private func setupTargets() {
        refreshControl.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
    }
}
