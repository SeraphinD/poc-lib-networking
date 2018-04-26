//
//  ActivityIndicatorManager.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 23/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation

final class ActivityIndicatorManager {
    static func showNetworkActivityIndicator() {
        if NetworkManager.shared.showNetworkActivityIndicator {
            DispatchQueue.main.async {
                // UI operations must be called from main thread
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        }
    }
    
    static func hideNetworkActivityIndicatorIfNeeded() {
        DispatchQueue.main.async {
            // UI operations must be called from main thread
            if UIApplication.shared.isNetworkActivityIndicatorVisible {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
}
