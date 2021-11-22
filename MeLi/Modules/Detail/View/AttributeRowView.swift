//
//  AttributeRowView.swift
//  MeLi
//
//  Created by Eduardo Andrade on 20/11/21.
//

import SwiftUI

struct AttributeRowView: View {
    
    // MARK: - Properties
    let attribute: DetailProduct.Attribute
    let index: Int
    
    // MARK: - Inits
    init(with index: Int, _ attribute: DetailProduct.Attribute) {
        self.index = index
        self.attribute = attribute
    }
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(attribute.name ?? "")
                .bold()
            Spacer()
            Text(attribute.value ?? "")
                .lineLimit(3)
        }
        .font(.caption)
        .listRowBackground(index % 2 == 0 ? Color.gray.opacity(0.3) : Color.white.opacity(0.3))
    }
}

struct AttributeRowView_Previews: PreviewProvider {
    static var previews: some View {        
        List {
            ForEach(Array(DetailProduct.testData.attributes.enumerated()),
                    id: \.1.id) { index, attribute in
                AttributeRowView(with: index, attribute)
            }
        }
        .background(Color.white)
        .listStyle(PlainListStyle())
        .previewLayout(.fixed(width: 358, height: 132))
    }
}
