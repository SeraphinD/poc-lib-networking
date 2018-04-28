//
//  NetworkRouter.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 01/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

public protocol NetworkRouter {
    
    associatedtype EndPoint: EndPointType
    
    func request(_ route: EndPoint,
                 completion: @escaping (
        _ data: Data?,
        _ urlResponse: URLResponse?,
        _ error: Error?)
        -> ())
    
    func requestObject<T: Codable>(_ route: EndPoint,
                                   completion: @escaping (
        _ responseObject: T?,
        _ urlResponse: URLResponse?,
        _ error: Error?)
        -> ())
    
    func cancel()
}
