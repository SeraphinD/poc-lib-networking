//
//  PostListTableViewCell.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 22/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import UIKit

final class PostListTableViewCell: UITableViewCell {

    var post: PostResponse! {
        didSet {
            textLabel?.text = post.title
        }
    }
}
