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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.searchTextField.text,
              !text.isEmpty else {
            currentSearchTask?.cancel()
            currentSearchTask = nil
            searchBarCancelButtonClicked(searchBar)
            return
        }
        currentSearchTask?.cancel()
        currentSearchTask = viewModel.getProductBy(
            criteria: searchText,
            onComplete: { count in
                let hasResults = count == 0
                if hasResults {
                    searchBar.resignFirstResponder()
                }
                self.applySnapshot(animatingDifferences: true, hasResults: hasResults)
            },
            onFailure: { error in })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        endEditing(searchBar)
    }
    
    private func endEditing(_ searchBar: UISearchBar) {
        viewModel.clearProductList()
        applySnapshot(animatingDifferences: true)
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
}
