//
//  JSONPlaceholderAPI.swift
//  SDNetworkExample
//
//  Created by Seraphin DESUMEUR on 07/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation
import Networking

enum JSONPlaceholderEndPoint {
    case postList
    case post(id: Int)
}

extension JSONPlaceholderEndPoint: EndPointType {
    
    var baseURL: URL {
        guard let strUrl = Bundle.main.infoDictionary!["JSONPlaceholderAPIURL"] as? String,
            let url = URL(string: strUrl) else {
                fatalError("Must declare base JSONPlaceholder api url in Info.plist")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .postList: return "posts"
        case .post(let id): return "posts/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postList: return .get
        case .post: return .get
        }
    }
    
    var encoding: ParameterEncoding? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: HTTPParameters? {
        return nil
    }
    
    var authRequired: Bool {
        return false
    }
}
