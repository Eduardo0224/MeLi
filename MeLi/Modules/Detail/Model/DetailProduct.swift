//
//  DetailProduct.swift
//  MeLi
//
//  Created by Eduardo Andrade on 19/11/21.
//

import UIKit
import SwiftUI

struct DetailProduct: ProductBase {
    
    // MARK: - Properties
    var id: String
    var name: String
    var price: Double
    let originalPrice: Double?
    let availableQuantity: Int
    let soldQuantity: Int
    let condition: String
    let pictures: [Picture]
    var imageDatas: [ImageData] = []
    let attributes: [Attribute]
    
    var discountPercent: String {
        guard let original = originalPrice,
              original != 0 else {
                  return ""
              }
        let result = abs(((price / original) * 100) - 100)
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: result)) ?? ""
    }
    
    // MARK: - Enums
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case price
        case originalPrice = "original_price"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case condition
        case pictures
        case attributes
    }
    
    struct ImageData: Identifiable {
        
        // MARK: - Properties
        let id: String
        let image: Image
    }
    
    // MARK: - Nested Structs
    struct Picture: Codable, Identifiable {
        
        // MARK: - Properties
        let id: String
        let url: String
        
        // MARK: - Enums
        enum CodingKeys: String, CodingKey {
            case id
            case url = "secure_url"
        }
    }
    
    struct Attribute: Codable, Identifiable {
        
        // MARK: - Properties
        let id: String
        let name: String?
        let value: String?
        
        // MARK: - Enums
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case value = "value_name"
        }
    }
}
