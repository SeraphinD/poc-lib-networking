//
//  UIImageView+SetImage.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 23/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

extension UIImageView {
    
    public func setImage(with url: URL?,
                  placeholder: UIImage? = nil,
                  showActivityIndicator: Bool = false) {
        
        guard let url = url else {
            return
        }
        
        ActivityIndicatorManager.showNetworkActivityIndicator()
        
        // Show activity indicator view when image retrieving image
        let activityIndicatorView = UIActivityIndicatorView()
        if showActivityIndicator {
            addSubview(activityIndicatorView)
            activityIndicatorView.center = CGPoint(x: bounds.midX, y: bounds.midY)
            activityIndicatorView.startAnimating()
        }
        
        // Set an image placeholder if needed
        if let placeholder = placeholder {
            image = placeholder
        }
        
        let task = NetworkManager.defaultUrlSession.dataTask(with: url) { data, response, error in
            
            ActivityIndicatorManager.hideNetworkActivityIndicatorIfNeeded()
            
            // UI operations must be called from main thread
            DispatchQueue.main.async() {
                if showActivityIndicator {
                    activityIndicatorView.stopAnimating()
                    activityIndicatorView.removeFromSuperview()
                }
            }
            
            guard let data = data, error == nil else { return }
            
            // UI operations must be called from main thread
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
        
        task.resume()
    }
}
