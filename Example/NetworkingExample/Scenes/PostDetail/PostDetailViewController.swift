//
//  PostDetailViewController.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 22/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import UIKit

final class PostDetailViewController: UIViewController {
    
    @IBOutlet fileprivate weak var postDetailPresenter: PostDetailPresenter!
    @IBOutlet fileprivate weak var postBodyLabel: UILabel!
    
    var post: PostResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        postDetailPresenter.attach(view: self)
        postDetailPresenter.getPostDetail(for: post)
    }
}

extension PostDetailViewController: PostDetailView {
    
    func bindPost(_ post: PostResponse) {
        navigationItem.title = post.title
        setPostDetail(with: post)
    }
    
    func setPostDetail(with post: PostResponse) {
        postBodyLabel.text = post.body
    }
}
