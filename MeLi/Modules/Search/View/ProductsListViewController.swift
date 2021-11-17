//
//  ViewController.swift
//  MeLi
//
//  Created by Eduardo Andrade on 16/11/21.
//

import UIKit

final class ProductsListViewController: UIViewController {
    
    // MARK: - @IBOutlets & @IBActions
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(withTitle: "MeLi", and: searchController)
    }
}

