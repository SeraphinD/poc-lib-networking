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
    
    func requestObject<ResponseObject: Codable>(_ route: EndPoint,
                                                completion: @escaping (
        _ responseObject: ResponseObject?,
        _ urlResponse: URLResponse?,
        _ error: Error?)
        -> ())
    
    func requestArray<ResponseObject: Codable>(_ route: EndPoint,
                                                completion: @escaping (
        _ responseArray: [ResponseObject]?,
        _ urlResponse: URLResponse?,
        _ error: Error?)
        -> ())
    
    func cancel()
}
