//
//  Presenter.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 22/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

protocol Presenter {
    associatedtype V
    var view: V? { get set }
    mutating func attach(view: V)
    mutating func detach()
}

extension Presenter {
    mutating func attach(view: V) {
        self.view = view
    }
    mutating func detach() {
        view = nil
    }
}
