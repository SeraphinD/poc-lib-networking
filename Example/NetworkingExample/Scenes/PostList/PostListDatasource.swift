//
//  PostListDatasource.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 29/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation
import UIKit

final class PostListDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var dataSource = [PostResponse]()
    
    var selectedRow: Int? {
        return tableView.indexPathForSelectedRow?.row
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.PostList.postListCell,
                                                 for: indexPath) as! PostListTableViewCell
        cell.post = dataSource[indexPath.row]
        return cell
    }
    
    func insertAllPosts(_ posts: [PostResponse]) {
        dataSource.removeAll()
        posts.forEach { post in
            dataSource.append(post)
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: dataSource.count-1, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
    }
}
