//
//  ViewController.swift
//  MeLi
//
//  Created by Eduardo Andrade on 16/11/21.
//

import UIKit

typealias ProductDataSource = UICollectionViewDiffableDataSource<ProductSection, Product>
private typealias ProductSnapshot = NSDiffableDataSourceSnapshot<ProductSection, Product>

final class ProductsListViewController: UIViewController {
    
    // MARK: - @IBOutlets & @IBActions
    @IBOutlet private(set) weak var mainCollectionView: UICollectionView!
    
    // MARK: - Properties
    let viewModel = ProductsListViewModel()
    var currentSearchTask: URLSessionTask?
    private var searchController = UISearchController(searchResultsController: nil)
    var keyboardIsShowed = false
    private(set) var dataSource: ProductDataSource?
    private var snapshot = ProductSnapshot()
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(withTitle: "MeLi", and: searchController)
        setupSearchController()
        setupCollectionView()
        configureDataSource()
        addKeyboardObservers()
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
    
    func applySnapshot(animatingDifferences: Bool = true, hasResults: Bool = false) {
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.products)
        setupEmptyView(having: hasResults)
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences, completion: scrollToTop)
    }
    
    private func scrollToTop() {
        let beginning = IndexPath(row: 0, section: 0)
        if mainCollectionView.indexPathExists(beginning) {
            mainCollectionView.scrollToItem(at: beginning, at: .top, animated: true)
        }
    }
}

extension ProductsListViewController {
    
    // MARK: - Custom Functions
    private func setupProductListEmptyView(to type: ProductListEmpty.MessageType) {
        let productListEmpty: ProductListEmpty? = mainCollectionView.setEmptyView(withName: .noProducts)
        productListEmpty?.setMessage(of: type)
    }
    
    private func setupEmptyView(having hasResults: Bool = false) {
        if hasResults {
            setupProductListEmptyView(to: .withoutResults())
        } else if snapshot.itemIdentifiers.count == 0 {
            setupProductListEmptyView(to: .beforeSearching())
        } else {
            mainCollectionView.removeEmptyView()
        }
    }
}

