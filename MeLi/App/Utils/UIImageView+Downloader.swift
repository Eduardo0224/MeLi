//
//  UIImageView+Downloader.swift
//  MeLi
//
//  Created by Eduardo Andrade on 18/11/21.
//

import UIKit

extension UIImageView {
    
    // MARK: - Properties
    private var activityIndicator: UIActivityIndicatorView {
        if let indicator = self.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
            return indicator
        }
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        return indicator
    }
    
    // MARK: - Custom Functions
    func downloadImage(from urlString: String,
                       withPlaceholder placeholder: UIImage? = nil,
                       completion: (() -> Void)? = nil,
                       completionFailured: ((ImageDownloader.ImageError) -> Void)? = nil) {
        guard let url = URL(string: urlString)
        else {
            image = placeholder
            return
        }
        downloadImage(fromURL: url,
                      withPlaceholder: placeholder,
                      completion: completion,
                      completionFailured: completionFailured)
    }
    
    private func downloadImage(fromURL url: URL,
                               withPlaceholder placeholder: UIImage?,
                               completion: (() -> Void)? = nil,
                               completionFailured: ((ImageDownloader.ImageError) -> Void)? = nil) {
        activityIndicator.startAnimating()
        image = placeholder
        ImageDownloader.default.retrieveImage(by: url) { [weak self] result in
            self?.removeIndicator()
            switch result {
                case .success(let image):
                    self?.image = image
                    self?.contentMode = .scaleAspectFit
                    completion?()
                case .failure(let error):
                    completionFailured?(error)
            }
        }
    }
    
    private func removeIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
