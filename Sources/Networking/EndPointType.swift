//
//  EndPointType.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 01/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding? { get }
    var headers: HTTPHeaders? { get }
    var parameters: HTTPParameters? { get }
}

public typealias HTTPHeaders = [String: String]
public typealias HTTPParameters = [String: Any]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
