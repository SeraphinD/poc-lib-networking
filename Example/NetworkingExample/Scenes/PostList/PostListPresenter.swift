//
//  PostListViewModel.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 22/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation

@objc protocol PostListPresenterDelegate {
    func setPostList(_ posts: [PostResponse])
}

final class PostListPresenter: NSObject, Presenter {
    
    @IBOutlet weak var delegate: PostListPresenterDelegate?
    
    func getPostList() {
        dataManager.getPostList { posts in
            self.delegate?.setPostList(posts ?? [])
        }
    }
}
