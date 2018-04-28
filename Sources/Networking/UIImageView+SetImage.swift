//
//  UIImageView+SetImage.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 23/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

public enum ImageActivityIndicatorType {
    case activityLight, activityDark, none
}

extension UIImageView {
    
    public func setImage(with url: URL?,
                  placeholder: UIImage? = nil,
                  loader: ImageActivityIndicatorType = .none) {
        
        guard let url = url else { return }
        
        ActivityIndicatorManager.showNetworkActivityIndicator()
        
        // Show activity indicator view when image retrieving image
        let activityIndicatorView = UIActivityIndicatorView()
        if loader != .none {
            addSubview(activityIndicatorView)
            if loader == .activityLight {
                activityIndicatorView.activityIndicatorViewStyle = .white
            } else if loader == .activityDark {
                activityIndicatorView.activityIndicatorViewStyle = .gray
            }
            activityIndicatorView.center = CGPoint(x: bounds.midX, y: bounds.midY)
            activityIndicatorView.startAnimating()
        }
        
        // Set an image placeholder if needed
        if let placeholder = placeholder {
            image = placeholder
        }
        
        let task = NetworkManager.shared.defaultUrlSession.dataTask(with: url) { data, _, error in
            
            ActivityIndicatorManager.hideNetworkActivityIndicatorIfNeeded()
            
            // UI operations must be called from main thread
            DispatchQueue.main.async() {
                if loader != .none {
                    activityIndicatorView.stopAnimating()
                    activityIndicatorView.removeFromSuperview() // removeFromSuperview calls release
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
