import UIKit

final class CatalogCollectionViewFilterCell: UICollectionViewCell {
    
    // MARK: - UI:
    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .bodyTitleFont
        
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupFilterLabel(with text: String) {
        filterLabel.text = text
    }
}

// MARK: - Set Views:
extension CatalogCollectionViewFilterCell {
    private func setViews() {
        contentView.addSubview(filterLabel)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Set Constraints:
extension CatalogCollectionViewFilterCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: topAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            filterLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            filterLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
