//
//  PostDetailViewController.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 22/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import UIKit
import Networking

final class PostDetailViewController: UIViewController {
    
    @IBOutlet fileprivate weak var postDetailPresenter: PostDetailPresenter!
    @IBOutlet fileprivate weak var postBodyLabel: UILabel!
    @IBOutlet fileprivate weak var postImageView: UIImageView!
    
    var post: PostResponse!

    override func viewDidLoad() {
        super.viewDidLoad()
        postDetailPresenter.getPostDetail(for: post)
    }
}

extension PostDetailViewController: PostDetailPresenterDelegate {
    
    func bindPost(_ post: PostResponse) {
        navigationItem.title = post.title
        postImageView.setImage(with: URL(string: "https://picsum.photos/400/200"),
                               loader: .activityLight)
        setPostDetail(with: post)
    }
    
    func setPostDetail(with post: PostResponse) {
        postBodyLabel.text = post.body
    }
}
