//
//  DetailProductView.swift
//  MeLi
//
//  Created by Eduardo Andrade on 19/11/21.
//

import SwiftUI

struct DetailProductView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = DetailProductViewModel()
    @Environment(\.presentationMode) var presentationMode
    private var detailProductId = ""
    
    // MARK: - Inits
    init(with id: String) {
        detailProductId = id
    }
    
    // MARK: - Views
    private var attributesList: some View {
        List {
            ForEach(Array(viewModel.detailProduct.attributes.enumerated()),
                    id: \.1.id) { index, attribute in
                AttributeRowView(with: index, attribute)
            }
        }
        .background(Color.white)
        .listStyle(PlainListStyle())
    }
    
    private var imagesGallery: some View {
        GeometryReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(viewModel.detailProduct.imageDatas) { imageData in
                        imageData.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: proxy.size.width * 0.5)
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(width: proxy.size.width, height: 250)
        }
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(viewModel.detailProduct.condition)
                    + Text(" | ") +
                    Text("\(viewModel.detailProduct.soldQuantity) vendidos")
                }
                .foregroundColor(.gray)
                .font(Font.custom("Harabara Mais Demo", size: 15))
                .padding(.horizontal, 16)
                
                Text(viewModel.detailProduct.name)
                    .font(.title2)
                    .padding(.horizontal, 16)
                
                imagesGallery
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    if let original = viewModel.detailProduct.originalPrice,
                       original != 0 {
                        Text("$ \(Int(original))")
                            .font(.headline)
                            .strikethrough()
                            .foregroundColor(.gray)
                    }
                   
                    HStack {
                        Text("$ \(Int(viewModel.detailProduct.price))")
                            .font(.title)
                        if viewModel.detailProduct.discountPercent != "" {
                            Text("\(viewModel.detailProduct.discountPercent) OFF")
                                .font(.title3)
                                .foregroundColor(.green)
                        }
                        
                    }
                }
                .padding(.horizontal, 16)
                
                attributesList
                    .padding(.horizontal, 16)
            }
            .padding(.top, 16)
            loaderView
        }
        .onReceive(viewModel.$requestError, perform: { error in
            if error != nil {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .onAppear {
            viewModel.getDetailProductBy(id: detailProductId)
        }
    }
}


// MARK: - DetailProductView+Loader
extension DetailProductView {
    
    // MARK: - Views
    var loaderView: some View {
        Group {
            if viewModel.isLoading {
                ZStack {
                    Color.black.opacity(0.3)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                }
                .ignoresSafeArea()
            } else {
                EmptyView()
            }
        }
    }
}

struct DetailProductView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailProductView(with: "MCO496757637")
        }
    }
}
