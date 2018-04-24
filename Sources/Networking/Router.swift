//
//  Router.swift
//  Networking
//
//  Created by Seraphin DESUMEUR on 01/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

public class Router<EndPoint: EndPointType>: NetworkRouter {
    
    public init() {}
    
    private var task: URLSessionTask?
    
    public func request(_ route: EndPoint,
                        completion: @escaping ServiceCompletionHandler) {
        
        let session = NetworkManager.defaultUrlSession
        
        do {
            let request = try self.buildRequest(from: route)
            ActivityIndicatorManager.showNetworkActivityIndicator()
            task = session.dataTask(with: request,
                                    completionHandler: { (data, response, error) in
                                        ActivityIndicatorManager.hideNetworkActivityIndicatorIfNeeded()
                                        self.printResponse(request, data, error)
                                        DispatchQueue.main.async {
                                            completion(data, response, error)
                                        }
            })
        } catch {
            DispatchQueue.main.async {
                completion(nil, nil, error)
            }
        }
        task?.resume()
    }
    
//    public func request<T: Codable>(_ route: EndPoint,
//                                    completion: @escaping ServiceCompletionHandler) {
//        let session = NetworkManager.defaultUrlSession
//
//        do {
//            let request = try self.buildRequest(from: route)
//            ActivityIndicatorManager.showNetworkActivityIndicator()
//            task = session.dataTask(with: request,
//                                    completionHandler: { (data, response, error) in
//                                        ActivityIndicatorManager.hideNetworkActivityIndicatorIfNeeded()
//                                        self.printResponse(request, data, error)
//                                        DispatchQueue.main.async {
//                                            completion(T(), response, error)
//                                        }
//            })
//        } catch {
//            DispatchQueue.main.async {
//                completion(nil, nil, error)
//            }
//        }
//        task?.resume()
//    }
    
    public func upload(_ route: EndPoint,
                       completion: @escaping ServiceCompletionHandler) {
        // TODO : multipart upload
        fatalError()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: NetworkManager.cachePolicy,
                                 timeoutInterval: NetworkManager.timeoutInterval)
        request.httpMethod = route.method.rawValue
        do {
            switch route.encoding {
            case .bodyEncoding?:
                try self.configureParameters(bodyParameters: route.parameters,
                                             request: &request)
            case .URLEncoding?:
                try self.configureParameters(urlParameters: route.parameters,
                                             request: &request)
            default:
                request.setValue("application/json",
                                 forHTTPHeaderField: "Content-Type")
            }
            
            configureHeaders(route.headers,
                             request: &request)
            
            return request
        } catch {
            throw error
        }
    }
    
    private func configureParameters(bodyParameters: HTTPParameters? = nil,
                                    urlParameters: HTTPParameters? = nil,
                                    request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder().encode(urlRequest: &request,
                                                  with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder().encode(urlRequest: &request,
                                                 with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    private func configureHeaders(_ headers: HTTPHeaders?,
                                  request: inout URLRequest) {
        guard let headers = headers else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func printResponse(_ request: URLRequest,
                               _ data: Data?,
                               _ error: Error?) {
        if NetworkManager.showDebugLog {
            let urlAsString = request.url?.absoluteString ?? ""
            let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
            
            var logOutput = """
            \(method) \(urlAsString) \n
            """
            for (key,value) in request.allHTTPHeaderFields ?? [:] {
                logOutput += "\(key): \(value) "
            }
            if let body = request.httpBody {
                logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
            }
            print(logOutput)
            if let data = data, let responseData = String(data: data, encoding: .utf8) {
                print(responseData)
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
