//
//  StoryboardedProtocol.swift
//  MeLi
//
//  Created by Eduardo Andrade on 16/11/21.
//

import UIKit

// MARK: - Enums
enum StoryboardName: String {
    case productsList = "ProductsList"
    case productDetail = "ProductDetail"
}

// MARK: - Protocol Storyboarded
protocol Storyboarded {
    
    // MARK: - Custom Functions
    static func instantiate(from storyboardName: StoryboardName) -> Self
}

// MARK: - Protocol Extension
extension Storyboarded where Self: UIViewController {
    
    // MARK: - Custom Functions
    static func instantiate(from storyboardName: StoryboardName) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
