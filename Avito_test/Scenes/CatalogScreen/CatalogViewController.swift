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
    
    // MARK: - UI:
    private lazy var catalogCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CustomCollectionViewCompositionalLayout())
        collectionView.register(CatalogCollectionViewFilterCell.self, forCellWithReuseIdentifier: Resources.Identifiers.catalogFilterCell)
        collectionView.register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: Resources.Identifiers.catalogCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .greenDay
        
        return collectionView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: UIConstants.buttonSide, height: UIConstants.buttonSide)
        button.setImage(Resources.Images.cancelButtonImage, for: .normal)
        
        return button
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = UIConstants.searchTextFieldCornerRadius
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: UIConstants.searchTextFieldInsideViewSide, height: textField.bounds.height))
        textField.rightView = cancelButton
        textField.leftViewMode = .always
        textField.rightViewMode = .whileEditing
        textField.backgroundColor = .lightGray
        textField.placeholder = L10n.Catalog.searching
        textField.textColor = .blackDay
        
        return textField
    }()
    
    private lazy var stumbLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Catalog.noProducts
        label.textColor = .blackDay
        
        return label
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
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
        
        viewModel?.errorStringObservable.bind { [weak self] errorString in
            guard let self else { return }
            if let errorString {
                DispatchQueue.main.async {
                    self.unblockUI()
                    self.refreshControl.endRefreshing()
                    self.showNotificationBanner(with: errorString)
                }
            }
        }
    }
    
    private func switchToProductVC(productID: String) {
        let dataProvider = viewModel?.provider
        let productViewModel = ProductViewModel(provider: dataProvider, productID: productID)
        let viewController = ProductViewController(viewModel: productViewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupStumbs() {
        view.addSubview(stumbLabel)
        
        NSLayoutConstraint.activate([
            stumbLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stumbLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - Objc Methods:
    @objc private func refreshCollection() {
        blockUI()
        viewModel?.fetchProducts()
    }
    
    @objc private func cancelSearchTextField() {
        searchTextField.text = .none
        searchTextField.endEditing(true)
        viewModel?.sortProducts(by: "")
    }
    
    @objc private func sortCollection() {
        guard let text = searchTextField.text else { return }
        viewModel?.sortProducts(by: text)
    }
}

// MARK: - UICollectionViewDataSource:
extension CatalogViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel?.productsObservable.wrappedValue.count == 0 {
            setupStumbs()
        } else {
            stumbLabel.removeFromSuperview()
        }
        
        switch section {
        case 0:
            return viewModel?.filterTypes.count ?? 0
        default:
            return viewModel?.productsObservable.wrappedValue.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Resources.Identifiers.catalogFilterCell,
                for: indexPath) as? CatalogCollectionViewFilterCell else { return UICollectionViewCell() }
            
            if let text = viewModel?.filterTypes[indexPath.row] {
                cell.setupFilterLabel(with: text)
            }
            
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Resources.Identifiers.catalogCell,
                for: indexPath) as? CatalogCollectionViewCell else { return UICollectionViewCell() }
            
            if let model = viewModel?.productsObservable.wrappedValue[indexPath.row] {
                cell.setupProduct(model: model)
            }
            
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let advertisements = viewModel?.productsObservable.wrappedValue else { return }
        let productID = advertisements[indexPath.row].id
        
        searchTextField.removeFromSuperview()
        switchToProductVC(productID: productID)
    }
}

// MARK: - Setup Views:
private extension CatalogViewController {
    func setupViews() {
        view.backgroundColor = .greenDay
        
        view.addSubview(catalogCollectionView)
        catalogCollectionView.addSubview(refreshControl)
    }
    
    func setupNavigationController() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.backgroundColor = .greenDay
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        navigationBar.addSubview(searchTextField)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: UIConstants.smallInset),
            searchTextField.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: UIConstants.defaultInset),
            searchTextField.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -UIConstants.defaultInset),
            searchTextField.heightAnchor.constraint(equalToConstant: UIConstants.searchTextFieldHeight)
        ])
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
        cancelButton.addTarget(self, action: #selector(cancelSearchTextField), for: .touchUpInside)
        searchTextField.addTarget(self, action: #selector(sortCollection), for: .allEditingEvents)
    }
}
