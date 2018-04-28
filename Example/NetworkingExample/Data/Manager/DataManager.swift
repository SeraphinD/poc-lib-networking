//
//  DataManager.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 28/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation

final class DataManager {
    
    let postService: PostService
    
    init() {
        postService = PostService()
    }
    
    static let shared = DataManager()
    
    func getPostList(completion: @escaping (_ posts: [PostResponse]?) -> ()) {
        postService.getPostList { postList in
            completion(postList)
        }
    }
    
    func getPost(_ id: Int, completion: @escaping (_ post: PostResponse?) -> ()) {
        postService.getPost(id) { postResponse in
            completion(postResponse)
        }
    }
}
