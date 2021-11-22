//
//  Constants.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation
import UIKit

struct Constants {

    // MARK: - Properties
    
    // MARK: - Colors
    static let textForegroundColor = UIColor.black
    static let primaryColor = UIColor(named: "primary")
    
    // MARK: - Fonts
    static let harabaraFontWithSize: (CGFloat) -> UIFont? = { size in UIFont(name: "Harabara Mais Demo", size: size) }
    
    enum ReuseIdentifier: String {
        case product = "ProductCollectionViewCell"
    }
}

