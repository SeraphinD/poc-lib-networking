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
    
    private(set) var handleNotAuth: Bool = false
    
    public var auth: Router {
        handleNotAuth = true
        return self
    }
    
    public func request(_ route: EndPoint,
                        completion: @escaping (
        _ data: Data?,
        _ urlResponse: URLResponse?,
        _ error: Error?)
        -> ()) {
        
        let session = NetworkManager.shared.defaultUrlSession
        
        do {
            let request = try self.buildRequest(from: route)
            ActivityIndicatorManager.showNetworkActivityIndicator()
            task = session.dataTask(with: request,
                                    completionHandler: { (data, response, error) in
                                        ActivityIndicatorManager.hideNetworkActivityIndicatorIfNeeded()
                                        
                                        if self.handleNotAuth, let result = response?.result {
                                            switch result {
                                            case .failure(let error):
                                                if error == .unauthorized {
                                                    NetworkManager.shared.delegate?.applicationHandleUnauth(UIApplication.shared)
                                                }
                                            default: break
                                            }
                                            completion(nil, response, error)
                                        }
                                        
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
    
    public func requestObject<T: Codable>(_ route: EndPoint,
                                          completion: @escaping (
        _ responseObject: T?,
        _ urlResponse: URLResponse?,
        _ error: Error?)
        -> ()) {
        
        request(route) { (data, urlResponse, error) in
            guard let responseData = data else {
                completion(nil, urlResponse, error)
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                completion(apiResponse, urlResponse, error)
            } catch {
                completion(nil, urlResponse, error)
            }
        }
    }
    
    public func requestArray<T: Codable>(_ route: EndPoint,
                                         completion: @escaping (
        _ responseArray: [T]?,
        _ urlResponse: URLResponse?,
        _ error: Error?)
        -> ()) {
        
        request(route) { (data, urlResponse, error) in
            guard let responseData = data else {
                completion(nil, urlResponse, error)
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode([T].self, from: responseData)
                completion(apiResponse, urlResponse, error)
            } catch {
                completion(nil, urlResponse, error)
            }
        }
    }
    
    public func upload(_ route: EndPoint,
                       completion: @escaping (
        _ data: Data?,
        _ response: URLResponse?,
        _ error: Error?) -> ()) {
        // TODO : multipart upload
        fatalError()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    private func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: NetworkManager.shared.cachePolicy,
                                 timeoutInterval: NetworkManager.shared.timeoutInterval)
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
        if NetworkManager.shared.showDebugLog {
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
