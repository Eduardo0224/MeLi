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

protocol ProductBase: Codable {
    
    // MARK: - Properties
    var id: String { get set }
    var name: String { get set }
    var price: Double { get set }
}

struct Product: ProductBase, Hashable {
    
    // MARK: - Properties
    var id: String
    var name: String
    var price: Double
    let thumbnail: String
    
    // MARK: - Enums
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case price
        case thumbnail
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}
