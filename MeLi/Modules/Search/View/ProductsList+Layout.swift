//
//  ProductsList+Layout.swift
//  MeLi
//
//  Created by Eduardo Andrade on 18/11/21.
//

import UIKit

extension ProductsListViewController {
    
    // MARK: - Properties
    var customLayout: UICollectionViewLayout {
        createLayout()
    }
    
    // MARK: - Custom Functions
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout {  _, _ in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                       heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 5)
            
            let trailingItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5),
                                                                        heightDimension: .fractionalHeight(1.0)))
            trailingItem.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 10)
            
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                                                                   heightDimension: .fractionalHeight(0.4)),
                                                                 subitems: [leadingItem, trailingItem])
            let section = NSCollectionLayoutSection(group: nestedGroup)
            return section
        }
        return layout
    }
}
