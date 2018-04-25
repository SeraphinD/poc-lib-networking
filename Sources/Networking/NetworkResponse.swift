//
//  NetworkResponse.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 07/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

public enum HTTPError {
    case unknown, unauthorized, forbidden
}

public enum HTTPResult {
    case success, failure(HTTPError)
}

extension HTTPURLResponse {
    var result: HTTPResult {
        switch  statusCode {
        case 200...299: return .success
        case 401: return .failure(.unauthorized)
        case 403: return .failure(.forbidden)
        default: return .failure(.unknown)
        }
    }
}
