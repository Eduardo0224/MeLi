//
//  ProductsListConnection.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation

final class ProductsListConnection {
    
    // MARK: - Custom Functions
    func getProductBy(criteria textCriteria: String,
                      completion: @escaping (ResultConnection<ProductsResponse>) -> Void) -> URLSessionTask? {
        guard let url = MeLiAPI.Endpoints.getProductBy(criteria: textCriteria).url else {
            completion(.failure(.urlNilError))
            return nil
        }
        
        return MeLiAPI.taskForGETRequest(.init(method: .get, url: url), completion: completion)
    }
}
