//
//  ProductList+Observers.swift
//  MeLi
//
//  Created by Eduardo Andrade on 22/11/21.
//

import UIKit

extension ProductsListViewController {
    
    // MARK: - Custom Functions
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        if !keyboardIsShowed,
           let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
           let emptyViewSubview = mainCollectionView.backgroundView?.subviews.first {
            keyboardIsShowed = true
            let keyboardHeight = keyboardFrame.cgRectValue.height
            emptyViewSubview.transform = emptyViewSubview.transform.translatedBy(x: 0, y: -(keyboardHeight / 2))
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if keyboardIsShowed,
           let emptyViewSubview = mainCollectionView.backgroundView?.subviews.first {
            keyboardIsShowed = false
            emptyViewSubview.transform = .identity
        }
    }
}
