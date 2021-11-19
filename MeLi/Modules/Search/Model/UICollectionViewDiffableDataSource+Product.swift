//
//  UICollectionViewDiffableDataSource+Product.swift
//  MeLi
//
//  Created by Eduardo Andrade on 18/11/21.
//

import UIKit

// MARK: - UICollectionViewDiffableDataSource where (ItemIdentifier = Product)
extension UICollectionViewDiffableDataSource where ItemIdentifierType == Product {
    
    // MARK: - Custom Functions
    static func make(with reuseIdentifier: Constants.ReuseIdentifier = .product,
                     to collectionView: UICollectionView) -> UICollectionViewDiffableDataSource {
        
        UICollectionViewDiffableDataSource(collectionView: collectionView) {
            collectionView, indexPath, product in
            let productCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: reuseIdentifier.rawValue,
                for: indexPath) as? ProductCollectionViewCell
            productCell?.setup(data: product)
            return productCell
        }
    }
    
}
