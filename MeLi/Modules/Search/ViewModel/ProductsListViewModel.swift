//
//  ProductsListViewModel.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation

final class ProductsListViewModel {
    
    // MARK: - Properties
    /// API Connection
    private let connection = ProductsListConnection()
    private(set) var products = [Product]()
    
    // MARK: - Custom Functions
    func getProductBy(criteria textCriteria: String,
                      onComplete: @escaping (_ resultsCount: Int) -> Void,
                      onFailure: @escaping (MeLiAPI.NetworkError) -> Void) -> URLSessionTask? {
        connection.getProductBy(criteria: textCriteria.trimmingCharacters(in: .whitespacesAndNewlines)) { result in
            switch result {
                case .success(let response):
                    self.products = response.results
                    onComplete(self.products.count)
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
    
    func clearProductList() {
        products = []
    }
}
