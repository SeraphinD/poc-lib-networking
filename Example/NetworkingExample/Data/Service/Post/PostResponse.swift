//
//  PostResponse.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 07/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

// Generated using : https://app.quicktype.io/

// To parse the JSON, do: let postResponse = try PostResponse(json)

import Foundation

final class PostResponse: NSObject, Codable {
    let userID, id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
    
    init(userID: Int, id: Int, title: String, body: String) {
        self.userID = userID
        self.id = id
        self.title = title
        self.body = body
    }
}

// MARK: Convenience initializers

extension PostResponse {
    convenience init(data: Data) throws {
        let me = try JSONDecoder().decode(PostResponse.self, from: data)
        self.init(userID: me.userID, id: me.id, title: me.title, body: me.body)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
