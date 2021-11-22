//
//  ImageDownloader.swift
//  MeLi
//
//  Created by Eduardo Andrade on 18/11/21.
//

import UIKit

final class ImageDownloader {
    
    // MARK: - Singleton
    public static let `default` = ImageDownloader()
    
    // MARK: - Properties
    private let cache = NSCache<NSString, UIImage>()
    private let utilityQueue = DispatchQueue(label: "com.eandrade.MeLi.utilityQueue", qos: .utility, attributes: .concurrent)
    
    // MARK: - Enum
    public enum ImageError: Error {
        case request(String)
        case initialization
    }
    
    // MARK: - Inits
    private init() {
        
    }
    
    // MARK: - Custom Functions
    public func retrieveImage(by url: URL,
                              completion: @escaping (_ result: Result<UIImage?, ImageError>) -> Void) {
        guard let retrievedImage = cache.object(forKey: url.absoluteString as NSString) else {
            downloadImage(by: url, completion: completion)
            return
        }
        
        callInMainThread(result: .success(retrievedImage), completion: completion)
    }
    
    private func downloadImage(by url: URL,
                               completion: @escaping (_ result: Result<UIImage?, ImageError>) -> Void) {
        utilityQueue.async {
            let dataTask = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
                var downloadedImage: UIImage?
                
                if let error = error {
                    self.callInMainThread(result: .failure(.request(error.localizedDescription)), completion: completion)
                }
                
                if let data = data,
                   let imageFromData = UIImage(data: data) {
                    downloadedImage = imageFromData
                    self.cache.setObject(imageFromData, forKey: url.absoluteString as NSString)
                    
                    self.callInMainThread(result: .success(downloadedImage), completion: completion)
                } else {
                    self.callInMainThread(result: .failure(.initialization), completion: completion)
                }
            }
            dataTask.resume()
        }
    }
    
    private func callInMainThread(result: Result<UIImage?, ImageError>, completion: @escaping (_ result: Result<UIImage?, ImageError>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
