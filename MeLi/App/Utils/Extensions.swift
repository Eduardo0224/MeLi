//
//  Extensions.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation

extension Date {
    
    // MARK: - Custom Functions
    public func stringFormatted(by format: String,
                                haveTwelveHoursSymbols symbols: Bool = false) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "es_CO")       
        if let date = Calendar.current.date(byAdding: .hour, value: -5, to: self) {
            dateFormatter.dateFormat = format
            if symbols {
                dateFormatter.amSymbol = "am"
                dateFormatter.pmSymbol = "pm"
            }
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

extension Data {
    
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}


