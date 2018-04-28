//
//  PostDetailPresenter.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 22/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation

@objc protocol PostDetailPresenterDelegate {
    func bindPost(_ post: PostResponse)
    func setPostDetail(with post: PostResponse)
}

final class PostDetailPresenter: NSObject, Presenter {
    
    @IBOutlet weak var delegate: PostDetailPresenterDelegate?
    
    func getPostDetail(for post: PostResponse) {
        self.delegate?.bindPost(post)
        dataManager.getPost(post.id) { [weak self] post in
            guard let post = post else {
                return
            }
            self?.delegate?.setPostDetail(with: post)
        }
    }
}
