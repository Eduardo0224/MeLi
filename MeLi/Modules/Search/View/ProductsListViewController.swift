//
//  ViewController.swift
//  MeLi
//
//  Created by Eduardo Andrade on 16/11/21.
//

import UIKit

private typealias ProductDataSource = UICollectionViewDiffableDataSource<ProductSection, Product>
private typealias ProductSnapshot = NSDiffableDataSourceSnapshot<ProductSection, Product>

final class ProductsListViewController: UIViewController {
    
    // MARK: - @IBOutlets & @IBActions
    @IBOutlet private weak var mainCollectionView: UICollectionView!
    
    // MARK: - Properties
    let viewModel = ProductsListViewModel()
    var currentSearchTask: URLSessionTask?
    private var searchController = UISearchController(searchResultsController: nil)    
    private var dataSource: ProductDataSource?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(withTitle: "MeLi", and: searchController)
        setupSearchController()
        setupCollectionView()
        configureDataSource()
    }
    
    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupCollectionView() {
        mainCollectionView.contentInset = .init(top: 5, left: 0, bottom: 0, right: 0)
        mainCollectionView.collectionViewLayout = customLayout
        mainCollectionView.delegate = self
    }
    
    private func configureDataSource() {
        dataSource = .make(to: mainCollectionView)
        applySnapshot(animatingDifferences: false)
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = ProductSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.products)
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

