//
//  ConfigurableCell.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation

protocol ConfigurableCell {
    
    // MARK: - Properties
    associatedtype DateType
    
    // MARK: - Functions
    func setup(data: DateType)
}
