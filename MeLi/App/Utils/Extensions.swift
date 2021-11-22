//
//  Extensions.swift
//  MeLi
//
//  Created by Eduardo Andrade on 17/11/21.
//

import Foundation
import UIKit

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


extension UICollectionView {
    
    // MARK: - Enums
    enum ViewName: String {
        case noProducts = "ProductListEmpty"
    }
    
    // MARK: - Custom Functions
    func setEmptyView<T: UIView>(withName name: ViewName) -> T? {
        if let viewFromXib = Bundle.main.loadNibNamed(name.rawValue, owner: self, options: nil)?.first as? UIView {
            viewFromXib.frame = .init(origin: .init(x: 0,y :0), size: .init(width: bounds.size.width, height: bounds.size.height))
            backgroundView = viewFromXib
            return viewFromXib as? T
        }
        return nil
    }
    
    func removeEmptyView() {
        backgroundView = nil
    }
    
    func indexPathExists(_ indexPath: IndexPath) -> Bool {
        return !(indexPath.section >= self.numberOfSections || indexPath.row >= self.numberOfItems(inSection: indexPath.section))
    }
}

