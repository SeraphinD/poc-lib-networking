//
//  NetworkResponse.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 07/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

public enum Result<String> {
    case success
    case unauthorized
    case forbidden
    case failure
}

public class NetworkResponse {
    public static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch  response.statusCode {
        case 200...299: return .success
        case 401: return .unauthorized
        case 403: return .forbidden
        default: return .failure
        }
    }
}
