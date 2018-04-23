//
//  PostResponse.swift
//  NetworkingExample
//
//  Created by Seraphin DESUMEUR on 07/04/2018.
//  Copyright © 2018 Seraphin DESUMEUR. All rights reserved.
//

// Generated using : https://app.quicktype.io/

import Foundation

struct PostResponse: Hashable, Codable {
    let userID, id: Int
    let title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

// MARK: Convenience initializers

extension PostResponse {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(PostResponse.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
