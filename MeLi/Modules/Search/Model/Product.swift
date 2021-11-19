//
//  Product.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation

enum ProductSection: Hashable {
    case main
}

struct Product: Codable, Hashable {
    
    // MARK: - Properties
    let id: String
    let name: String
    let price: Int
    
    // MARK: - Enums
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case price
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
