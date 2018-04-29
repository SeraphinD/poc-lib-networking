//
//  ViewController.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 07/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import UIKit

final class PostListViewController: UIViewController {

    @IBOutlet fileprivate weak var postListPresenter: PostListPresenter!
    @IBOutlet fileprivate weak var postListDataSource: PostListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postListPresenter.getPostList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Storyboard.PostList.showPostDetail,
            let destination = segue.destination as? PostDetailViewController,
            let selectedRow = postListDataSource.selectedRow {
            destination.post = postListDataSource.dataSource[selectedRow]
        }
    }
}

extension PostListViewController: PostListPresenterDelegate {
    func setPostList(_ posts: [PostResponse]) {
        postListDataSource.insertAllPosts(posts)
    }
}

