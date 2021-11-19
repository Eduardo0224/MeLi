//
//  ProductsList+UISearchBarDelegate.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import UIKit

extension ProductsListViewController: UISearchBarDelegate {
    
    // MARK: - Functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text,
              !text.isEmpty
        else { return }
        currentSearchTask?.cancel()
        currentSearchTask = viewModel.getProductBy(
            criteria: searchBar.searchTextField.text ?? "",
            onComplete: {
                self.applySnapshot(animatingDifferences: true)
            },
            onFailure: { error in })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text, !text.isEmpty else {
            endEditing(searchBar)
            return
        }
        endEditing(searchBar)
    }
    
    private func endEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
}
