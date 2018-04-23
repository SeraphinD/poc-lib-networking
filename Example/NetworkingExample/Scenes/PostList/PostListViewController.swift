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
    @IBOutlet fileprivate weak var postListTableView: UITableView!
    
    fileprivate var postListDatasource = [PostResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postListPresenter.attach(view: self)
        postListPresenter.getPostList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Storyboard.PostList.showPostDetail,
            let destination = segue.destination as? PostDetailViewController,
            let selectedRow = postListTableView.indexPathForSelectedRow?.row {
            destination.post = postListDatasource[selectedRow]
        }
    }
}

extension PostListViewController: PostListView {
    func setPostList(_ posts: [PostResponse]) {
        postListDatasource.removeAll()
        posts.forEach { post in
            postListDatasource.append(post)
            postListTableView.beginUpdates()
            postListTableView.insertRows(at: [IndexPath(row: postListDatasource.count-1, section: 0)], with: .automatic)
            postListTableView.endUpdates()
        }
    }
}

extension PostListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postListDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.PostList.postListCell,
                                                 for: indexPath) as! PostListTableViewCell
        cell.post = postListDatasource[indexPath.row]
        return cell
    }
}

