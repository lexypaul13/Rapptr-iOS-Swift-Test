//
//  Message.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

struct MessageResponse: Codable {
    let messages: [Message]
}

struct Message:Codable {
    
    var userID: String
    var username: String
    var avatarURL: String
    var text: String
    var messages:[String] = []
   
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username = "name"
        case avatarURL = "avatar_url"
        case messages = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userID = try values.decodeIfPresent(String.self, forKey: .userID) ?? ""
        username = try values.decodeIfPresent(String.self, forKey: .username) ?? ""
        avatarURL = try values.decodeIfPresent(String.self, forKey: .avatarURL) ?? ""
        text = try values.decodeIfPresent(String.self, forKey: .messages) ?? ""
       
        for message in messages{
            let chatInfo =  try values.decodeIfPresent(String.self, forKey: Message.CodingKeys(rawValue:message)!)
            messages.append(chatInfo ?? "")
        }
    }
        
    
    
    
    
    
//    init(testName: String, withTestMessage message: String) {
//        self.userID = 0
//        self.username = testName
//        self.avatarURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Smiley.svg/220px-Smiley.svg.png")
//        self.text = message
//    }
}


