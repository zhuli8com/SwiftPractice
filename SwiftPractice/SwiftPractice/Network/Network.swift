//
//  Network.swift
//  SwiftPractice
//  https://lvwenhan.com/ios/456.html
//
//  Created by lizhu on 15/11/11.
//  Copyright © 2015年 zhuli. All rights reserved.
//

import Foundation

extension Network:CustomStringConvertible, CustomDebugStringConvertible {
    //
    var description:String{
        return "Network遵循CustomStringConvertible"
    }
    
    var debugDescription:String{
        return "Network遵循CustomDebugStringConvertible"
    }
}

class Network {
    static func request(method:String, url:String, params:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>(), callback:(data:NSData?,response:NSURLResponse?,error:NSError?) -> Void){
        let session=NSURLSession.sharedSession()
        
        var newURL=url
        
        if method=="GET"{
            newURL+="?"+Network().buildParams(params)
        }
        
        let request=NSMutableURLRequest(URL: NSURL(string: newURL)!)
        request.HTTPMethod=method
        
        if method == "POST" {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = Network().buildParams(params).dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        let task=session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            callback(data: data,response: response,error: error)
        }
        
        task.resume()
    }
    
    func buildParams(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sort(<){
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joinWithSeparator("&")
    }
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
}
