//
//  LoginClient.swift
//  Rapptr iOS Test
//
//  Created by Ethan Humphrey on 8/11/21.
//

import Foundation

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev.rapptrlabs.com/Tests/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'email' and 'password'
 *
 * 4) email - info@rapptrlabs.com
 *   password - Test123
 *
 */


class LoginClient{
    
    
    static func getPostString(params:[String:Any]) -> String{ //Converta dictionary into jsonString
        var data = [String]()
        for(key, value) in params{
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    
    static func callPost(url:URL, params:[String:Any], completed:@escaping (String) -> Void, error errorHandler: @escaping (String?) -> Void){ //Performs post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)
        
        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if(error != nil){
                result.message = "Fail Error not null : \(error.debugDescription)"
                errorHandler(result.message)
            }
            else{
                result.message = "Success"
                result.data = data
                let json = try? JSONSerialization.jsonObject(with: data!) as? Dictionary<String, AnyObject>
                completed(jsonToString(json: json as Any))
                
            }
            
            
        }
        task.resume()
    }
}

func jsonToString(json: Any) -> String{ //Convert Json into String
    do {
        let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        let convertedString = String(data: data1, encoding: String.Encoding.utf8)
        print(convertedString)
        return convertedString ?? ""
        
    } catch let myJSONError {
        print(myJSONError)
    }
    return ""
}


