//
//  ProductListEmpty.swift
//  MeLi
//
//  Created by Eduardo Andrade on 22/11/21.
//

import UIKit

typealias Message = (title: String, description: String, icon: String)

final class ProductListEmpty: UIView {
    
    // MARK: - @IBOutlets & @IBActions
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Enum
    enum MessageType {
        case withoutResults(Message = (title: "Sin resultados para mostrar",
                                       description: "Por favor intenta buscar con palabras diferentes",
                                       icon: "slash.circle"))
        case beforeSearching(Message = (title:"Busca el producto que quieras",
                                        description: "Tenemos todos los productos que necesitas al alcance de tu mano",
                                        icon: "magnifyingglass"))
    }
    
    // MARK: - Custom Functions
    func setMessage(of type: MessageType) {
        switch type {
            case .beforeSearching(let message), .withoutResults(let message):
                titleLabel.text = message.title
                descriptionLabel.text = message.description
                iconImageView.image = UIImage(systemName: message.icon)
        }
    }
}
