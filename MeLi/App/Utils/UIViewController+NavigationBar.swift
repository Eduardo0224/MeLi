//
//  UIViewController+NavigationBar.swift
//  MeLi
//
//  Created by Eduardo Andrade on 16/11/21.
//

import UIKit

extension UIViewController {
    
    // MARK: - Custom Functions
    func setupNavigationBar(withTitle title: String, and searchController: UISearchController) {
        
        guard let navigationController = navigationController else { return }
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = UIColor(named: "primary")
        appearance.shadowImage = UIImage()
        let titleTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: Constants.textForegroundColor,
                                                                   .font: Constants.harabaraFontWithSize(20) as Any]
        appearance.titleTextAttributes = titleTextAttributes
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = title
        
        let searchTextAttributes: [NSAttributedString.Key : Any] = [.foregroundColor: Constants.textForegroundColor,
                                                                    .font: Constants.harabaraFontWithSize(14) as Any]
        navigationItem.searchController = searchController
        guard let searchController = navigationItem.searchController else { return }
        searchController.searchBar.searchTextField.defaultTextAttributes = searchTextAttributes
    }
}
