//
//  NetworkManager.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 01/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

open class NetworkManager {
    
    public static var shared = NetworkManager()
    
    private init() {}
    
    public var cachePolicy: NSURLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    public var timeoutInterval: TimeInterval = 10.0
    public var showNetworkActivityIndicator = true
    public var defaultUrlSession = URLSession.shared
    
    #if DEBUG
    public var showDebugLog = true
    #else
    public var showDebugLog = false
    #endif
}

