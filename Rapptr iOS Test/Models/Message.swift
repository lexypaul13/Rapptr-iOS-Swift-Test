//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct MessageResponse: Codable {
    let messages: [Message]
    enum CodingKeys: String, CodingKey {
        case messages = "data"
    }
}

struct Message:Codable {
    let user_id:String
    let name: String
    let avatarURL: String
    let message: String
    enum CodingKeys: String, CodingKey {
        case user_id = "user_id", name, avatarURL = "avatar_url", message
    }
}




