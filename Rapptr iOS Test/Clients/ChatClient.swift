//
//  ChatClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
 *
 */

class ChatClient {
    
    static let shared = ChatClient()
    
    private init(){}
    
 
    func getMessages(completed:@escaping(MessageResponse?)->Void){
        guard let url =  URL(string: CHAT_URL) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                print(error.debugDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode==200 else {
                print(error.debugDescription)
                return
            }
            
            guard let data = data else{
                print(error.debugDescription)
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode(MessageResponse.self, from: data)
                completed(apiResponse)
                
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}

