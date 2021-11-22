//
//  DetailProduct+MockData.swift
//  MeLi
//
//  Created by Eduardo Andrade on 20/11/21.
//

import Foundation

extension DetailProduct {
    
    // MARK: - Properties
    static let testData: Self =
        .init(id: "MCO608634357",
              name: "Apple iPhone 11 (64 Gb) - Verde",
              price: 2789000,
              originalPrice: 2919000,
              availableQuantity: 1,
              soldQuantity: 5,
              condition: "new",
              pictures: [
                .init(id: "722823-MLA46152872969_052021", url: "https://http2.mlstatic.com/D_722823-MLA46152872969_052021-O.jpg"),
                .init(id: "865941-MLA46152872970_052021", url: "https://http2.mlstatic.com/D_865941-MLA46152872970_052021-O.jpg"),
                .init(id: "700620-MLA46153276328_052021", url: "https://http2.mlstatic.com/D_700620-MLA46153276328_052021-O.jpg")
              ],
              attributes: [
                .init(id: "BATTERY_CAPACITY", name: "Capacidad de la batería", value: "3110 mAh"),
                .init(id: "BRAND", name: "Marca", value: "Apple"),
                .init(id: "BATTERY_TYPE", name: "Tipo de batería", value: "Ion de litio")
              ])
    
    static let placeholderData: Self =
        .init(id: "MCO608634357",
              name: "",
              price: 0,
              originalPrice: 0,
              availableQuantity: 0,
              soldQuantity: 0,
              condition: "0",
              pictures: [],
              attributes: [])
}
