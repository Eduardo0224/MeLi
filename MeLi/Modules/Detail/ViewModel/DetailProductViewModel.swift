//
//  DetailProductViewModel.swift
//  MeLi
//
//  Created by Eduardo Andrade on 19/11/21.
//

import Foundation
import Combine
import SwiftUI

final class DetailProductViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var detailProduct: DetailProduct
    @Published var requestError: MeLiAPI.NetworkError?
    @Published var isLoading = true
    
    // API Connection
    private let connection = DetailProductConnection()
    private var picturesDetailProductPublishers: [AnyPublisher<DetailProduct.ImageData, Error>] {
        detailProduct.pictures.map { connection.getPictureProductBy(url: $0.url) }.compactMap { $0 }
    }
    var subscribers = Set<AnyCancellable>()
    
    // MARK: - Inits
    init() {
        detailProduct = .placeholderData
    }
    
    // MARK: - Custom Functions
    func getDetailProductBy(id: String) {
        connection.getDetailProductBy(id: id)?
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: receiveCompletionHandler(_:),
                  receiveValue: { detailProduct in
                self.detailProduct = detailProduct
                self.getAllPictures()
            })
            .store(in: &subscribers)
    }
    
    private func getAllPictures() {
        Publishers.MergeMany(picturesDetailProductPublishers)
            .collect()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: receiveCompletionHandler(_:),
                  receiveValue: { images in
                self.detailProduct.imageDatas = images
            })
            .store(in: &subscribers)
    }
    
    private func receiveCompletionHandler(_ completion: Subscribers.Completion<Error>) {
        switch completion {
            case .finished:
                self.isLoading = false
            case .failure(let error):
                self.requestError = error as? MeLiAPI.NetworkError
        }
    }
}

