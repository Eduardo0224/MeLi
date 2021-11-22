//
//  DetailProductConnection.swift
//  MeLi
//
//  Created by Eduardo Andrade on 19/11/21.
//

import Foundation
import Combine
import UIKit
import SwiftUI

final class DetailProductConnection {
    
    // MARK: - Custom Functions
    func getDetailProductBy(id: String) -> AnyPublisher<DetailProduct, Error>? {
        guard let url = MeLiAPI.Endpoints.getProductDetailBy(id: id).url else {
            return nil
        }
        return MeLiAPI.taskForGETRequestPublisher(.init(method: .get, url: url))
    }
    
    func getPictureProductBy(url: String) -> AnyPublisher<DetailProduct.ImageData, Error>? {
        guard let url = URL(string: url) else {
            return nil
        }
        return MeLiAPI.taskForGETRequestImagePublisher(.init(method: .get, url: url))
    }
}
