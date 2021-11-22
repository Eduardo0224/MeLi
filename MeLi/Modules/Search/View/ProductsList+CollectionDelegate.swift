//
//  ProductsList+CollectionDelegate.swift
//  MeLi
//
//  Created by Eduardo Andrade on 20/11/21.
//

import UIKit
import SwiftUI

extension ProductsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let product = viewModel.products[indexPath.item]        
        let detailProduct = UIHostingController(rootView: DetailProductView(with: product.id))
        navigationController?.pushViewController(detailProduct, animated: true)
    }
}
