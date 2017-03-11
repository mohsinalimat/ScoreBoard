//
//  SBRequestManager.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class SBHTTPRequest: NSObject {

    //====================================================================================================================================
    // POST REQUEST METHOD
    //====================================================================================================================================
    
    class func postServerRequest(urlString:String, paramString:String?) -> NSMutableURLRequest {
        
        let requestURL = URL(string:urlString)!
        let request = NSMutableURLRequest(url:requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = paramString?.data(using: String.Encoding.utf8)
        
        return request
    }
    
    //====================================================================================================================================
    // GET REQUEST METHOD
    //====================================================================================================================================
    
    class func getServerRequest(urlString:String, paramString:String?) -> NSMutableURLRequest {
        
        var URLString : String = urlString
        if paramString != nil {
            URLString = String(format:"%@?%@", urlString, paramString!)
        }
        let requestURL = URL(string:URLString)!
        let request = NSMutableURLRequest(url:requestURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"        
        return request
    }
    
}
