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
    
    func getPostList(completion: @escaping (_ posts: [PostResponse]?) -> ()) {
        router.auth.requestArray(.postList) { (postList: [PostResponse]?, _, _) in
            completion(postList)
        }
    }
    
    func getPost(_ id: Int, completion: @escaping (_ post: PostResponse?) -> ()) {
        router.requestObject(.post(id: id)) { (postResponse: PostResponse?, _, _) in
            completion(postResponse)
        }
    }
}
