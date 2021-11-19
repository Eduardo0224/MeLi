//
//  ProductCollectionViewCell.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import UIKit

final class ProductCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    // MARK: - @IBOutlets & @IBActions
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    // MARK: - Properties
    private var product: Product?
    
    // MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom Functions
    func setup(data: Product) {
        product = data
        titleLabel.text = product?.name
        if let price = product?.price {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let number = NSNumber(value: price)
            let formattedValue = formatter.string(from: number)
            priceLabel.text = formattedValue
        }
    }
}
