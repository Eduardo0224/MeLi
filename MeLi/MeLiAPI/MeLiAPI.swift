//
//  MeLiAPI.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation
import Combine
import UIKit
import SwiftUI

// MARK: - Typealiases
typealias ResultConnection<RequestType> = Result<RequestType, MeLiAPI.NetworkError>

final class MeLiAPI {
    
    // MARK: - Enums
    
    /**
     ## Manages the path component to complete URL.
     Makes use of associated values for such purpose
     */
    enum Endpoints {
        static let base = "https://api.mercadolibre.com"
        static let baseSearch = "/sites/MCO/search"
        static let productDetail = "/items"
        
        case getProductBy(criteria: String = "")
        case getProductDetailBy(id: String)
        
        var stringURL: String {
            switch self {
                case .getProductBy(let criteria):
                    guard let searchCriteria = criteria.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    else { return "" }
                    return "\(Endpoints.base)\(Endpoints.baseSearch)?q=\(searchCriteria)"
                case .getProductDetailBy(let id):
                    return "\(Endpoints.base)\(Endpoints.productDetail)/\(id)"
            }
        }
        
        var url: URL? { URL(string: stringURL) }
    }
    
    /// Network Error
    enum NetworkError: Error {
        case urlNilError
        case requestError(String?)
        case internalServerError
        case decodeError(String)
        case unknownError
    }
    
    /// HTTP Status Code
    enum HTTPStatusCode: Int, Error {
        case ok = 200
        case notFound = 400
        case serverError = 500
        case unknown
        
        init(code: Int) {
            switch code {
                case 200...299: self = .ok
                case 400...499: self = .notFound
                case 500...599: self = .serverError
                default: self = .unknown
            }
        }
    }
    
    // HTTP Method
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    
    // MARK: - Structs
    struct Request {
        
        // MARK: - Properties
        let method: HTTPMethod
        let url: URL
        
        // MARK: - Inits
        init(method: HTTPMethod, url: URL) {
            self.method = method
            self.url = url
        }
        
        var urlRequest: URLRequest {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }
    }
    
    // MARK: - Functions
    static func taskForGETRequestImagePublisher(_ request: Request) -> AnyPublisher<DetailProduct.ImageData, Error> {
        MeLiAPI.taskForGETRequestDataPublisher(request)
            .compactMap { UIImage(data: $0) }
            .map { .init(id: request.url.absoluteString,
                         image: Image(uiImage: $0)) }
            .eraseToAnyPublisher()
    }
    
    static func taskForGETRequestPublisher<RequestType: Decodable>(_ request: Request) -> AnyPublisher<RequestType, Error> {
        MeLiAPI.taskForGETRequestDataPublisher(request)
            .decode(type: RequestType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    private static func taskForGETRequestDataPublisher(_ request: Request) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: request.urlRequest)
            .mapError { error -> NetworkError in
                let errorCode = HTTPStatusCode(code: error.errorCode)
                switch errorCode {
                    case .notFound:
                        return .requestError(nil)
                    case .serverError:
                        return .internalServerError
                    default:
                        return .unknownError
                }
            }
            .tryMap { data, urlResponse -> Data in
                #if DEBUG
                printURLSession(data, request: request.urlRequest, in: urlResponse)
                #endif
                guard let response = urlResponse as? HTTPURLResponse else {
                    throw NetworkError.requestError(nil)
                }
                
                let statusCode = HTTPStatusCode(code: response.statusCode)
                if case .ok = statusCode {
                    return data
                } else {
                    throw NetworkError.requestError("status code: \(statusCode)")
                }
            }
            .eraseToAnyPublisher()
    }
    
    @discardableResult static func taskForGETRequest<RequestType: Decodable>(_ request: Request,
                                                                             completion: @escaping (ResultConnection<RequestType>) -> Void) -> URLSessionTask? {
        let dataTask = URLSession.shared.dataTask(with: request.urlRequest) { data, urlResponse, requestError in
            
            #if DEBUG
            printURLSession(data, request: request.urlRequest, in: urlResponse)
            #endif
            
            if let error = requestError {
                failureResponseHandler(with: .requestError(error.localizedDescription), in: completion); return
            } else {
                guard let data = data else {
                    failureResponseHandler(with: .requestError(nil), in: completion); return
                }
                
                switch HTTPStatusCode(code: (urlResponse as? HTTPURLResponse)?.statusCode ?? 0) {
                    case .ok:
                        let decoder = JSONDecoder()
                        do {
                            let responseDecoded = try decoder.decode(RequestType.self, from: data)
                            callInMainThread { completion(.success(responseDecoded)) }
                        } catch (let error) {
                            failureResponseHandler(with: .decodeError(error.localizedDescription), in: completion)
                        }
                    case .notFound:
                        failureResponseHandler(with: .requestError(nil), in: completion)
                    case .serverError:
                        failureResponseHandler(with: .internalServerError, in: completion)
                    case .unknown:
                        failureResponseHandler(with: .unknownError, in: completion)
                }
            }
        }
        dataTask.resume()
        return dataTask
    }
    
    private static func failureResponseHandler<RequestType>(with error: MeLiAPI.NetworkError,
                                                            in completion: @escaping (ResultConnection<RequestType>) -> Void) {
        callInMainThread { completion(.failure(error)) }
    }
    
    private static func callInMainThread(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
}


