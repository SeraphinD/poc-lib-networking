//
//  JSONPlaceholderService.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 28/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation
import Networking

class JSONPlaceholderService {
    
    let router: Router<JSONPlaceholderEndPoint>
    
    init() {
        router = Router<JSONPlaceholderEndPoint>()
        router.delegate = self // You can also set the delegate as AppDelegate
    }
}

extension JSONPlaceholderService: NetworkRouterDelegate {
    func router<JSONPlaceholderEndPoint>(_ router: Router<JSONPlaceholderEndPoint>, didReceiveUnauthorized error: HTTPError) {
        // tell app delegate to set root window to login view controller for example
    }
}
