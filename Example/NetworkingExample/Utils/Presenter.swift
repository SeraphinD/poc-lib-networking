//
//  Presenter.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 28/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

import Foundation
import UIKit

protocol Presenter {
    associatedtype V
    var delegate: V? { get set }
}

extension Presenter {
    var dataManager: DataManager {
        return (UIApplication.shared.delegate as! AppDelegate).dataManager
    }
}
