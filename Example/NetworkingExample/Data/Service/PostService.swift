//
//  PostsService.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 07/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation
import Networking

final class PostService {
    
    private let router = Router<JSONPlaceholderEndPoint>()
    
    func getPostList(completion: @escaping (_ posts: [PostResponse]?, _ error: Error?) -> ()) {
        
        router.request(.postList) { data, response, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResponse.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, error)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode([PostResponse].self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, error)
                    }
                default: completion(nil, error)
                }
            }
        }
    }
    
    func getPost(_ id: Int, completion: @escaping (_ posts: PostResponse?, _ error: Error?) -> ()) {
        
        router.request(.post(id: id)) { data, response, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResponse.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, error)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(PostResponse.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        completion(nil, error)
                    }
                default: completion(nil, error)
                }
            }
        }
    }
}
