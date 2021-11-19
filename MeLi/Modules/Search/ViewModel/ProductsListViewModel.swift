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
                      onComplete: @escaping () -> Void,
                      onFailure: @escaping (MeLiAPI.NetworkError) -> Void) -> URLSessionTask? {
        connection.getProductBy(criteria: textCriteria.trimmingCharacters(in: .whitespacesAndNewlines)) { result in
            switch result {
                case .success(let response):
                    self.products = response.results
                    onComplete()
                case .failure(let error):
                    onFailure(error)
            }
        }
    }
}
