//
//  PostDetailPresenter.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 22/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation

protocol PostDetailView: class {
    func bindPost(_ post: PostResponse)
    func setPostDetail(with post: PostResponse)
}

final class PostDetailPresenter: NSObject, Presenter {
    
    weak var view: PostDetailView?
    
    private let service = PostService()
    
    func getPostDetail(for post: PostResponse) {
        self.view?.bindPost(post)
        service.getPost(post.id) { post in
            guard let post = post else {
                return
            }
            self.view?.setPostDetail(with: post)
        }
    }
}
