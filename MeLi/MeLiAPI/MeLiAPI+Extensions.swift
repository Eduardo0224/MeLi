//
//  MeLiAPI+Extensions.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation

extension MeLiAPI {
    
    // MARK: - Custom Functions
    static func printURLSession(_ data: Data?, request: URLRequest, in response: URLResponse?) {
        if let dateToPrint = Date().stringFormatted(by: "dd/MM/yyyy | hh:mm:ss a", haveTwelveHoursSymbols: true) {
            let message =
                """
                HTTP Request: --------------------------------
                Date:        \(dateToPrint)
                Url:         \(response?.url?.absoluteURL.absoluteString ?? "")
                Method:      \(request.httpMethod ?? "")
                Body:        \(request.httpBody?.prettyPrintedJSONString ?? "{}")
                
                Response: -------------------------------
                Date:        \(dateToPrint)
                Status Code: \((response as? HTTPURLResponse)?.statusCode ?? 0)
                Data:        \(data?.prettyPrintedJSONString ?? "{}")
                """
            print(message)
        }
    }
}


