import UIKit

final class CustomCollectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
    
    // MARK: - Constants and Variables:
    enum Section: Int, CaseIterable {
           case filters
           case list

           var columnCount: Int {
               switch self {
               case .filters:
                   return 4
               case .list:
                   return 2
               }
           }
       }
    
    // MARK: - Lifecycle:
    init() {
        super.init { (sectionIndex, layoutEnvironment) in
            let sectionKind = Section(rawValue: sectionIndex)
            let countOfColumns = sectionKind?.columnCount ?? 0
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupHeigth = countOfColumns == 2 ? UIConstants.productCellHeight : UIConstants.filterCellHeight
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(groupHeigth))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            group.interItemSpacing = .fixed(UIConstants.defaultInset)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: UIConstants.defaultInset,
                                          leading: UIConstants.defaultInset,
                                          bottom: UIConstants.defaultInset,
                                          trailing: UIConstants.defaultInset)
            section.interGroupSpacing = UIConstants.defaultInset
            
            if sectionIndex == 0 {
                section.orthogonalScrollingBehavior = .groupPaging
            }
            
            return section
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
