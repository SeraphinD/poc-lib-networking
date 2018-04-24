//
//  PostListViewModel.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 22/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation

protocol PostListView: class {
    func setPostList(_ posts: [PostResponse])
}

final class PostListPresenter: NSObject, Presenter {
    
    weak var view: PostListView?
    
    private let service = PostService()
    
    func getPostList() {
        service.getPostList { posts in
            self.view?.setPostList(posts ?? [])
        }
    }
}
