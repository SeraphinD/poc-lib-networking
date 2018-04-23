//
//  NetworkRouter.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 01/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

public typealias ServiceCompletionHandler = (_ data: Data?,
    _ response: URLResponse?,
    _ error: Error?)
    -> ()

public protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping ServiceCompletionHandler)
    func cancel()
}
