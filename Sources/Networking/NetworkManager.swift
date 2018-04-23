//
//  NetworkManager.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 01/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

open class NetworkManager {
    
    static var cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    static var timeoutInterval: TimeInterval = 10.0
    static var showNetworkActivityIndicator = true
    static var defaultUrlSession = URLSession.shared
    
    #if DEBUG
    static var showDebugLog = true
    #else
    static var showDebugLog = false
    #endif
}

